#' df_annotations_example: Nuclease Treatment and Specimen Information
#'
#' This dataset contains information about nuclease treatments, specimen identifiers,
#' and corresponding annotations. It is a tibble with 2 rows and 7 columns.
#'
#' @format A tibble with 2 rows and 7 variables:
#' \describe{
#'   \item{combo}{Character. Combination identifier.}
#'   \item{nuclease}{Character. The nuclease used in the treatment.}
#'   \item{treatment}{Character. The treatment identifier.}
#'   \item{run_set}{Character. The run set identifier.}
#'   \item{specimen}{Factor. The primary specimen identifier.}
#'   \item{alt_specimen}{Factor. The alternative specimen identifier.}
#'   \item{annotation}{Factor. Annotation information.}
#' }
#'
#' @examples
#' \dontrun{
#' # Example of how to load and use the dataset
#' data(df_annotations_example)
#' head(df_annotations_example)
#' }
"df_annotations_example"
