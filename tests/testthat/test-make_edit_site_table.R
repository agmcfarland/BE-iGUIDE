test_that("make_edit_site_table works", {

  df_ft_data <- pull_ft_data_tables(base_directory = testthat::test_path('testdata'))

  df_annotations <- pull_combo_overview_table(base_directory = testthat::test_path('testdata'))

  df_edit_sites <- make_edit_site_table(
    ft_data_table = df_ft_data,
    spec_info_combo_overview_table = df_annotations,
    abundance_cutoff = 3)

  testthat::expect_equal(53, nrow(df_edit_sites))

  testthat::expect_equal(13, ncol(df_edit_sites))


})
