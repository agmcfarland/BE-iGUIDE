#' Alignment to Base and Position Table
#'
#' Takes a single row produced by filter_bam_alignments and returns a table with base, position, and qname.
#'
#' @details input is a single row produced by filter_bam_alignments
#' otherwise input must have seq, pos, qwidth, and qname columns
#'
#' @param aln A single row data frame.
#'
#' @return A data frame with base, position, and qname.
#'
#' @import stringr
aln_to_base_and_position_table <- function(aln) {
  return(data.frame(
    'base' = stringr::str_split(aln$seq, '')[[1]],
    'position' = base::seq(aln$pos, aln$pos + aln$qwidth - 1, by = 1), # stays the same for + or -
    'qname' = aln$qname
  ))
}
