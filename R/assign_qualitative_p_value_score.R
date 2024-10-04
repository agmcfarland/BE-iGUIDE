#' Assign Qualitative P-Value Score
#'
#' This function assigns a qualitative score based on a given p-value.
#' It uses asterisks to represent the significance level, following common conventions in statistical reporting.
#'
#' @param x A numeric value representing the p-value.
#'
#' @return A character string representing the significance level:
#' - `***` for p-values less than 0.001
#' - `**` for p-values less than 0.01
#' - `*` for p-values less than 0.05
#' - An empty string (`''`) for p-values greater than or equal to 0.05
#'
#' @export
assign_qualitative_p_value_score <- function(x){
  if (x < 0.001) {
    return('***')
  } else if (x < 0.01) {
    return('**') }
  else if (x < 0.05) {
    return('*')
  } else {
    return('')
  }
}
