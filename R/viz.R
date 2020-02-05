#viz.R

#' Default dendrogram for visualizing nested categories
#'
#' @import ggraph
#' @import dplyr
#' @export
ggraph_nestedcats_tree <- function(g) {

  g %>%
    mutate(leaf = node_is_leaf(), root = node_is_root()) %>%
    ggraph(layout = 'tree') +
    geom_edge_diagonal() +
    geom_node_point(aes(filter = leaf), colour = 'forestgreen', size = 20) +
    geom_node_point(aes(filter = root), colour = 'firebrick', size = 20) +
    geom_node_text(aes(label = name)) +
    theme_graph()
}
