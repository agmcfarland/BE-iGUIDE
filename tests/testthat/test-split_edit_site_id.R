test_that("split_edit_site_id works", {

  df_test <- data.frame('edit.site' = c("chr1:+:198706754", "chrX:-:299"))
  df_test <- split_edit_site_id(df_test)

  testthat::expect_equal(as.vector(df_test$chromosome), c('chr1', 'chrX'))
  testthat::expect_equal(as.vector(df_test$position), c(198706754L, 299L))
  testthat::expect_equal(as.vector(df_test$strand), c('+', '-'))

})
