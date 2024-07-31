test_that("parallel_aln_to_base_and_position_table works", {

  df_aln_pos_expected <- readRDS(testthat::test_path('testdata', 'df_aln_pos_example.rds'))

  df_bam_filtered_expected <- readRDS(testthat::test_path('testdata', 'df_bam_filtered_example.rds'))

  df_aln_pos <- parallel_aln_to_base_and_position_tables(df_bam_filtered_expected)

  testthat::expect_equal(nrow(df_aln_pos_expected), nrow(df_aln_pos))

  testthat::expect_equal(ncol(df_aln_pos_expected), ncol(df_aln_pos))


})
