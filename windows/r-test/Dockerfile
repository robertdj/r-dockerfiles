ARG R_VERSION
FROM r-base:${R_VERSION}

RUN Rscript -e "install.packages(c('covr', 'devtools', 'roxygen2', 'testthat')); unlink(file.path(Sys.getenv('TMP'), '*'), recursive = TRUE)"

COPY run_tests.R C:/tests/

WORKDIR C:/tests

