#' Load Reference Genome
#'
#' This function loads a reference genome from a specified file path.
#'
#' @param reference_genome_path A string specifying the path to the reference genome file.
#'
#' @return A `DNAStringSet` object containing the reference genome sequences.
#'
#' @examples
#' \dontrun{
#' reference_genome_path <- "path/to/reference_genome.fasta"
#' reference_genome <- load_reference_genome(reference_genome_path)
#' }
#' @export
#'
#' @import BSgenome Biostrings
#'
#' @importFrom Biostrings DNAStringSet
load_reference_genome <- function(reference_genome_path) {
  return(Biostrings::readDNAStringSet(reference_genome_path))
}
