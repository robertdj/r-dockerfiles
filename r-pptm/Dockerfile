# syntax = docker/dockerfile:1.3-labs

ARG R_VERSION
FROM robertdj/r-base:${R_VERSION}

RUN <<EOF
apt-get update
apt-get install -y --no-install-recommends \
    libxml2-dev \
    libssl-dev

Rscript -e 'remotes::install_github("robertdj/pptm", Ncpus = parallel::detectCores())'

rm -rf /var/lib/apt/lists/*
rm -rf /tmp/*
EOF
