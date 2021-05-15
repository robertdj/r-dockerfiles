ARG R_VERSION 
FROM robertdj/r-minimal:${R_VERSION}

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		g++ \
		gcc \
		gfortran \
	&& rm -rf /var/lib/apt/lists/*

RUN Rscript -e 'install.packages("remotes")'

