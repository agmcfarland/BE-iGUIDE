#' Parallel Alignment to Base and Position Tables
#'
#' Runs aln_to_base_and_position_table on each row of a data frame produced by filter_bam_alignments.
#' Produces a large long-form data frame of base, position, and qname.
#'
#' @param df_bam_filtered A data frame of filtered BAM alignments.
#' @param number_of_cpu Number of CPU cores to use for parallel processing.
#'
#' @return A data frame with base, position, and qname.
#'
#' @import parallel
#' 
#' @export
parallel_aln_to_base_and_position_tables <- function(df_bam_filtered, number_of_cpu = 4) {

  cl <- parallel::makeCluster(number_of_cpu)

  # Export necessary objects to the cluster
  parallel::clusterExport(cl, c('df_bam_filtered'), envir = environment())

  aln_list <- split(df_bam_filtered, base::seq(base::nrow(df_bam_filtered)))

  # Use mclapply for parallel processing
  df_aln_pos <- parallel::mclapply(aln_list, aln_to_base_and_position_table, mc.cores = number_of_cpu)

  # Close the cluster
  parallel::stopCluster(cl)

  # Combine the results into a single data frame
  return(do.call(rbind, df_aln_pos))
}
