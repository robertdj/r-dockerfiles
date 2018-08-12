ARG R_VERSION
FROM r-devtools:${R_VERSION}

USER root

RUN apt-get update \
	&& apt-get -y install \
		libxml2-dev \
	&& rm -rf /var/lib/apt/lists/*

USER shiny

RUN Rscript -e 'install.packages(c("covr", "roxygen2", "testthat"))'

COPY --chown=shiny:shiny run_tests.R /home/shiny/package/

WORKDIR /home/shiny/package

CMD ["Rscript", "run_tests.R"]
