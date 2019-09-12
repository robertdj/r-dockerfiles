ARG R_VERSION=3.6.0
FROM r-base:${R_VERSION}

USER root

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		libxml2-dev \
        libcurl4-openssl-dev \
	&& rm -rf /var/lib/apt/lists/* /tmp/*

USER shiny

RUN Rscript -e 'install.packages("pak")' \
	&& rm -rf /tmp/*

CMD [ "R" ]
