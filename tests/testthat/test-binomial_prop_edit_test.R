testthat::test_that("binomial_prop_edit works", {

  # Assuming plus strand, dataset has one significant on target edit for position 2. One significant off-target edit at position 3
  df_test <- rbind(
    data.frame(
      'position' = 1,
      'base' = c('A', 'G'),
      'base_count' = c(900, 20),
      'position_depth' = 1000),
    data.frame(
      'position' = 2,
      'base' = c('A', 'G'),
      'base_count' = c(500, 450),
      'position_depth' = 1000),
    data.frame(
      'position' = 3,
      'base' = c('G', 'A'),
      'base_count' = c(500, 450),
      'position_depth' = 1000)
    )

  df_test <- df_test %>%
    dplyr::mutate(percentage = 100 * (base_count/position_depth)) %>%
    dplyr::mutate(
      specimen = 'spm1',
      edit_site_target.seq = 'seq1',
      edit.site = 'chr1:+:1',
    )

  df_results <- binomial_prop_edit_test(df_test, 0.05, 'greater')

  # Expect 5 position-base combos will show significance. These are raw significance values and do not have experimental context for further filtering.
  # See test_for_significant_edits
  testthat::expect_equal(df_results %>% dplyr::filter(p_value < 0.05) %>% nrow(), 5)

})
