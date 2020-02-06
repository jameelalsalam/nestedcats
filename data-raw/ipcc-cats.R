# ipcc-cats.R

library(tidyverse)
library(igraph)

ipcc_nodes_raw <- readr::read_csv("data-raw/ipcc_cats.csv") %>%
  rename(descr = name, name = code)

ipcc_edges <- ipcc_nodes_raw %>%
  mutate(code_series = str_extract_all(
    name, "(\\d)|([:upper:])|([iv]+)|([:lower:])")) %>%
  mutate(
    segments = map_int(code_series, ~length(.x)),
    parent = map_chr(
      code_series,

      function(cs) {
        if (length(cs) == 1) NA_character_ else {
          paste0(cs[1:(length(cs)-1)], collapse = "")
        }
      }
    )) %>%
  rename(from = parent, to = name) %>%
  select(from, to) %>%
  filter(!is.na(from)) %>%
  bind_rows(tribble(
    ~from, ~to,
    "all", "1",
    "all", "2",
    "all", "3",
    "all", "4",
    "all", "5"
  ))

ipcc_cats <- graph_from_data_frame(ipcc_edges)
usethis::use_data(ipcc_cats, overwrite = TRUE)
