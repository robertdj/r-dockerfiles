remotes::install_local(".", dependencies = TRUE, Ncpus = Sys.getenv("NCORES", unset = parallel::detectCores()))

# Run tests
options("testthat.output_file" = "test-results.xml")
devtools::test(reporter = testthat::JunitReporter$new())

# Compute code coverage
cov <- covr::package_coverage()
covr::to_cobertura(cov, "coverage.xml")

print(cov)

