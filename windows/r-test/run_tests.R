remotes::install_local(".", dependencies = TRUE)

# Run tests
options("testthat.output_file" = "test-results.xml")
devtools::test(reporter = testthat::JunitReporter$new())

# Compute code coverage
cov <- covr::package_coverage()
covr::to_cobertura(cov, "coverage.xml")

