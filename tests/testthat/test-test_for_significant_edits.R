test_that("test_for_significant_edits works", {

  # Assuming plus strand, dataset has significant on target edit for position 2. Off-target edit at position 3
  df_test <- rbind(
    data.frame(
      'position' = 1,
      'base' = c('A', 'G'),
      'base_count' = c(900, 20),
      'position_depth' = 1000,
      'reference_base' = 'A'),
    data.frame(
      'position' = 2,
      'base' = c('A', 'G'),
      'base_count' = c(500, 450),
      'position_depth' = 1000,
      'reference_base' = 'A'
      ),
    data.frame(
      'position' = 3,
      'base' = c('G', 'A'),
      'base_count' = c(500, 450),
      'position_depth' = 1000,
      'reference_base' = 'G'
      )
  )

  df_test <- df_test %>%
    dplyr::mutate(percentage = 100 * (base_count/position_depth)) %>%
    dplyr::mutate(
      specimen = 'spm1',
      edit_site_target.seq = 'seq1',
      edit.site = 'chr1:+:1',
      edit_site_strand = '+'
    )

  df_results <- binomial_prop_edit_test(df_test, 0.05, 'greater')

  dfx <- test_for_significant_edits(df_results, editable_base = 'A', expected_edit = 'G')

  testthat::expect_equal(dfx %>% dplyr::filter(base_editing_result == 'on_target') %>% nrow(), 1)
  testthat::expect_equal(dfx %>% dplyr::filter(base_editing_result == 'off_target') %>% nrow(), 1)

  ## Repeat same test but for minus strand
  df_test <- rbind(
    data.frame(
      'position' = 1,
      'base' = c('T', 'C'),
      'base_count' = c(900, 20),
      'position_depth' = 1000,
      'reference_base' = 'T'),
    data.frame(
      'position' = 2,
      'base' = c('T', 'C'),
      'base_count' = c(500, 450),
      'position_depth' = 1000,
      'reference_base' = 'T'
    ),
    data.frame(
      'position' = 3,
      'base' = c('C', 'T'),
      'base_count' = c(500, 450),
      'position_depth' = 1000,
      'reference_base' = 'C'
    )
  )

  df_test <- df_test %>%
    dplyr::mutate(percentage = 100 * (base_count/position_depth)) %>%
    dplyr::mutate(
      specimen = 'spm1',
      edit_site_target.seq = 'seq1',
      edit.site = 'chr1:+:1',
      edit_site_strand = '-'
    )

  df_results <- binomial_prop_edit_test(df_test, 0.05, 'greater')

  dfx <- test_for_significant_edits(df_results, editable_base = 'A', expected_edit = 'G')

  testthat::expect_equal(dfx %>% dplyr::filter(base_editing_result == 'on_target') %>% nrow(), 1)
  testthat::expect_equal(dfx %>% dplyr::filter(base_editing_result == 'off_target') %>% nrow(), 1)


})
