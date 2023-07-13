# syntax = docker/dockerfile:1.3-labs

ARG R_VERSION
FROM robertdj/r-pptm:${R_VERSION} AS packages

ARG R_VERSION
RUN <<EOF
Rscript \
    -e 'versions <- pptm::get_version(c("shiny", "rmarkdown"), r_version = Sys.getenv("R_VERSION"), package_dir = "/tmp/pptm")' \
    -e 'pptm::make_cran(versions)'
EOF


ARG R_VERSION
FROM robertdj/r-base:${R_VERSION}

ARG SHINY_VERSION

RUN <<EOF
BUILDDEPS="
    cmake \
    git \
    python3 \
    python3-pip \
    wget \
    xz-utils"

apt-get update
apt-get install -y --no-install-recommends $BUILDDEPS zlib1g-dev

# Download and install Shiny server
cd /tmp
wget https://github.com/rstudio/shiny-server/archive/v${SHINY_VERSION}.tar.gz
tar -xvzf v${SHINY_VERSION}.tar.gz
cd shiny-server-${SHINY_VERSION}
mkdir tmp
cd tmp
../external/node/install-node.sh
PATH=`pwd`/../bin:$PATH
cmake -DCMAKE_INSTALL_PREFIX=/usr/local ../
make
mkdir ../build
(cd .. && ./bin/npm install)
(cd .. && ./bin/node ./ext/node/lib/node_modules/npm/node_modules/node-gyp/bin/node-gyp.js rebuild)
make install

# Clean up
rm -rf /tmp/*
apt-get remove --purge -y $BUILDDEPS
apt-get autoremove -y
apt-get autoclean -y
rm -rf /var/lib/apt/lists/*
rm -rf /root/.cache/*

# Config Shiny server dirs
mkdir -p /var/lib/shiny-server /var/log/shiny-server /srv/shiny-server /etc/shiny-server
chgrp shiny /var/lib/shiny-server /var/log/shiny-server /srv/shiny-server
chmod -R g+rwxs /var/lib/shiny-server /var/log/shiny-server /srv/shiny-server

ln -s /usr/local/shiny-server/bin/shiny-server /usr/bin/shiny-server
ln -s /usr/local/shiny-server/samples/welcome.html /srv/shiny-server/index.html
ln -s /usr/local/shiny-server/samples/sample-apps /srv/shiny-server/sample-apps
EOF

RUN --mount=type=bind,from=packages,source=/tmp/pptm,target=/tmp/pptm <<EOF
Rscript -e 'install.packages(
    c("shiny", "rmarkdown"), 
    repos = "file:///tmp/pptm",
    type = "source",
    Ncpus = parallel::detectCores()
)'

cp -R /usr/local/lib/R/site-library/shiny/examples/* /srv/shiny-server/
EOF

COPY --chown=shiny:shiny shiny-server.conf /etc/shiny-server/shiny-server.conf 

CMD [ "shiny-server" ]
