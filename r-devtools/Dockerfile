ARG R_VERSION
FROM r-base:${R_VERSION}

USER root

RUN apt-get update \
	&& apt-get -y install \
		libcurl4-openssl-dev \
		libssl-dev \
		libssh2-1-dev \
		zlib1g-dev \
	&& rm -rf /var/lib/apt/lists/*

USER shiny

RUN Rscript -e 'install.packages("devtools")'

CMD ["R"]
