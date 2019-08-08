# format-conversions.R
# Every network package seems to have a slightly different expection about how data is input to create the object. Here are some conveniences for converting between them.

#' Convert a dataframe of edges (from, to) into a parent df (parent, node)
#'
#' @param edges_df a dataframe with 'from' and 'to' columns with node names as values. To be convertible, each node should have a single parent.
#' @returns df with columns 'parent' and 'node' with node names as values
#' @export
#' @examples
#' ghg_edges_df <- read_csv("data-raw/ghg_cats_edges.csv")
#' graph_convert_edgelistdf_to_parentdf(ghg_edges_df)
graph_convert_edgelistdf_to_parentdf <- function(edges_df) {

  # check each node only has at most 1 parent
  if (length(unique(edges_df$to)) != length(edges_df$to)) stop("More edges than 'to' nodes; check that you only have 1 parent per node.")

  node_listing <- union(edges_df$from, edges_df$to)
  root_listing <- setdiff(node_listing, edges_df$to)

  if (length(root_listing) != 1) stop("Must have exactly 1 root node.")

  parent_df <- edges_df %>%
    select(parent = from, node = to) %>%
    bind_rows(tibble(parent = NA, node = root_listing))

  parent_df
}
