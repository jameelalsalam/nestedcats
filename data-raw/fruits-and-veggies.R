# fruits-and-veggies.R

library(tidyverse)
library(igraph)
library(ggraph)
library(nestedcats)

fruits_and_veggies_edges <- readr::read_csv("data-raw/fruits-and-veggies-categories.csv")

fruits_veggies_cats <- graph_from_data_frame(fruits_and_veggies_edges)

ggraph(fruits_veggies, layout = "sugiyama") +
  geom_edge_diagonal(color = "blue") +
  geom_node_text(aes(label = name))

usethis::use_data(fruits_veggies_cats, overwrite = TRUE)
