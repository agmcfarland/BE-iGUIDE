#' Base Complement
#'
#' This function takes a single DNA base and returns its complementary base according to standard base pairing rules.
#'
#' @param x A single character string representing a DNA base ('A', 'T', 'G', 'C', or 'N').
#'
#' @return A single character string representing the complementary base or N if input is N.
#'
#' @export
base_complement <- function(x) {
  if (x == 'G') {
    return('C')
  } else if (x == 'C') {
    return('G')
  } else if (x == 'A') {
    return('T')
  } else if (x == 'T') {
    return('A')
  } else if (x == 'N') {
    return('N')
  } else {
    stop('Input must be single character either A, T, G, C, or N')
  }
}
