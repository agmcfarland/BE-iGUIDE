

test_for_significant_edits <- function(df_edit_significance, editable_base = 'A', expected_edit = 'G', pvalue_threshold = 0.05) {

  df_ontarget_edit_evidence <- df_edit_significance %>%
    # On-target significant edits
    dplyr::filter(
      reference_base == ifelse(edit_site_strand == '-', base_complement(editable_base), editable_base),
      base == ifelse(edit_site_strand == '-', base_complement(expected_edit), expected_edit)
    ) %>%
    dplyr::mutate(
      base_editing_result = 'on_target'
    )

  df_offtarget_edit_evidence <- df_edit_significance %>%
    # Off-target significant edits
    dplyr::filter(
      reference_base != ifelse(edit_site_strand == '-', base_complement(editable_base), editable_base) &
        base != ifelse(edit_site_strand == '-', base_complement(expected_edit), expected_edit),
      reference_base != base
    ) %>%
    dplyr::mutate(
      base_editing_result = 'off_target'
    )

  df_significant_edits <- rbind(
      df_ontarget_edit_evidence,
      df_offtarget_edit_evidence)

  df_significant_edits <- df_significant_edits %>%
    dplyr::filter(p_value < pvalue_threshold)

  return(df_significant_edits)

  }
