#' Extract Reference Bases for Edit Sites
#'
#' This function extracts reference bases for specified edit sites from a genomic sequence and integrates them into a data frame containing base percentages.
#'
#' @param genomic_sequence A `BSgenome` object containing the genomic sequence from which reference bases will be extracted.
#' @param df_base_percentages A data frame containing base percentages and related information for edit sites.
#'
#' @return A data frame with reference bases integrated into the input `df_base_percentages`.
#'
#' @export
#'
#' @import Biostrings BSgenome dplyr
extract_reference_bases <- function(genomic_sequence, df_base_percentages) {
  # library(Biostrings)
  # library(BSgenome)

  df_base_percentages_inputs <- df_base_percentages %>%
    dplyr::group_by(specimen, annotation, edit.site) %>%
    dplyr::mutate(
      start = min(position),
      stop = max(position),
      chromosome = edit_site_chromosome,
    ) %>%
    dplyr::ungroup() %>%
    dplyr::select(specimen, annotation, edit_site_target.seq, start, stop, chromosome, edit_site_strand, edit.site) %>%
    base::unique()


  grange_base_percentages <- GenomicRanges::makeGRangesFromDataFrame(df_base_percentages_inputs, keep.extra.columns = TRUE, ignore.strand = TRUE)

  reference_bases <- Biostrings::getSeq(genomic_sequence, grange_base_percentages)

  df_all_reference_bases <- do.call(rbind, lapply(1:nrow(df_base_percentages_inputs), function (x) {

    df_temp_reference_bases <- data.frame('reference_base' = unlist(reference_bases[x]))

    df_temp_reference_bases$reference_position = seq(df_base_percentages_inputs[x, ]$start, df_base_percentages_inputs[x, ]$stop)

    df_temp_reference_bases <- cbind(df_temp_reference_bases, df_base_percentages_inputs[x, ])

    return(df_temp_reference_bases)

  }))

  df_base_percentages <- merge(
    df_base_percentages,
    df_all_reference_bases %>%
      dplyr::select(-c(edit_site_strand, start, stop)),
    by.x = c('specimen', 'annotation', 'edit_site_target.seq', 'edit.site', 'position'),
    by.y = c('specimen', 'annotation', 'edit_site_target.seq', 'edit.site', 'reference_position')
  )

  return(df_base_percentages)

}

