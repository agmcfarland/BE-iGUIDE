testthat::test_that("pull_combo_overview_table works", {

  subsetted_test_data_path <- testthat::test_path('testdata', 'integration_1')

  df_combo_overview <- pull_combo_overview_table(base_directory = subsetted_test_data_path)

  testthat::expect_equal(2, nrow(df_combo_overview))

  testthat::expect_equal(7, ncol(df_combo_overview))

})
