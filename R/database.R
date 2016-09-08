#' Databases
#'
#' @name database
#' @aliases db_create
#'
#' @param name (character) A database name
#' @param ... Further args passed on to \code{\link[httr]{POST}}
#'
#' @return Logical or a list, see Methods for what each returns
#'
#' @section Methods:
#' \itemize{
#'  \item db_create: create a database
#' }
#'
#' @examples \dontrun{
#' # make a client
#' (cli <- flux())
#'
#' # make a database
#' cli$db_create(name = "thoughts")
#'
#' # show a database
#' cli$db_show()
#' }
NULL
