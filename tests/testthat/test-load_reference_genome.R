testthat::test_that("load_reference_genome works", {
  # create a test reference genome file for testing purposes
  test_reference_genome_path <- tempfile(fileext = ".fasta")
  writeLines(c(
    ">chr1",
    "AGCTTAGCTAGCTACCTATATCTTGGTCTTGGCCG",
    ">chr2",
    "TGCATGCTAGCTAGCTTGCGCGCGTATAGCTAGCT"
  ), test_reference_genome_path)

  # Load the reference genome using the function
  reference_genome <- load_reference_genome(test_reference_genome_path)

  # Check if the reference genome is a DNAStringSet
  expect_s4_class(reference_genome, "DNAStringSet")

  # Check if the names of the sequences are correct
  testthat::expect_equal(names(reference_genome), c("chr1", "chr2"))

  # Check if the sequences are loaded correctly
  testthat::expect_equal(as.character(reference_genome$chr1), "AGCTTAGCTAGCTACCTATATCTTGGTCTTGGCCG")
  testthat::expect_equal(as.character(reference_genome$chr2), "TGCATGCTAGCTAGCTTGCGCGCGTATAGCTAGCT")

  # Clean up the temporary file
  unlink(test_reference_genome_path)

})
