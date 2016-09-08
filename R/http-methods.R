flux_GET <- function(url, args, ...) {
  if (length(args) == 0) args <- NULL
  res <- GET(url, query = args, ...)
  if (res$status_code > 204) {
    stop(content(res)$message, call. = FALSE)
  }
  contutf8(res)
}

flux_PUT <- function(url, value, ttl=NULL, dir=FALSE, file=NULL, ...){
  if (missing(value) && is.null(file)) {
    res <- PUT(url, query = list(dir = TRUE), ...)
  } else {
    args <- fc(list(ttl = ttl, dir = dir))
    if (length(args) == 0) args <- NULL

    if (is.null(file)) {
      res <- PUT(url, body = list(value = value), query = args, encode = "form", ...)
    } else {
      stop("not working yet from files", call. = FALSE)
      # res <- PUT(url, body = list(value = upload_file(file)), query = args, encode = "form", ...)
    }
  }
  stop_for_status(res)
  contutf8(res)
}

flux_POST <- function(url, args, ...) {
  res <- POST(url, ...)
  stop_for_status(res)
  contutf8(res)
}

flux_DELETE <- function(url, args, ...) {
  if (length(args) == 0) args <- NULL
  res <- DELETE(url, query = args, ...)
  if (res$status_code > 201) {
    warning(content(res)$message, call. = FALSE)
    content(res)
  }
  contutf8(res)
}
