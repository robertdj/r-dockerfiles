# syntax = docker/dockerfile:1.3-labs

ARG UBUNTU_VERSION
FROM ubuntu:${UBUNTU_VERSION}

ARG DEBIAN_FRONTEND=noninteractive 

ARG R_VERSION

RUN <<EOF
BUILD_DEPS="bash-completion \
    bison \
    curl \
    default-jdk \
    debhelper \
    g++ \
    gcc \
    gfortran \
    groff-base \
    libbz2-dev \
    libcairo2-dev \
    libpango1.0-dev \
    libjpeg-dev \
    libicu-dev \
    liblapack-dev \
    libncurses5-dev \
    libpng-dev \
    libreadline-dev \
    libtiff5-dev \
    liblzma-dev \
    libx11-dev \
    libxt-dev \
    mpack \
    perl \
    tcl8.6-dev \
    tk8.6-dev \
    texinfo \
    texlive-extra-utils \
    texlive-fonts-extra \
    texlive-fonts-recommended \
    texlive-latex-extra \
    texlive-latex-recommended \
    x11proto-core-dev \
    xauth \
    xfonts-base \
    xvfb \
    zlib1g-dev"

RUNTIME_DEPS="ca-certificates \
    file \
    fonts-texgyre \
    gsfonts \
    libblas-dev \
    libbz2-1.0 \
    libcairo2 \
    libcurl4 \
    libcurl4-openssl-dev \
    libglib2.0-0 \
    libgomp1 \
    libicu[0-9][0-9] \
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
    zlib1g"

apt-get update
apt-get install -y --no-install-recommends ${BUILD_DEPS} ${RUNTIME_DEPS}

# Set locales
LANG=${LANG:-en_US.UTF-8}
LC_ALL=${LC_ALL:-en_US.UTF-8}

/usr/sbin/locale-gen --lang "${LANG}"
/usr/sbin/update-locale --reset LANG="${LANG}"


# Download and install R
cd /tmp
curl -O https://cran.r-project.org/src/base/R-4/R-${R_VERSION}.tar.gz
tar -xf R-${R_VERSION}.tar.gz
cd R-${R_VERSION}

## Set compiler flags
R_PAPERSIZE=letter \
R_BATCHSAVE="--no-save --no-restore" \
R_BROWSER=xdg-open \
PAGER=/usr/bin/pager \
PERL=/usr/bin/perl \
R_UNZIPCMD=/usr/bin/unzip \
R_ZIPCMD=/usr/bin/zip \
R_PRINTCMD=/usr/bin/lpr \
LIBnn=lib \
AWK=/usr/bin/awk \
CFLAGS="-g -O2 -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g" \
CXXFLAGS="-g -O2 -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g" \
./configure --enable-R-shlib \
		    --enable-memory-profiling \
		    --with-readline \
		    --with-blas \
		    --with-tcltk \
		    --disable-nls \
		    --without-recommended-packages

## Build and install
make
make install


# Clean build dependencies
apt-get remove --purge -y ${BUILD_DEPS}
apt-get autoremove -y
apt-get autoclean -y
rm -rf /var/lib/apt/lists/*
rm -rf /tmp/*
EOF

ENV LC_ALL="en_US.UTF-8" \
    LANG="en_US.UTF-8" \
    LANGUAGE="en_US:en" \
    TERM="xterm"


# ------------------------------------------------------------------------------
# Post installation setup

# The USER is called shiny to make life easier in Shiny server images.
# Group shiny owns the default global R package folder *and* all coming 
# subfolders because Shiny server requires global packages
#
# Microsoft's daily snapshots of CRAN are used as package repo for reproducibility

ARG MRAN_DATE

RUN <<EOF
useradd --create-home --home-dir /home/shiny shiny

# Add a library directory (for user-installed packages)
mkdir -p /usr/local/lib/R/site-library
chgrp -R shiny /usr/local/lib/R/site-library
chmod -R g+rwxs /usr/local/lib/R/site-library

## Fix library path
echo "R_LIBS_USER='/usr/local/lib/R/site-library'" >> /usr/local/lib/R/etc/Renviron
echo "R_LIBS=\${R_LIBS-'/usr/local/lib/R/site-library:/usr/local/lib/R/library:/usr/lib/R/library'}" >> /usr/local/lib/R/etc/Renviron

## Add a default CRAN mirror
echo "options(repos = c(MRAN = 'https://mran.microsoft.com/snapshot/${MRAN_DATE}'), download.file.method = 'libcurl')" >> /usr/local/lib/R/etc/Rprofile.site
EOF

WORKDIR /home/shiny

CMD [ "R", "--no-save" ]

