testthat::test_that("pull_ft_data_tables works", {

  df_ft_data <- pull_ft_data_tables(base_directory = testthat::test_path('testdata'))

  testthat::expect_equal(14362, nrow(df_ft_data))

  testthat::expect_equal(9, ncol(df_ft_data))

})
