#' fluxy client
#'
#' @export
#' @param host (character) Host url. Default: 127.0.0.1
#' @param path (character) URL path. Default: NULL/none
#' @param port (character/numeric) Port. Default: 8086
#' @param scheme (character) http scheme, one of http or https. Default: http
#'
#' @return Various output, see help files for each grouping of methods.
#'
#' @details \code{flux} creates a R6 class object. The object is
#' not cloneable and is portable, so it can be inherited across packages
#' without complication.
#'
#' \code{flux} is used to initialize a client that knows about your etcd
#' instance, with options for setting host, port, etcd api version,
#' whether to allow redirects, and the http scheme.
#'
#' @section flux methods:
#' \strong{Methods}
#'   \describe{
#'     \item{\code{ping()}}{
#'      ping the InfluxDB server
#'     }
#'     \item{\code{version()}}{
#'      check the InfluxDB version
#'     }
#'     \item{\code{keys()}}{
#'      list keys, see also \code{\link{keys}}
#'     }
#'   }
#'
#' @examples \dontrun{
#' # make a client
#' (cli <- flux())
#'
#' # ping
#' ## ping to make sure it's up
#' cli$ping()
#'
#' # etcd variables
#' cli$host
#' cli$port
#' cli$scheme
#'
#' # set a different host
#' flux(host = 'stuff.com')
#'
#' # set a different port
#' flux(host = 3456)
#'
#' # set a different http scheme
#' flux(scheme = 'https')
#' }
flux <- function(host = "127.0.0.1", port = 8086, scheme = 'http') {
  FluxClient$new(host = host, port = port, scheme = scheme)
}

#' @importFrom R6 R6Class
FluxClient <- R6::R6Class(
  "FluxClient",
  portable = TRUE,
  cloneable = FALSE,
  public = list(
    host = "127.0.0.1",
    port = 8086,
    scheme = 'http',

    initialize = function(host, port, scheme) {
      if (!missing(host)) self$host <- host
      if (!missing(port)) self$port <- port
      if (!missing(scheme)) self$scheme <- scheme
    },

    print = function(...) {
      cat('<fluxy client>', sep = "\n")
      cat(paste0('  host: ', self$host), sep = "\n")
      cat(paste0('  port: ', self$port), sep = "\n")
      cat(paste0('  scheme: ', self$scheme), sep = "\n")
    },

    ping = function(...) {
      res <- GET(file.path(private$make_url(), "ping"), ...)
      if (res$status_code == 204) {
        TRUE
      } else {
        stop_for_status(res)
      }
    },

    db_create = function(name, ...) {
      flux_parse(
        flux_POST(
          file.path(private$make_url(), "query"),
          list(q = paste0('CREATE DATABASE ', esc(name))),
          ...
        )
      )
    },

    write = function(name, data, ...) {
      flux_parse(
        flux_POST(
          file.path(private$make_url(), "write"),
          query = list(db = name),
          body = data,
          ...
        )
      )
    },

    db_show = function(...) {
      flux_parse(
        flux_GET(
          file.path(private$make_url(), "query"),
          list(q = "SHOW DATABASES"),
          ...
        ),
        TRUE
      )
    }
  ),

  private = list(
    make_url = function() {
      sprintf("%s://%s:%s", self$scheme, self$host, self$port)
    }
  )
)

# curl -i -XPOST 'http://localhost:8086/write?db=mydb' --data-binary 'cpu_load_short,host=server01,region=us-west value=0.64 1434055562000000000'
