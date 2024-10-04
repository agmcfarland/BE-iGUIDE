test_that("assign_qualitative_p_value_score works", {

  dfx <- data.frame('pvalue' = c(0.0001, 0.009, 0.049, 1),
             'corrected_pvalue' = c(0.01, 0.1, 0.5, 1))

  dfx <- dfx %>%
    dplyr::mutate(pvalue_s = sapply(pvalue, assign_qualitative_p_value_score)) %>%
    dplyr::mutate(pvalue_x = sapply(corrected_pvalue, assign_qualitative_p_value_score))

  testthat::expect_equal(dfx$pvalue_s, c('***', '**', '*', ''))

  testthat::expect_equal(dfx$pvalue_x, c('*', '', '', ''))

})
