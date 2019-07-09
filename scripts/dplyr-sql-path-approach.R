# dplyr only approach

library(tidyverse)

ghg_nodes_df <- read_csv("data-raw/ghg_cats_nodes.csv") %>%
  rename(id = name)

ghg_edges_df <- read_csv("data-raw/ghg_cats_edges.csv")

adj_list <- ghg_edges_df %>%
  rename(ancestor = to, descendant = from) %>%
  select(-type)

materialized_paths <- adj_list %>%
  left_join(adj_list, by = c("descendant" = "ancestor")) %>%
  select(ancestor, descendant = descendant.y) %>%
  bind_rows(adj_list) %>%
  distinct(ancestor, descendant) %>%
  filter(!is.na(descendant)) %>%
  arrange(ancestor, descendant)

self_join_and_prune <- function(.adj_list) {

  # assumes .adj_list has columns `parent` and `child`

  adj_list <- .adj_list %>%
    select(ancestor = parent, descendant = child)

  join_path <- left_join(adj_list, adj_list,
                         by = c("descendant" = "ancestor")) %>%
    select(ancestor, descendant = descendant.y) %>%
    bind_rows(adj_list) %>%
    distinct(ancestor, descendant) %>%
    filter(!is.na(descendant)) %>%
    arrange(ancestor, descendant)

}
