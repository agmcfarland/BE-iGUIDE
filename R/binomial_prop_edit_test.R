#' Binomial Proportion Edit Test
#'
#' This function performs a binomial test for each edit site position to assess whether the observed
#' base counts are significantly different from a given probability. It tests the hypothesis
#' that the proportion of edits (i.e., mutations) is different from a specified baseline,
#' defaulting to 0.05 (5%). The results include the p-value and confidence intervals for each position.
#'
#' @param df_base_percentages A data frame containing base percentages for edit sites.
#' It should include columns such as `specimen`, `edit_site_target.seq`, `edit.site`, `position`,
#' `base`, and `base_count`.
#' @param p_value_ A numeric value specifying the hypothesized probability of success
#' under the null hypothesis. Default is 0.05.
#' @param alternative_ A character string specifying the alternative hypothesis. Must be
#' one of "two.sided", "less", or "greater". Default is "two.sided".
#'
#' @return A data frame with columns for the p-value (`p_value`), confidence intervals
#' (`conf_low`, `conf_high`), and base percentage (`percentage`) for each base at each
#' position in the dataset.
#'
#' @import dplyr tidyr
#'
#' @export
binomial_prop_edit_test <- function(df_base_percentages, p_value_threshold = 0.05, alternative_ = c('two.sided', 'less', 'greater')) {
  if (!alternative_ %in% c('two.sided', 'less', 'greater')) {
    stop('Specify one of two.sided, less, greater')
  }

  df_edit_evidence <- df_base_percentages %>%
    # Remove base percentages to make one row equal to one position for an edit site result
    dplyr::select(-percentage) %>%
    # Fill missing base counts
    dplyr::group_by(specimen, edit_site_target.seq, edit.site, position) %>%
    tidyr::pivot_wider(names_from = 'base', values_from = 'base_count', values_fill = 0) %>%
    dplyr::ungroup()

  # Add columns in case that base is not in the data and not available for pivot_wider to act on
  if (!'N' %in% colnames(df_edit_evidence)) {
    df_edit_evidence$`N` <- 0
  }
  if (!'A' %in% colnames(df_edit_evidence)) {
    df_edit_evidence$`A` <- 0
  }
  if (!'T' %in% colnames(df_edit_evidence)) {
    df_edit_evidence$`T` <- 0
  }
  if (!'C' %in% colnames(df_edit_evidence)) {
    df_edit_evidence$`C` <- 0
  }
  if (!'G' %in% colnames(df_edit_evidence)) {
    df_edit_evidence$`G` <- 0
  }

  # Convert back to long form
  df_edit_evidence <- df_edit_evidence %>%
    tidyr::pivot_longer(cols = c(`A`, `C`, `G`, `T`, `N`), names_to = 'base', values_to = 'base_count')

  # Test whether edit is significantly greater than 5%
  df_edit_evidence <- df_edit_evidence %>%
    dplyr::rowwise() %>%
    dplyr::mutate(
      binom_test = list(stats::binom.test(
        x = base_count,
        n = position_depth,
        p = p_value_threshold,
        alternative = alternative_
      )),
      p_value = binom_test$p.value,
      conf_low = binom_test$conf.int[1],
      conf_high = binom_test$conf.int[2]
    ) %>%
    dplyr::ungroup() %>%
    dplyr::select(-binom_test)

   # Add percentage column back
   df_edit_evidence <- df_edit_evidence %>%
    dplyr::mutate(percentage = 100 * (base_count/position_depth))

  return(df_edit_evidence)
  }
