# syntax = docker/dockerfile:1.3-labs

ARG R_VERSION 
FROM robertdj/r-minimal:${R_VERSION}

RUN <<EOF
apt-get update
apt-get install -y --no-install-recommends \
    g++ \
    gcc \
    gfortran 

Rscript -e 'install.packages("remotes")'

rm -rf /var/lib/apt/lists/*
rm -rf /tmp/*
EOF

