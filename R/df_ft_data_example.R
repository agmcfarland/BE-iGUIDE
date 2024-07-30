#' df_ft_data_example (Subset)
#'
#' This dataset is a subset df_ft_data containing aligned sequences with their corresponding annotations,
#' target sequences, edit sites, and other related information. It is a tibble
#' with 6 rows and 9 columns.
#'
#' @format A tibble with 6 rows and 9 variables:
#' \describe{
#'   \item{annotation}{Factor. Annotation information.}
#'   \item{target.seq}{Character. The target sequence identifier.}
#'   \item{edit.site}{Character. The chromosomal location of the edit site.}
#'   \item{aligned.sequence}{Character. The aligned sequence.}
#'   \item{mismatch}{Double. Number of mismatches in the sequence.}
#'   \item{target}{Character. Whether the sequence is on-target ('On') or off-target ('Off').}
#'   \item{gene_id}{Character. The gene identifier, with possible special characters ('*', '~').}
#'   \item{abund}{Double. Abundance count of the sequence.}
#'   \item{MESL}{Double. A metric related to the sequence (e.g., mismatch efficiency score or similar).}
#' }
#'
#' @examples
#' \dontrun{
#' # Example of how to load and use the dataset
#' data(df_ft_data_example)
#' head(df_ft_data_example)
#' }
"df_ft_data_example"
