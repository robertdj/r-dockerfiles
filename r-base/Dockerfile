ARG R_VERSION 
FROM robertdj/r-minimal:${R_VERSION}

USER root

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		g++ \
		gcc \
		gfortran \
	&& rm -rf /var/lib/apt/lists/*

USER shiny

RUN Rscript -e 'install.packages("remotes")'

