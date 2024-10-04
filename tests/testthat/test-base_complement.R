testthat::test_that("base_complement works", {
  # Check correct complement
  testthat::expect_equal(base_complement('A'), 'T')
  testthat::expect_equal(base_complement('C'), 'G')
  testthat::expect_equal(base_complement('T'), 'A')
  testthat::expect_equal(base_complement('G'), 'C')
  testthat::expect_equal(base_complement('N'), 'N')

  # Check correct error catching
  testthat::expect_error(base_complement('X'), 'Input must be single character either A, T, G, C, or N')
  testthat::expect_error(base_complement('AA'), 'Input must be single character either A, T, G, C, or N')

})
