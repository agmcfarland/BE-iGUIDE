testthat::test_that("position_relative_to_cut_site works", {
  # df_edits_input <- readRDS(testthat::test_path(file.path('testdata', 'df_base_percentages_example.rds')))
  #
  # df3 <- position_relative_to_cut_site(df_edits_input)
  #
  # df_edits_input <- readRDS('/data/BEiGUIDE/tests/quantify_edits/base_percentages.rds') %>%
  #   dplyr::filter(
  #     annotation == 'PTPRC.1 - Cas9 - pND567_BE8sgRNA_TadA_10xdsODN (A)',
  #     edit.site == 'chr2:-:143961596'
  #     )
  #
  # df3 <- position_relative_to_cut_site(df_edits_input)

  df1 <- data.frame(
    'specimen' = rep('spm1', 20),
    'edit.site' = rep('chr1:-:101', 20),
    'edit_site_target.seq' = rep('target1', 20),
    'edit_site_strand' = rep('-', 20),
    'position' = seq(101, 120)
  )

  df2 <- df1 %>%
    dplyr::mutate(edit_site_strand = '+', edit_site_target.seq = 'target2', edit.site = 'chr1:+:120')

  df3 <- rbind(df1, df2)

  df1 <- position_relative_to_cut_site(df1)

  df2 <- position_relative_to_cut_site(df2)

  df3 <- position_relative_to_cut_site(df3)

  smallest_position_is_cut_site <- df1 %>% dplyr::filter(position == min(position)) %>% dplyr::pull(relative_position)

  largest_position_is_cut_site <- df2 %>% dplyr::filter(position == max(position)) %>% dplyr::pull(relative_position)

  testthat::expect_equal(smallest_position_is_cut_site, 0)

  testthat::expect_equal(largest_position_is_cut_site, 0)

  testthat::expect_equal(df3 %>% dplyr::filter(relative_position == 0) %>% nrow(), 2)

})
