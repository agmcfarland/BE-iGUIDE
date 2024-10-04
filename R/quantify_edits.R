#' Quantify Edits in Sequencing Data
#'
#' This function quantifies edits in sequencing data by processing BAM files, filtering alignments, and calculating base percentages at specific edit sites. It performs statistical testing to determine the significance of edits.
#'
#' @param base_directory Character. The base directory where input data is located.
#' @param output_directory Character. The directory where output data will be saved.
#' @param analysis_name Character. The name of the analysis (default: 'quantify_edits').
#' @param abundance_cutoff Numeric. The minimum abundance cutoff for including an edit site (default: 3).
#' @param end_distance_from_cut_site Numeric. The maximum distance from the cut site to consider bases (default: 20).
#' @param cut_site_start_distance_within_gRNA Numeric. The distance within gRNA to start considering cut sites (default: 3).
#' @param cut_site_start_distance_outside_gRNA Numeric. The distance outside gRNA to start considering cut sites (default: 3).
#' @param reference_genome_path Character. Path to a fasta file used to generate the base iGUIDE result (default: '').
#' @param editable_base Character. The base that is being edited (default: 'A').
#' @param expected_edit Character. The expected base after editing (default: 'G').
#' @param binomial_p_value_threshold Numeric. The p-value threshold for determining significance using a binomial test (default: 0.05).
#' @param binomial_direction Character. The direction of the binomial test ('greater', 'less', or 'two-sided') (default: 'greater').
#' @param n_processors Numeric. The number of processors to use for parallel processing (default: 4).
#' @param overwrite Logical. Whether to overwrite existing analysis output (default: TRUE).
#'
#' @return Writes a CSV and RDS file containing base percentages and statistical results to the specified output directory.
#'
#' @import logr dplyr stringr BSgenome GenomicRanges Biostrings
#'
#' @examples
#' \dontrun{
#' quantify_edits(
#'   base_directory = "path/to/base_directory",
#'   output_directory = "path/to/output_directory",
#'   analysis_name = "my_analysis",
#'   abundance_cutoff = 5,
#'   end_distance_from_cut_site = 25,
#'   cut_site_start_distance_within_gRNA = 4,
#'   cut_site_start_distance_outside_gRNA = 4,
#'   reference_genome_path = 'path/to/genome.fasta',
#'   editable_base = 'C',
#'   expected_edit = 'T',
#'   binomial_p_value_threshold = 0.01,
#'   binomial_direction = 'two-sided',
#'   n_processors = 6,
#'   overwrite = FALSE
#' )
#' }
#' @export
quantify_edits <- function(
    base_directory,
    output_directory,
    analysis_name = 'quantify_edits',
    abundance_cutoff = 3,
    end_distance_from_cut_site = 20,
    cut_site_start_distance_within_gRNA = 3,
    cut_site_start_distance_outside_gRNA = 3,
    reference_genome_path = '',
    editable_base = 'A',
    expected_edit = 'G',
    binomial_p_value_threshold = 0.05,
    binomial_direction = 'greater',
    n_processors = 4,
    overwrite = TRUE
) {

  library(BSgenome)
  library(logr)

  run_params <- data.frame(
    'base_directory' = base_directory,
    'output_directory' = output_directory,
    'analysis_name' = analysis_name,
    'abundance_cutoff' = abundance_cutoff,
    'end_distance_from_cut_site' = end_distance_from_cut_site,
    'cut_site_start_distance_within_gRNA' = cut_site_start_distance_within_gRNA,
    'cut_site_start_distance_outside_gRNA' = cut_site_start_distance_outside_gRNA,
    'reference_genome_path' = reference_genome_path,
    'editable_base' = editable_base,
    'expected_edit' = expected_edit,
    'binomial_p_value_threshold' = binomial_p_value_threshold,
    'binomial_direction' = binomial_direction,
    'n_processors' = n_processors,
    'overwrite' = overwrite
  )

  # run_params <- data.frame(
  #   'base_directory' = '/data/BEiGUIDE/data-raw/230705_MN01490_0144_A000H5KVFN',
  #   'output_directory' = '/data/BEiGUIDE/temp',
  #   'analysis_name' = 'quantify_edits',
  #   'abundance_cutoff' = 5,
  #   'end_distance_from_cut_site' = 20,
  #   'cut_site_start_distance_within_gRNA' = 3,
  #   'cut_site_start_distance_outside_gRNA' = 3,
  #   'reference_genome_path' = '/data/iGUIDE/genomes/hg38.fasta',
  #
  #   'editable_base' = 'A',
  #   'expected_edit' = 'G',
  #
  #   'binomial_p_value_threshold' = 0.05,
  #   'binomial_direction' = 'greater',
  #
  #   'n_processors' = 8,
  #   'overwrite' = TRUE
  # )

  run_params$analysis_output <- file.path(run_params$output_directory, run_params$analysis_name)

  manage_run_directory(run_params = run_params)

  logr::log_open(file_name = file.path(run_params$analysis_output, 'BEiGUIDE_quantify_edits'), logdir = FALSE)

  logr::log_print(run_params)

  check_reference_genome(run_params = run_params)

  df_ft_data <- pull_ft_data_tables(base_directory = run_params$base_directory)

  df_annotations <- pull_combo_overview_table(base_directory = run_params$base_directory)

  df_edit_sites <- make_edit_site_table(
    ft_data_table = df_ft_data,
    spec_info_combo_overview_table = df_annotations,
    abundance_cutoff = run_params$abundance_cutoff)

  bam_files <- list_bam_files(base_directory = run_params$base_directory)

  logr::log_print(bam_files)

  df_bam <- parallel_bam_file_list_to_table(
    bam_file_list = bam_files,
    scan_param_what_list = c('qname', 'rname', 'strand', 'pos', 'qwidth', 'seq', 'cigar', 'flag'),
    number_of_cpu = run_params$n_processors
  )

  df_base_percentages <- data.frame()
  for (edit_site in split(df_edit_sites, 1:nrow(df_edit_sites))) {

    logr::log_print(edit_site)

    df_bam_filtered <- filter_bam_alignments(
      df_bam = df_bam,
      specimen = edit_site$specimen,
      chromosome = edit_site$chromosome,
      edit_site_position = edit_site$position,
      edit_site_strand = edit_site$strand,
      allowed_bases_within_gRNA = run_params$cut_site_start_distance_within_gRNA,
      allowed_bases_outside_gRNA = run_params$cut_site_start_distance_outside_gRNA
    )

    if (nrow(df_bam_filtered) == 0) {
      next
    }

    df_aln_pos <- parallel_aln_to_base_and_position_tables(
      df_bam_filtered = df_bam_filtered,
      number_of_cpu = run_params$n_processors)

    df_aln_pos_filtered <- calculate_base_percentages(
      df_aln_pos = df_aln_pos,
      edit_site_strand = edit_site$strand,
      edit_site_position = edit_site$position,
      bases_from_cut_site = run_params$end_distance_from_cut_site
    )

    df_base_percentages <- rbind(
      df_base_percentages,
      df_aln_pos_filtered %>%
        dplyr::mutate(
          annotation = edit_site$annotation,
          edit_site_target.seq = edit_site$target.seq,
          edit.site = edit_site$edit.site,
          edit_site_gene_id = edit_site$gene_id,
          edit_site_aligned.sequence = edit_site$aligned.sequence,
          edit_site_target = edit_site$target,
          edit_site_abund = edit_site$abund,
          edit_site_strand = edit_site$strand,
          edit_site_chromosome = edit_site$chromosome,
          edit_site_position = edit_site$position,
          specimen = edit_site$specimen
        )
    )

  }

  # Get reference bases if specified

  df_base_percentages_with_reference <- data.frame('empty' = 'empty')

  if (file.exists(run_params$reference_genome_path)) {

    genomic_sequence <- Biostrings::readDNAStringSet(run_params$reference_genome_path)

    df_base_percentages_with_reference <- extract_reference_bases(genomic_sequence, df_base_percentages)

    df_base_percentages_with_reference <- position_relative_to_cut_site(df_base_percentages_with_reference)

    df_base_percentages_with_reference <- binomial_prop_edit_test(
      df_base_percentages_with_reference,
      p_value_threshold = run_params$binomial_p_value_threshold,
      alternative_ = run_params$binomial_direction
      )

    df_edit_significance <- test_for_significant_edits(
      df_base_percentages_with_reference,
      editable_base = run_params$editable_base,
      expected_edit = run_params$expected_edit,
      pvalue_threshold = run_params$binomial_p_value_threshold
      )

    rm(genomic_sequence)
  }

  # Finalize datasets

  logr::log_print('Writing data')

  write.csv(df_edit_sites, file.path(run_params$analysis_output, 'edit_sites.csv'), row.names = FALSE)

  saveRDS(df_edit_sites, file.path(run_params$analysis_output, 'edit_sites.rds'))

  write.csv(df_base_percentages, file.path(run_params$analysis_output, 'base_percentages.csv'), row.names = FALSE)

  saveRDS(df_base_percentages, file.path(run_params$analysis_output, 'base_percentages.rds'))

  write.csv(df_base_percentages_with_reference, file.path(run_params$analysis_output, 'base_percentages_and_reference.csv'), row.names = FALSE)

  saveRDS(df_base_percentages_with_reference, file.path(run_params$analysis_output, 'base_percentages_and_reference.rds'))

  write.csv(df_edit_significance, file.path(run_params$analysis_output, 'significant_edits.csv'), row.names = FALSE)

  saveRDS(df_edit_significance, file.path(run_params$analysis_output, 'significant_edits.rds'))

  logr::log_print('Finished')

  logr::log_close()
}
