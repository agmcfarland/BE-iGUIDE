testthat::test_that("pull_combo_overview_table works", {
  df_combo_overview <- pull_combo_overview_table(base_directory = testthat::test_path('testdata'))

  testthat::expect_equal(15, nrow(df_combo_overview))

  testthat::expect_equal(7, ncol(df_combo_overview))

})
