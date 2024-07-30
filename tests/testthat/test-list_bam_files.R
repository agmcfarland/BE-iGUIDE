testthat::test_that("list_bam_files works", {

  bam_list <- list_bam_files(base_directory = testthat::test_path('testdata'))

  testthat::expect_equal(length(bam_list), 1)

  testthat::expect_equal(bam_list[1], 'tests/testthat/testdata/process_data/align/GTSP5614-neg-3.bin2.bam')

})
