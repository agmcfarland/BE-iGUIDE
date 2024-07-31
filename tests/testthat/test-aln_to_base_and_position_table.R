test_that("aln_to_base_and_position_table works", {

  df_aln_pos_expected <- readRDS(testthat::test_path('testdata', 'df_aln_pos_example.rds'))

  df_bam_filtered_expected <- readRDS(testthat::test_path('testdata', 'df_bam_filtered_example.rds'))

  df_bam_filtered_expected_nrow <- nrow(df_bam_filtered_expected)

  example1 <- split(df_bam_filtered_expected, base::seq(base::nrow(df_bam_filtered_expected)))[[1]]

  df_aln_pos1 <- aln_to_base_and_position_table(aln = example1)

  testthat::expect_equal(example1$qwidth, nrow(df_aln_pos1))

  example2 <- split(df_bam_filtered_expected, base::seq(base::nrow(df_bam_filtered_expected)))[[2]]

  df_aln_pos2 <- aln_to_base_and_position_table(aln = example2)

  testthat::expect_equal(example2$qwidth, nrow(df_aln_pos2))


  nrow(df_aln_pos_expected %>% dplyr::filter(qname == example1$qname)) == nrow(df_aln_pos1)

  nrow(df_aln_pos_expected %>% dplyr::filter(qname == example2$qname)) == nrow(df_aln_pos2)



})
