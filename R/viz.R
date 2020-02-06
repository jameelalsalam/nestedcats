#viz.R

#' Default dendrogram for visualizing nested categories
#'
#' @param g graph of nested categories (igraph, tidygraph, others?)
#'
#' @import ggraph
#' @import dplyr
#' @import tidygraph
#' @export
viz_cats_ggraph_tree <- function(g) {

  ggraph_tree <- g %>%
    as_tbl_graph() %>%
    mutate(leaf = node_is_leaf(), root = node_is_root()) %>%
    ggraph(layout = 'tree') +
    geom_edge_diagonal() +
    geom_node_point(aes(filter = leaf), colour = 'forestgreen', size = 20) +
    geom_node_point(aes(filter = root), colour = 'firebrick', size = 20) +
    geom_node_text(aes(label = name)) +
    theme_graph()

  ggraph_tree
}


#' Visualize nested categories as a collapsible tree
#'
#' @return html widget, I think
#' @export
viz_cats_collapsible_tree <- function(g) {

  collapsible_tree <- g %>%
    igraph::as_data_frame(what = "edges") %>%
    graph_convert_edgelistdf_to_parentdf() %>%
    collapsibleTree::collapsibleTreeNetwork()

  collapsible_tree
}


# viz_cats_tree_table -- would use kableExtra type table...

# viz_cats_venn_diagram -- ??

# viz_cats_dag ??
