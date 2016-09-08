fc <- function(x) Filter(Negate(is.null), x)

pluck <- function(x, name, type) {
  if (missing(type)) {
    lapply(x, "[[", name)
  } else {
    vapply(x, "[[", name, FUN.VALUE = type)
  }
}

`%||%` <- function(a, b) if (is.null(a)) b else a

unbox <- function(x) {
  if (is.null(x)) x else jsonlite::unbox(x)
}

al <- function(x){
  stopifnot(is.logical(x))
  if (x) 'true' else 'false'
}

cn <- function(x, y) if (nchar(y) == 0) y else paste0(x, y)

strExtract <- function(str, pattern) regmatches(str, regexpr(pattern, str))

strTrim <- function(str) gsub("^\\s+|\\s+$", "", str)

flux_parse <- function(x, simplify=FALSE){
  jsonlite::fromJSON(x, simplify)
}

contutf8 <- function(x) {
  content(x, "text", encoding = "UTF-8")
}

esc <- function(x) {
  if (is.null(x)) {
    NULL
  } else {
    curl::curl_escape(x)
  }
}
