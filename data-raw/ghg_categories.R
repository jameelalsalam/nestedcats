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
print(ghg_tg, n = 5)

create_tree(20, 3) %>%
  mutate(leaf = node_is_leaf(), root = node_is_root()) %>%
  ggraph(layout = 'tree') +
  geom_edge_diagonal() +
  geom_node_point(aes(filter = leaf), colour = 'forestgreen', size = 10) +
  geom_node_point(aes(filter = root), colour = 'firebrick', size = 10) +
  theme_graph()

ggraph(ghg_tg, layout = 'circlepack') +
  geom_edge_diagonal(arrow = arrow()) #+
  #geom_node_label(mapping = aes(label = lbl))

ggraph(ghg_tg, layout = 'nicely') +
  geom_edge_diagonal(arrow = arrow()) #+
#geom_node_label(mapping = aes(label = lbl))


usethis::use_data("ghg_categories")
