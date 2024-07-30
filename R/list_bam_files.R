#' List BAM Files
#'
#' This function lists BAM alignment files from the specified iGUIDE file structure.
#' It ignores any files ending with `.unsorted.bam`.
#'
#' @param base_directory A string specifying the base directory that points to the iGUIDE file structure containing BAM alignments.
#'
#' @return A 1-D matrix of BAM file paths.
#'
#' @export
#' 
#' @import stringr
list_bam_files <- function(base_directory) {
  bam_files <- lapply(Sys.glob(file.path(base_directory, 'process_data', 'align', '*.bam')), function(x) {
    if (!stringr::str_ends(x, '.unsorted.bam')) {
      return(x)
    }
  })

  return(do.call(rbind, bam_files))
}
