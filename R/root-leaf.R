#root-leaf

#' Filter a closure table for the root-to-leaf connections only
#'
#' @export
#' @examples
#' alist <- tibble::tibble(parent = c(1, 2, 2), child = c(2, 3, 4))
#' clsr <- closure_table(alist)
#' filter_root_leaf(clsr)
filter_root_leaf <- function(clsr_tbl) {

  anc_nodes <- clsr_tbl %>%
    filter(anc != desc) %>%
    distinct(anc)

  longest_chains <- clsr_tbl %>%
    group_by(desc) %>%
    arrange(desc(length)) %>%
    slice(1) %>%
    ungroup()

  # no ancestors in the 'descendant' field
  anti_join(longest_chains, anc_nodes, by = c("desc" = "anc"))
}
