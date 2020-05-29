#' Low-level constructor for Partially Ordered Factors `pofct` S3 class
#'
#' @param x integer vector to index into levels and partial order
#' @param levels character vector of labels
#' @param partial_order an edges data frame representing the partial order.
#'
#' The partial order is a data frame of edges (e.g., with integer columns `from` and `to`).
#' Each edge represents a has-subset relation, e.g. `to` <= `from`, which is sort of a fat arrow.
#'
#' @import vctrs
#' @import tibble
#' @export
#' @examples
#' new_pofct(c(1L, 2L, 3L), levels = c("whole", "part1", "part2"),
#'   partial_order = tibble(from = c(1L, 1L), to = c(2L, 3L)))
new_pofct <- function(x = integer(),
                      levels = character(),
                      partial_order = tibble()) {
  vec_assert(x, integer())
  stopifnot(is.character(levels))
  stopifnot(inherits(partial_order, "data.frame"))

  po <- igraph::graph_from_data_frame(partial_order)

  new_vctr(
    x,
    levels = levels,
    po = po,
    class = "pofct"
  )
}

#' Format S3 method
#'
#' @export
format.pofct <- function(x) {
  attr(x, "levels")[x]
  # attr(x, "po")
  # also need to figure out how to include graph info
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
