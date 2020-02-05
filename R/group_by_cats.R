# group_by_cats.R

reachable_vertices_vs <- function(g, v) {
  subcomponent(g, v, mode = "out")
}

reachable_vertices_chr <- function(g, v) {
  as_ids(reachable_vertices_vs(g, v))
}

graph_leaves_vs <- function(g) {
  V(cat_g)[degree(cat_g, mode = "out") == 0]
}

graph_leaves_chr <- function(g) {
  as_ids(graph_leaves_vs(g))
}

reachable_leaves_vs <- function(g, v) {
  intersection(
    reachable_vertices_vs(g, v),
    graph_leaves_vs(g)
  )
}

reachable_leaves_chr <- function(g, v) {
  as_ids(reachable_vertices_vs(g, v))
}

#' @examples
#' along <- cat_g
#' .data <- leaf_data
#' cats <- c("1a", "1b")
in_cats <- function(v, cats, g) {

  reach_tbl <- tibble(
   cat = cats,
   v = map(cats, ~reachable_vertices_chr(g, .x))) %>%
    unchop(v)

  list_reachable_v <- reach_tbl %>%
    chop(cat) %>%
    right_join(tibble(v = v), by = "v") %>%
    pull(cat)

  list_reachable_v
}
