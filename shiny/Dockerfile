# syntax = docker/dockerfile:1.3-labs

ARG R_VERSION
FROM robertdj/r-base:${R_VERSION}

ARG SHINY_VERSION

RUN <<EOF
apt-get update
apt-get install -y --no-install-recommends \
    cmake \
    git \
    python3 \
    python3-pip \
    wget \
    xz-utils \
    zlib1g-dev

rm -rf /tmp/*
apt-get autoremove -y
apt-get autoclean -y
rm -rf /var/lib/apt/lists/*
EOF

RUN <<EOF
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
rm -rf /tmp/*

mkdir -p /var/lib/shiny-server /var/log/shiny-server /srv/shiny-server /etc/shiny-server
chgrp shiny /var/lib/shiny-server /var/log/shiny-server /srv/shiny-server
chmod -R g+rwxs /var/lib/shiny-server /var/log/shiny-server /srv/shiny-server

ln -s /usr/local/shiny-server/bin/shiny-server /usr/bin/shiny-server
ln -s /usr/local/shiny-server/samples/welcome.html /srv/shiny-server/index.html
ln -s /usr/local/shiny-server/samples/sample-apps /srv/shiny-server/sample-apps
EOF

RUN <<EOF
Rscript -e 'install.packages(c("shiny", "rmarkdown"), Ncpus = parallel::detectCores())'
rm -rf /tmp/*

cp -R /usr/local/lib/R/site-library/shiny/examples/* /srv/shiny-server/
EOF

COPY --chown=shiny:shiny shiny-server.conf /etc/shiny-server/shiny-server.conf 

CMD [ "shiny-server" ]

