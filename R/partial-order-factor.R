#' Low-level constructor for Partially Ordered Factors `pofct` S3 class
#'
#' @param x integer vector to index into labels and partial ordering
#' @param levels character vector of levels (labels) for pofct values
#' @param po a data frame representing the partial order
#'
#' The partial order is a data frame of edges (e.g., with integer columns `from` and `to`).
#' Each edge represents a has-subset relation, e.g. `to` <= `from`.
#'
#' @import vctrs
#' @import tibble
#' @export
new_pofct <- function(x = integer(),
                      labels = character(),
                      po = tibble()) {
  vec_assert(x, integer())
  stopifnot(is.character(labels))
  stopifnot(inherits(tibble(), "data.frame"))
}

#' Format S3 method
#'
#' @export
format.pofct <- function(x) {

}

#' Validate pofct S3 class
#'
validate_pofct <- function(x) {

}













# Math and arithmetic -----------------------------------------------------

#' @export
vec_math.pofct <- function(.fn, .x, ...) {
  stop_unsupported(.x, .fn)
}

#' @export
vec_arith.pofct <- function(op, x, y, ...) {
  stop_unsupported(x, op)
}
