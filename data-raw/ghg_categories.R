## code to prepare `ghg_categories` dataset goes here

library(tidyverse)
library(tidygraph)
library(ggraph)

ghg_nodes_df <- read_csv("data-raw/ghg_cats_nodes.csv") %>%
  rename(id = name)

ghg_edges_df <- read_csv("data-raw/ghg_cats_edges.csv")

ghg_tg <- tbl_graph(nodes = ghg_nodes_df,
                    edges = ghg_edges_df) %>%
  activate(nodes) %>%
  mutate(lbl = glue::glue("id: {id}")) %>%
  mutate(leaf = node_is_leaf(),
         root = node_is_root())

ghg_tg
x <- as_tibble(ghg_tg)
print(x, n = 5)

# root red, leafs green, labeled nodes -- layout requires directed edges away from the root.
ghg_tg %>%
  mutate(leaf = node_is_leaf(), root = node_is_root()) %>%
  ggraph(layout = 'tree') +
  geom_edge_diagonal() +
  geom_node_point(aes(filter = leaf, label = id), colour = 'forestgreen', size = 20) +
  geom_node_point(aes(filter = root, label = id), colour = 'firebrick', size = 20) +
  geom_node_text(aes(label = id)) +
  theme_graph()


usethis::use_data(ghg_tg)
