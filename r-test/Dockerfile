# syntax = docker/dockerfile:1.3-labs

ARG R_VERSION
FROM robertdj/r-base:${R_VERSION}

RUN <<EOF
apt-get update
apt-get install -y --no-install-recommends \
    libxml2-dev \
    libssl-dev \
    libssh2-1-dev \
    zlib1g-dev

Rscript -e 'install.packages(c("covr", "devtools", "roxygen2", "testthat"), Ncpus = parallel::detectCores())'

rm -rf /var/lib/apt/lists/*
rm -rf /tmp/*
EOF

RUN <<EOF
mkdir -p /home/shiny/package
chown shiny:shiny /home/shiny/package
EOF

WORKDIR /home/shiny/package

