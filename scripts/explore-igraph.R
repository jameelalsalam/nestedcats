# explore igraph

library(igraph)
library(tidyverse)


# constructors

adj_list_tibble <- tribble(
  ~from, ~to,
  1L, 2L,
  1L, 3L,
  2L, 3L,
  2L, 4L,
  3L, 5L
)

adj_matrix <- matrix(
  data = c(FALSE, TRUE, TRUE, FALSE, FALSE,
           TRUE, FALSE, TRUE, TRUE, FALSE,
           TRUE, TRUE, FALSE, FALSE, TRUE,
           FALSE, TRUE, FALSE, FALSE, FALSE,
           FALSE, FALSE, TRUE, FALSE, FALSE),
  byrow = TRUE, ncol = 5
)

bull <- make_graph("bull")
mb1 <- graph(edges = c(1, 2, 1, 3, 2, 3, 2, 4, 3, 5), directed = FALSE)
mb2 <- make_graph(edges =  c(1, 2, 1, 3, 2, 3, 2, 4, 3, 5), directed = FALSE)
mb3 <- graph_from_data_frame(adj_list_tibble, directed = FALSE)
mb4 <- graph_from_adjacency_matrix(adj_matrix, mode = "undirected")
mb5 <- graph_from_edgelist(as.matrix(adj_list_tibble), directed = FALSE)

plot(mb3)


identical_graphs(mb1, mb2) # graph & make_graph
identical_graphs(mb1, mb3)
identical_graphs(mb1, mb4) # ... & graph_from_adjacency_matrix
identical_graphs(mb1, mb5) # ... & graph_from_edgelist
identical_graphs(bull, mb1)

identical_graphs(bull, mb3)
identical_graphs(bull, mb4)

attributes(bull)
attributes(mb1)

as_edgelist(bull)
as_edgelist(mb1)
identical(as_edgelist(bull), as_edgelist(mb1))
identical(as_edgelist(bull), as_edgelist(mb2))
identical(as_edgelist(bull), as_edgelist(mb3))
identical(as_edgelist(bull), as_edgelist(mb4))
identical(as_edgelist(bull), as_edgelist(mb5))

map(list(bull, mb1, mb2, mb3, mb4, mb5), as_edgelist)
map(list(bull, mb1, mb2, mb3, mb4, mb5), as_adj)
map(list(bull, mb1, mb2, mb3, mb4, mb5), as_adj_edge_list)
map(list(bull, mb1, mb2, mb3, mb4, mb5), as_adjacency_matrix)

E(bull)
V(bull)
E(mb3)
V(mb3)

names(mb3)
names(V(mb3))
attributes(V(mb3))

names(V(mb3)) <- NULL
