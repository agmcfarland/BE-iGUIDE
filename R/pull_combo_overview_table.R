#' Pull Combo Overview Table
#'
#' This function retrieves the `combo_overview` table from the `spec_info` section
#' of an iGUIDE file structure.
#'
#' The function expects a base directory that points to the iGUIDE file structure.
#' The iGUIDE output structure must be present for the function to work correctly.
#' The output is a dataframe that links GTSPs to annotations.
#'
#' @param base_directory A string specifying the base directory that points to the iGUIDE file structure.
#'
#' @return A dataframe containing the `combo_overview` table.
#'
#' @export
pull_combo_overview_table <- function(base_directory) {
  return(readRDS(Sys.glob(file.path(base_directory, 'output', 'iguide.eval.*rds')))$spec_info$combo_overview)
}
