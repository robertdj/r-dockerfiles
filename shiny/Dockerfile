ARG R_VERSION
FROM robertdj/r-base:${R_VERSION}

ARG SHINY_VERSION

USER root

RUN apt-get update && apt-get install -y \
        cmake \
        git \
        python3 \
        python3-pip \
        wget \
    && rm -rf /tmp/* \
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && rm -rf /var/lib/apt/lists/*

RUN cd /tmp && \
    wget https://github.com/rstudio/shiny-server/archive/v${SHINY_VERSION}.tar.gz && \
    tar -xvzf v${SHINY_VERSION}.tar.gz && \
    cd shiny-server-${SHINY_VERSION} && \
    mkdir tmp && \
    cd tmp && \
    ../external/node/install-node.sh && \
    PATH=`pwd`/../bin:$PATH && \
    cmake -DCMAKE_INSTALL_PREFIX=/usr/local ../ && \
    make && \
    mkdir ../build && \
    (cd .. && ./bin/npm install) && \
    (cd .. && ./bin/node ./ext/node/lib/node_modules/npm/node_modules/node-gyp/bin/node-gyp.js rebuild) && \
    make install && \
    rm -rf /tmp/*

RUN mkdir -p /var/log/shiny-server \
        /srv/shiny-server \
        /var/lib/shiny-server \
        /etc/shiny-server && \
    chgrp shiny /var/lib/shiny-server /var/log/shiny-server /srv/shiny-server && \
    chmod -R g+rwxs /var/lib/shiny-server /var/log/shiny-server /srv/shiny-server

RUN ln -s /usr/local/shiny-server/bin/shiny-server /usr/bin/shiny-server && \
    ln -s /usr/local/shiny-server/samples/welcome.html /srv/shiny-server/index.html && \
    ln -s /usr/local/shiny-server/samples/sample-apps /srv/shiny-server/sample-apps

USER shiny

ARG NCORES

RUN Rscript -e 'install.packages(c("shiny", "rmarkdown"), Ncpus = Sys.getenv("NCORES", unset = parallel::detectCores()))' && \
    rm -rf /tmp/*

RUN cp -R /usr/local/lib/R/site-library/shiny/examples/* /srv/shiny-server/

COPY --chown=shiny:shiny shiny-server.conf /etc/shiny-server/shiny-server.conf 

CMD [ "shiny-server" ]

