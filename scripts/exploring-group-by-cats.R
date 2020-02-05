
# standard
leaf_data %>%
  group_by(cat) %>%
  mutate(count = n(), value = sum(value))

# mod
leaf_data %>%
  group_by(cat = str_extract(cat, "\\d[a-g]")) %>%
  summarize(count = n(), value = sum(value))



cross_g <- tibble(
  from = c("CH4", "CH4", "N2O", "N2O", "energy", "energy", "ag", "ag"),
  to   = c("CH4-energy", "CH4-ag", "N2O-energy", "N2O-ag", "CH4-energy", "N2O-energy", "CH4-ag", "N2O-ag")
) %>%
  as_tbl_graph()

cross_d <- tibble(
  name = c("CH4-energy", "CH4-ag", "N2O-energy", "N2O-ag"),
  val = c(1, 2, 3, 4)
)

cross_d %>%
  mutate(cat = in_cats(name, c("CH4", "energy"), cross_g)) %>%
  View()

