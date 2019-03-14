ARG R_VERSION=3.5.0 
FROM r-minimal:${R_VERSION}

USER root

RUN apt-get update \
	# Runtime dependencies
	&& apt-get install -y --no-install-recommends \
		g++ \
		gcc \
		gfortran \
	&& rm -rf /var/lib/apt/lists/*


USER shiny

CMD ["R"]

