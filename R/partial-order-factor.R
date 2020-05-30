#' Low-level constructor for Partially Ordered Factors `pofct` S3 class
#'
#' @param x integer vector to index into levels and partial order
#' @param po an edges data frame representing the partial order.
#'
#' The partial order is a data frame of edges (e.g., with integer columns `from` and `to`).
#' Each edge represents a has-subset relation, e.g. `to` <= `from`, which is sort of a fat arrow.
#'
#' @import vctrs
#' @import tibble
#' @export
#' @examples
#' new_pofct(c("whole", "part1", "part2"), po = tibble(from = c("whole", "whole"), to = c("part1", "part2")))
new_pofct <- function(x = character(),
                      po = tibble(from = character(), to = character())) {
  vec_assert(x, character())
  stopifnot(inherits(po, "data.frame"))

  po <- igraph::graph_from_data_frame(po)

  new_vctr(
    x,
    po = po,
    class = "pofct"
  )
}

# implementing simple factor in vctrs s3: https://github.com/r-lib/vctrs/issues/82

#' Format S3 method
#'
#' @export
format.pofct <- function(x) {
  vec_data(x)
}

#' @export
obj_print_footer.pofct <- function(x, ...) {
  # need to figure out how to hook this in
  # attr(x, "po")
  rels <- glue::glue_data(
    igraph::as_data_frame(attr(x, "po"), "edges"),
    "{to} <= {from}") %>%
    glue::glue_collapse(", ")

  cat("Nesting: ", rels)
}

#' Helper for more convenient partial order factor creation
#'
#' @param x the values
#' @param levels optional character vector, mostly for ordering.
#' @param po tibble representing partial order with symbolic columns `from` and `to`
#' @export
#' @examples
#' pofct(c("fruit", "apples", "bananas"), po = tibble(from=c("fruit", "fruit"),to=c("apples", "bananas")))
pofct <- function(x = character(), po = tibble(from = character(), to = character())) {

  x <- vec_cast(x, character())

  # edge_df prep
  po <- vec_cast(po, tibble(from=character(), to=character()))
  po <- po[1:2]

  new_pofct(x, po)
}

#' Validate pofct S3 class
#'
validate_pofct <- function(x) {

}


# Coerciion and casting -----------------------------------------------------

#' @method vec_ptype2 pofct
#' @export
vec_ptype2.pofct <- function(x, y, ...) {
  UseMethod("y")
}

#' @export
vec_ptype2.pofct.pofct <- function(x, y, ...) {
  pofct()
  # join the graphs...
}

#' @method vec_ptype2.pofct character
#' @export
vec_ptype2.pofct.character <- function(x, y, ...) y

#' @method vec_ptype2.character pofct
#' @export
vec_ptype2.character.pofct <- function(x, y, ...) x

#' @method vec_ptype2.pofct factor
#' @export
vec_ptype2.pofct.factor <- function(x, y, ...) x

#' @method vec_ptype2.factor pofct
#' @export
vec_ptype2.factor.pofct <- function(x, y, ...) y



#' @export
vec_cast.pofct.pofct <- function(x, to, ...) {
  x
}

# factor -> pofct
#' @export
vec_cast.pofct.factor <- function(x, to, ...) {
  x
}

# pofct -> chr
#' @export
vec_cast.character.pofct <- function(x, to, ...) {
  vec_data(x)
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
