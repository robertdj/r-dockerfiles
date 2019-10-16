ARG R_VERSION
FROM r-base:${R_VERSION}

USER root

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		libxml2-dev \
		libssl-dev \
		libssh2-1-dev \
		zlib1g-dev \
	&& rm -rf /var/lib/apt/lists/*

USER shiny

ARG NCORES

RUN Rscript -e 'install.packages(c("covr", "devtools", "roxygen2", "testthat"), Ncpus = Sys.getenv("NCORES", unset = parallel::detectCores()))' \
	&& rm -rf /tmp/*

COPY --chown=shiny:shiny run_tests.R $HOME/package/

WORKDIR $HOME/package

CMD [ "Rscript", "run_tests.R" ]

