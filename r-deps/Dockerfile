# syntax = docker/dockerfile:1.3-labs

ARG UBUNTU_VERSION
FROM ubuntu:${UBUNTU_VERSION}

RUN <<EOF
apt-get update
apt-get upgrade -y
# Runtime dependencies
apt-get install -y --no-install-recommends \
    ca-certificates \
    file \
    fonts-texgyre \
    gsfonts \
    libblas3 \
    libbz2-1.0 \
    libcairo2 \
    libcurl4 \
    libcurl4-openssl-dev \
    libglib2.0-0 \
    libgomp1 \
    libicu66 \
    libjpeg8 \
    liblzma5 \
    libopenblas-dev \
    libpangocairo-1.0-0 \
    libpcre2-dev \
    libpng16-16 \
    libreadline8 \
    libtiff5 \
    locales \
    make \
    ucf \
    unzip \
    zip \
    zlib1g

echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen en_US.UTF-8
/usr/sbin/update-locale LANG=en_US.UTF-8

# Clean up
rm -rf /tmp/* 
apt-get autoremove -y
apt-get autoclean -y
rm -rf /var/lib/apt/lists/*
EOF

ENV LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    TERM=xterm

