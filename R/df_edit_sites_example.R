#' df_edit_sites_example: Aligned Sequences with Annotations and Genomic Information
#'
#' This dataset contains aligned sequences with their corresponding annotations,
#' target sequences, edit sites, specimen information, and genomic coordinates. It is a tibble
#' with 6 rows and 13 columns.
#'
#' @format A tibble with 6 rows and 13 variables:
#' \describe{
#'   \item{annotation}{Factor. Annotation information.}
#'   \item{target.seq}{Character. The target sequence identifier.}
#'   \item{edit.site}{Character. The chromosomal location of the edit site.}
#'   \item{aligned.sequence}{Character. The aligned sequence.}
#'   \item{mismatch}{Double. Number of mismatches in the sequence.}
#'   \item{target}{Character. Whether the sequence is on-target ('On') or off-target ('Off').}
#'   \item{gene_id}{Character. The gene identifier, with possible special characters ('*').}
#'   \item{abund}{Double. Abundance count of the sequence.}
#'   \item{MESL}{Double. A metric related to the sequence (e.g., mismatch efficiency score or similar).}
#'   \item{specimen}{Factor. The specimen identifier.}
#'   \item{chromosome}{Character. The chromosome where the edit site is located.}
#'   \item{strand}{Character. The DNA strand ('+' or '-') where the edit site is located.}
#'   \item{position}{Integer. The position on the chromosome where the edit site is located.}
#' }
#'
#' @examples
#' \dontrun{
#' # Example of how to load and use the dataset
#' data(df_edit_sites_example)
#' head(df_edit_sites_example)
#' }
"df_edit_sites_example"
