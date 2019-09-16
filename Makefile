UBUNTU_VERSION=18.04
R_VERSION=3.6.0
MRAN_DATE=2019-07-05
SHINY_VERSION=1.5.9.923

all: deps minimal base test 

deps:
	docker build --build-arg UBUNTU_VERSION=${UBUNTU_VERSION} --tag r-deps:${R_VERSION} r-deps

minimal:
	docker build --build-arg R_VERSION=${R_VERSION} --build-arg MRAN_DATE=${MRAN_DATE} --tag r-minimal:${R_VERSION} r-minimal

base:
	docker build --build-arg R_VERSION=${R_VERSION} --tag r-base:${R_VERSION} r-base

test:
	cd r-test && \
	docker build --build-arg R_VERSION=${R_VERSION} --tag r-test:${R_VERSION} .

shiny:
	cd shiny && \
	docker build --build-arg R_VERSION=${R_VERSION} --build-arg SHINY_VERSION=${SHINY_VERSION} --tag shiny:${R_VERSION}-${SHINY_VERSION} .

