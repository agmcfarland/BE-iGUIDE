testthat::test_that("pull_ft_data_tables works", {

  subsetted_test_data_path <- testthat::test_path('testdata', 'integration_1')

  df_ft_data <- pull_ft_data_tables(base_directory = subsetted_test_data_path)

  testthat::expect_equal(5815, nrow(df_ft_data))

  testthat::expect_equal(9, ncol(df_ft_data))

})
