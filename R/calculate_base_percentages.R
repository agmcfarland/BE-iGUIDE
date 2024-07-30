#' Calculate Base Percentages
#'
#' Uses input from `parallel_aln_to_base_and_position_tables()` or `aln_to_base_and_position_tables()`  and returns a table with counts and percentages of each base at each position.
#'
#' @param df_aln_pos A data frame with base, position, and qname.
#' @param edit_site_position The position of the edit site.
#' @param edit_site_strand The strand of the edit site ('+' or '-').
#' @param bases_from_cut_site Number of bases to consider from the cut site.
#'
#' @return A data frame with counts and percentages of each base at each position.
#'
#' @export
#'
#' @import dplyr
calculate_base_percentages <- function(df_aln_pos, edit_site_position, edit_site_strand, bases_from_cut_site = 20) {

  if (edit_site_strand == '+') {
    df_aln_pos_filtered <- df_aln_pos %>%
      dplyr::filter(
        position >= edit_site_position - bases_from_cut_site & position <= edit_site_position ) # gRNA extends to the left of the cut site
  }

  if (edit_site_strand == '-') {
    df_aln_pos_filtered <- df_aln_pos %>%
      dplyr::filter(
        position <= edit_site_position + bases_from_cut_site & position >= edit_site_position) # gRNA extends to the right of the cut site
  }

  df_aln_pos_filtered <- df_aln_pos_filtered %>%
    dplyr::group_by(position, base) %>%
    dplyr::mutate(base_count = dplyr::n()) %>%
    dplyr::ungroup() %>%
    dplyr::select(position, base, base_count) %>%
    base::unique() %>%
    dplyr::group_by(position) %>%
    dplyr::mutate(position_depth = sum(base_count)) %>%
    dplyr::ungroup() %>%
    dplyr::mutate(percentage = 100 * (base_count/position_depth))

  return(df_aln_pos_filtered)
}
