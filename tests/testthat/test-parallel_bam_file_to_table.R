test_that("parallel_bam_file_list_to_table works", {

  subsetted_test_data_path <- testthat::test_path('testdata', 'integration_1')

  bam_file_path <- file.path(subsetted_test_data_path, 'process_data', 'align', 'GTSP5610-neg-1.bin1.bam')

  file.exists(bam_file_path)

  df_bam <- parallel_bam_file_list_to_table(bam_file_path)

  testthat::expect_equal(nrow(df_bam), 398787)

  testthat::expect_equal(ncol(df_bam), 10)

})
