ARG R_VERSION
FROM r-base:${R_VERSION}

# How to prevent install.packages from installing source packages?
RUN Rscript -e "install.packages(c('covr', 'devtools', 'roxygen2', 'testthat')); unlink(file.path(Sys.getenv('TMP'), '*'), recursive = TRUE)"

COPY run_tests.R C:/Users/ContainerUser/Documents/R/

WORKDIR C:/Users/ContainerUser/Documents/R/package

CMD [ "Rscript", "C:/Users/ContainerUser/Documents/R/run_tests.R" ]

