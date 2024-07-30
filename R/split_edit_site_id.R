
#' Split Edit Site ID into Chromosome, Strand, and Position
#'
#' This function takes a data frame with an `edit.site` column containing coordinates
#' in the format "chr:str:pos" and splits it into separate columns for chromosome, strand, and position.
#'
#' @param df A data frame containing an `edit.site` column with coordinates in the format "chr:str:pos".
#' @return A data frame with the original columns and three new columns: `chromosome`, `strand`, and `position`.
#' @export
#' @import dplyr stringr
split_edit_site_id <- function(df) {
  return(df %>%
           dplyr::mutate(
             chromosome = sapply(edit.site, function(x) {
               stringr::str_split(x, ':')[[1]][1]}),
             strand = sapply(edit.site, function(x) {
               stringr::str_split(x, ':')[[1]][2]}),
             position = sapply(edit.site, function(x) {
               as.integer(stringr::str_split(x, ':')[[1]][3])})
           )
  )
}

