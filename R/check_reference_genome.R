#' Check Reference Genome Path
#'
#' This function checks whether the reference genome path specified in the
#' run parameters exists. If the reference genome path is not NULL and does
#' not exist, the function will stop and return an error message.
#'
#' @param run_params A list or data frame containing the run parameters. It
#' should include a field `reference_genome_path` which is the path to the
#' reference genome file.
#'
#' @return NULL. This function is used for its side effect of stopping the
#' execution if the reference genome path does not exist.
#'
#' @examples
#' \dontrun{
#' # Example run parameters
#' run_params <- list(reference_genome_path = "path/to/reference_genome.fasta")
#'
#' # Check if the reference genome path exists
#' check_reference_genome(run_params)
#' }
#'
#' @export
check_reference_genome <- function(run_params) {
  if (run_params$reference_genome_path != '') {
    if (!file.exists(run_params$reference_genome_path)) {
      stop(paste0('reference genome path not found: ', run_params$reference_genome_path))
    }
    if (file.exists(run_params$reference_genome_path)) {
      genome_sequence <- load_reference_genome(run_params$reference_genome_path)
      if (length(genome_sequence) == 0){
        stop(paste0('reference genome is not a fasta formatted file: ', run_params$reference_genome_path))
      } else {
        print('Reference genome successfully loaded')
        rm(genome_sequence)
      }
      }
    }
  }

