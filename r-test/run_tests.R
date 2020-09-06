remotes::install_local(".", dependencies = TRUE, Ncpus = Sys.getenv("NCORES", unset = parallel::detectCores()))

# Run tests
devtools::test(reporter = testthat::JunitReporter$new(file = "test-results.xml"))

# Compute code coverage
cov <- covr::package_coverage()
covr::to_cobertura(cov, "coverage.xml")

print(cov)

