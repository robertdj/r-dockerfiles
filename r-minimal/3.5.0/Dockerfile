ARG UBUNTU_VERSION=18.04 
FROM r-deps:${UBUNTU_VERSION} as builder

ARG R_VERSION=3.5.0

ENV R_VERSION=${R_VERSION}

RUN apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
		bash-completion \
		bison \
		curl \
		default-jdk \
		debhelper \
		g++ \
		gcc \
		gfortran \
		groff-base \
		libblas-dev \
		libbz2-dev \
		libcairo2-dev \
		libpango1.0-dev \
		libjpeg-dev \
		libicu-dev \
		liblapack-dev \
		libncurses5-dev \ 
		libpcre3-dev \
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
		texlive-base \
		texlive-extra-utils \
		texlive-fonts-extra \
		texlive-fonts-recommended \
		texlive-generic-recommended \
		texlive-latex-base \
		texlive-latex-extra \
		texlive-latex-recommended \
		x11proto-core-dev \
		xauth \
		xfonts-base \
		xvfb \
		zlib1g-dev
	
# Download and install R
RUN cd tmp/ \
	&& curl -O https://cran.r-project.org/src/base/R-3/R-${R_VERSION}.tar.gz \
	&& tar -xf R-${R_VERSION}.tar.gz \
	&& cd R-${R_VERSION} \
	## Set compiler flags
	&& R_PAPERSIZE=letter \
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
	## Configure options
	./configure --enable-R-shlib \
			    --enable-memory-profiling \
			    --with-readline \
			    --with-blas \
			    --with-tcltk \
			    --disable-nls \
			    --without-recommended-packages \
	## Build and install
	&& make \
	&& make install


FROM r-deps:18.04

ARG BUILD_DATE=2018-07-02

COPY --from=builder /usr/local/ /usr/local/


# ------------------------------------------------------------------------------
# Post installation setup

# The USER is called shiny to make life easier in Shiny server images.
# Group shiny owns the default global R package folder *and* all coming 
# subfolders because Shiny server requires global packages
#
# Microsoft's daily snapshots of CRAN are used as package repo for reproducibility

ENV HOME /home/shiny

RUN useradd --create-home --home-dir $HOME shiny \
	&& chown -R shiny:shiny $HOME \
	# Add a library directory (for user-installed packages)
	&& mkdir -p /usr/local/lib/R/site-library \
	&& chgrp -R shiny /usr/local/lib/R/site-library \
	&& chmod -R g+rwxs /usr/local/lib/R/site-library \
	## Fix library path
	&& echo "R_LIBS_USER='/usr/local/lib/R/site-library'" >> /usr/local/lib/R/etc/Renviron \
	&& echo "R_LIBS=\${R_LIBS-'/usr/local/lib/R/site-library:/usr/local/lib/R/library:/usr/lib/R/library'}" >> /usr/local/lib/R/etc/Renviron \
	## Add a default CRAN mirror
	&& BUILD_DATE=${BUILD_DATE-`date -I`} \
	&& echo "options(repos = 'https://mran.microsoft.com/snapshot/${BUILD_DATE}', download.file.method = 'libcurl')" >> /usr/local/lib/R/etc/Rprofile.site

WORKDIR $HOME

USER shiny

RUN Rscript -e 'install.packages("remotes")'

CMD ["R"]

