REGISTRY=robertdj
UBUNTU_VERSION=20.04
R_VERSION=4.1.1
MRAN_DATE=2021-11-01
SHINY_VERSION=1.5.17.973

all: deps minimal base test 

deps:
	DOCKER_BUILDKIT=1 docker build --build-arg UBUNTU_VERSION=${UBUNTU_VERSION} --tag ${REGISTRY}/r-deps:${R_VERSION} r-deps

minimal:
	DOCKER_BUILDKIT=1 docker build --build-arg R_VERSION=${R_VERSION} --build-arg MRAN_DATE=${MRAN_DATE} --tag ${REGISTRY}/r-minimal:${R_VERSION} r-minimal

base:
	DOCKER_BUILDKIT=1 docker build --build-arg R_VERSION=${R_VERSION} --tag ${REGISTRY}/r-base:${R_VERSION} r-base

test:
	cd r-test && \
	DOCKER_BUILDKIT=1 docker build --build-arg R_VERSION=${R_VERSION} --tag ${REGISTRY}/r-test:${R_VERSION} .

shiny:
	cd shiny && \
	DOCKER_BUILDKIT=1 docker build --build-arg R_VERSION=${R_VERSION} --build-arg SHINY_VERSION=${SHINY_VERSION} --tag ${REGISTRY}/shiny:${R_VERSION}-${SHINY_VERSION} .

