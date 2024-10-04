#' Compute Position Relative to Cut Site
#'
#' This function calculates the position of bases relative to a cut site (position 0) in an iGUIDE dataset.
#' If a cut is on the plus strand, then it is numbered negatively to 0.
#'
#' @param df_edits A data frame containing the edit site information.
#' It should include columns such as `specimen`, `edit_site_target.seq`, `edit.site`,
#' `edit_site_strand`, and `position`.
#'
#' @return A data frame with an additional column, `relative_position`, representing the
#' position of each edit relative to the maximum position within each group of
#' `specimen`, `edit_site_target.seq`, and `edit.site`. If the strand is '+',
#' the relative position is calculated as `position - max(position)`, otherwise it is
#' calculated as `max(position) - position`.
#'
#' @import dplyr
#' 
#' @export
position_relative_to_cut_site <- function(df_edits) {

  df_edits <- df_edits %>%
    dplyr::group_by(specimen, edit_site_target.seq, edit.site) %>%
    dplyr::mutate(
      relative_position = ifelse(edit_site_strand == '+', position - max(position), position - min(position))) %>%
    dplyr::ungroup()

  return(df_edits)
}
