#' Write data
#'
#' @name write
#' @aliases write
#'
#' @param name (character) A database name
#' @param data data to write
#' @param ... Further args passed on to \code{\link[httr]{POST}}
#'
#' @return Logical or a list, see Methods for what each returns
#'
#' @section Methods:
#' \itemize{
#'  \item write: create a database
#' }
#'
#' @examples \dontrun{
#' # make a client
#' (cli <- flux())
#'
#' # create a database
#' cli$db_create(name = "thoughts")
#'
#' # write data
#' x <- 'cpu_load_short,host=server01,region=us-west value=0.64 1434055562000000000'
#' cli$write(name = "thoughts", data = x, config = verbose())
#' }
NULL

# x <- 'cpu_load_short,host=server01,region=us-west value=0.64 1434055562000000000'
# file <- tempfile(fileext = ".txt")
# writeLines(x, con = file)
# res <- POST(
#   "http://localhost:8086/write",
#   query = list(db = "thoughts"),
#   body = upload_file(file),
#   encode = "multipart",
#   verbose())
# res$status_code
# content(res)
#x <- "curl -i -XPOST 'http://localhost:8086/write?db=thoughts' --data-binary 'cpu_load_short,host=server01,region=us-west value=0.64 1434055562000000000'"
