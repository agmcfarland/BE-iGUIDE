testthat::test_that("list_bam_files works", {

  subsetted_test_data_path <- testthat::test_path('testdata', 'integration_1')

  bam_list <- list_bam_files(base_directory = subsetted_test_data_path)

  testthat::expect_equal(length(bam_list), 6)

})
