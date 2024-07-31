test_that("bam_file_to_table works", {


  bam_file_path <- testthat::test_path('testdata', 'process_data', 'align', 'GTSP5614-neg-3.bin2.bam')

  file.exists(bam_file_path)

  df_bam <- bam_file_to_table(bam_file_path)

  testthat::expect_equal(nrow(df_bam), 172)

  testthat::expect_equal(ncol(df_bam), 9)

})
