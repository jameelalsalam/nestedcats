
# library(nestedcats)

test_that("constuction and accessing components", {
  pf <- new_pofct(c("whole", "part1", "part2"),
                  tibble(from = c("whole", "whole"), to = c("part1", "part2")))

  expect_equivalent(pf[1], "whole")
})
