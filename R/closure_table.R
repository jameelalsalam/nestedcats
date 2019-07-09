# generate closure table
# a closure table has the following columns:
# ancestor: node id's
# descendants: node id's
# length: 0 if same, otherwise number of hops from adjacency list

# slide background on options
# https://www.slideshare.net/billkarwin/models-for-hierarchical-data

#' Make a closure table from an adjacency list
#'
#' @examples
#' alist <- tibble::tibble(parent = c(1, 2, 2), child = c(2, 3, 4))
#' closure_table(alist)
closure_table <- function(adj_list,
                          parent_col = "parent",
                          child_col = "child") {

  # generate self-connections
  self_cons <- bind_rows(
    select(adj_list, anc = parent),
    select(adj_list, anc = child)
  ) %>%
    distinct(anc) %>%
    mutate(desc = anc, length = 0)

  # generate one-hops
  one_hops <- adj_list %>%
    select(anc = parent, desc = child) %>%
    dplyr::anti_join(self_cons, by = c("anc", "desc")) %>%
    mutate(length = 1)

  clsr_tbl <- bind_rows(
    self_cons,
    one_hops
  )

  no_more_to_add_flag <- FALSE
  next_len <- 2

  while (! no_more_to_add_flag) {

    new_entries <- clsr_tbl %>%
      inner_join(adj_list, by = c("desc" = "parent")) %>%
      select(anc, desc = child) %>%
      anti_join(clsr_tbl, by = c("anc", "desc")) %>%
      mutate(length = next_len)

    clsr_tbl <- bind_rows(
      clsr_tbl, new_entries
    )

    no_more_to_add_flag <- (nrow(new_entries) == 0)
    next_len <- next_len + 1

  }

  clsr_tbl
}

