# partial orders

# a DAG can define a <= relationship as a partial order, Hasse diagram, etc.

# Ideal input could handle a compact text specification
# A < B < C < E
# B < D < E

# one approach might be to use vctrs to define a custom vector type which is factor-like in that there is a partial order associated with the vector which defines how the comparisons would be done. Then attach s3 methods for comparisons, perhaps not unlike ordered factors? For that matter, how do ordered factors work?

library(forcats)

cat_lvls <- c("2A", "2B", "1A", "1B", "2", "1", "Total")

f1 <- factor(
  c("1", "1A", "1B", "2A", "2"),
  levels = cat_lvls,
  ordered = TRUE
)

f2 <- factor(
  c("2", "Total", "1", "2B", "2A"),
  levels = cat_lvls,
  ordered = TRUE
)

f3 <- factor(
  c("2", "Total", "1", "2B", "2A"),
  levels = c(cat_lvls, "3"),
)

f4 <- factor(
  c("2", "Total", "1", "2B", "2A"),
  levels = sample(cat_lvls, 7),
  ordered = TRUE
)

f1 < f2
f2 < f1

f1 < f3
f1 < f4

f1 <- factor(
  c("1", "1A", "1B", "2A", "2"),
  levels = cat_lvls,
  ordered = TRUE
)

f2 <- factor(
  c("2", "Total", "1", "2B", "2A"),
  levels = cat_lvls,
  ordered = TRUE
)

f3 <- factor(
  c("2", "Total", "1", "2B", "2A"),
  levels = c(cat_lvls, "3"),
)

f4 <- factor(
  c("2", "Total", "1", "2B", "2A"),
  levels = sample(cat_lvls, 7),
  ordered = TRUE
)


library(igraph)

cats_1 <- make_graph(
  c("1", "Total",
    "2", "Total",
    "1A", "1"),
  directed = TRUE
)

cats_1

cats_2 <- graph_from_literal(
  "1"-+"Total",
  "2"-+"Total",
  "1A"-+"1")

cats_2

identical_graphs(cats_1, cats_2)

cats_1 == cats_2

g <- graph(c("A","B", "B","C"))
h <- graph(c("A","B", "B","C"))
identical_graphs(g, h)
#> [1] TRUE

j <- graph(~A-B-C)
identical_graphs(g, j)

g
h
j


gr1 <- graph(c("A", "B"))
gr2 <- graph(~A-+B)
identical_graphs(gr1, gr2)

gr2 <- graph(~"A"-"B")
identical_graphs(gr1, gr2)

gr3 <- graph(~A-B)
gr4 <- graph(~A-B)
identical_graphs(gr3, gr4)
gr1
gr2
vertices(gr1)
vertices(gr2)
all.equal(vertices(gr1), vertices(gr2))
