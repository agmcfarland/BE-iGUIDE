#' df_bam_example: Sequencing Reads with Alignment Information
#'
#' This dataset contains sequencing reads with their corresponding alignment information,
#' including quality name (qname), flags, reference names (rname), strand information, positions,
#' and additional sequencing and alignment details. It is a tibble with 6 rows and 10 columns.
#'
#' @format A tibble with 6 rows and 10 variables:
#' \describe{
#'   \item{qname}{Character. The query template name.}
#'   \item{flag}{Integer. Bitwise flag indicating various properties of the read (e.g., paired, mapped).}
#'   \item{rname}{Factor. Reference sequence name (chromosome or contig).}
#'   \item{strand}{Factor. Strand information, either '+' or '-'.}
#'   \item{pos}{Integer. 1-based leftmost mapping position of the first matching base.}
#'   \item{qwidth}{Integer. Length of the query sequence.}
#'   \item{cigar}{Character. CIGAR string representing the alignment of the query sequence to the reference.}
#'   \item{seq}{Character. The query DNA sequence.}
#'   \item{bam_id}{Character. Identifier for the BAM file from which the read was obtained.}
#'   \item{specimen_id}{Character. Identifier for the specimen from which the read was obtained.}
#' }
#'
#' @examples
#' \dontrun{
#' # Example of how to load and use the dataset
#' data(df_bam_example)
#' head(df_bam_example)
#' }
"df_bam_example"
