#' Pull FT Data Tables
#'
#' This function retrieves all `ft_data` tables found in a specified iGUIDE file structure.
#'
#' @param base_directory A string specifying the base directory that points to the iGUIDE file structure with `ft_data`.
#'
#' @return A dataframe containing the combined `ft_data` tables.
#'
#' @export
pull_ft_data_tables <- function(base_directory) {
  df_ft_data <- do.call(
    rbind,
    lapply(readRDS(Sys.glob(file.path(base_directory, 'output', 'iguide.eval.*rds')))['ft_data'][[1]], function(x) {
      return(x)
    })
  )

  return(df_ft_data)
}
