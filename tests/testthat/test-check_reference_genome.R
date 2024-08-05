testthat::test_that("check_reference_genome works as expected", {

  # Create a temporary directory and file for testing
  temp_dir <- tempdir()
  temp_file <- tempfile(tmpdir = temp_dir)
  file.create(temp_file)

  # Test when reference_genome_path is NULL
  run_params <- data.frame('reference_genome_path' = '')
  testthat::expect_silent(check_reference_genome(run_params))

  # Test when reference_genome_path exists
  run_params <- data.frame('reference_genome_path' = temp_file)
  testthat::expect_error(check_reference_genome(run_params), "reference genome is not a fasta formatted")

  # Test when reference_genome_path does not exist
  run_params <- data.frame('reference_genome_path' = file.path(temp_dir, "non_existent_file.fasta"))
  testthat::expect_error(check_reference_genome(run_params), "reference genome path not found")

  # Clean up
  unlink(temp_file)


  test_reference_genome_path <- tempfile(fileext = ".fasta")
  writeLines(c(
    ">chr1",
    "AGCTTAGCTAGCTACCTATATCTTGGTCTTGGCCG",
    ">chr2",
    "TGCATGCTAGCTAGCTTGCGCGCGTATAGCTAGCT"
  ), test_reference_genome_path)

  run_params <- data.frame('reference_genome_path' = test_reference_genome_path)

  testthat::expect_output(check_reference_genome(run_params), 'Reference genome successfully loaded')

  unlink(test_reference_genome_path)

})


