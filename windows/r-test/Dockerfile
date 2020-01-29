ARG R_VERSION
FROM r-base:${R_VERSION}

# Prevent install.packages from installing source packages
RUN Rscript -e "options(install.packages.check.source = 'no')"

RUN Rscript -e "install.packages(c('covr', 'devtools', 'roxygen2', 'testthat')); unlink(file.path(Sys.getenv('TMP'), '*'), recursive = TRUE)"

COPY run_tests.R C:/Users/ContainerUser/Documents/R/

WORKDIR C:/Users/ContainerUser/Documents/R/package

