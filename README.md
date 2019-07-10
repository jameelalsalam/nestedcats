# nestedcats

Manipulate nested categorical data in a tidy way, building off of dplyr, tidygraph, and igraph

This package aims to make it possible to store and manipulate rich hierarchical category information and do split-apply-combine operations on these categories.

```
cat_tree <- tibble::tibble(
  parent = c(NA_character, "1", "1", "1a", "1a"),
  child = c("1", "1a", "1b", "1a1", "1a2"")
) %>% as_closure_tbl()

leaf_data <- tibble::tibble(
  cat = c("1b", "1a1", "1a2"),
  value = c(1, 2, 3)
)

leaf_data %>%
  group_by_cats(cat = c("1a", "1b"), along = cat_tree) %>%
  summarize(value = sum(value, na.rm = TRUE))

verify_covers(c("1a", "1b"), over = cat_tree)
verify_disjoint(c("1a", "1b"), along = cat_tree)
verify_disjoint_covers(c("1a", "1b"), along = cat_tree)

all.equal(coverage(c("1a", "1b"), along = cat_tree),
          coverage("1", along = cat_tree))
        
```

# Key Terms:

Tree data structure: https://en.wikipedia.org/wiki/Tree_(data_structure)
Containment order: https://en.wikipedia.org/wiki/Containment_order
Covering relation: https://en.wikipedia.org/wiki/Covering_relation
Disjoint sets: https://en.wikipedia.org/wiki/Disjoint_sets
Partially ordered set: https://en.wikipedia.org/wiki/Partially_ordered_set
