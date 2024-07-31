test_that("calculate_base_percentages works", {

  df_aln_pos_filtered_expected <- readRDS(testthat::test_path('testdata', 'df_aln_pos_filtered_example.rds'))

  df_base_percentages <- calculate_base_percentages(
    df_aln_pos = readRDS(testthat::test_path('testdata', 'df_aln_pos_example.rds')),
    edit_site_strand = '+',
    edit_site_position = 198706754,
    bases_from_cut_site = 20
  )

  testthat::expect_equal(nrow(df_base_percentages), nrow(df_aln_pos_filtered_expected))

  testthat::expect_equal(ncol(df_base_percentages), ncol(df_aln_pos_filtered_expected))


})
