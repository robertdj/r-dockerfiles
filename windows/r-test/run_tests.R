remotes::install_local(".", dependencies = TRUE)

# Run tests
devtools::test(reporter = testthat::JunitReporter$new(file = "test-results.xml"))

# Compute code coverage
cov <- covr::package_coverage()
covr::to_cobertura(cov, "coverage.xml")

print(cov)

