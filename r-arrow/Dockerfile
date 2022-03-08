# syntax = docker/dockerfile:1.3-labs

ARG R_VERSION 
FROM robertdj/r-base:${R_VERSION}

RUN <<EOF
apt-get update
apt-get install -y --no-install-recommends \
    libcurl4-openssl-dev \
    libssl-dev

Rscript -e 'Sys.setenv("NOT_CRAN" = TRUE)' -e 'install.packages("arrow")'

rm -rf /var/lib/apt/lists/*
rm -rf /tmp/*
EOF


