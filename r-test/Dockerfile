ARG R_VERSION
FROM robertdj/r-base:${R_VERSION}

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		libxml2-dev \
		libssl-dev \
		libssh2-1-dev \
		zlib1g-dev \
	&& rm -rf /var/lib/apt/lists/*

ARG NCORES

RUN Rscript -e 'install.packages(c("covr", "devtools", "roxygen2", "testthat"), Ncpus = Sys.getenv("NCORES", unset = parallel::detectCores()))' \
	&& rm -rf /tmp/*

COPY --chown=shiny:shiny run_tests.R $HOME/

# This ensures that shiny user owns ~/package. Should not be necessary...
RUN mkdir $HOME/package

WORKDIR $HOME/package

