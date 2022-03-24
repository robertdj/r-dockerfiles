REGISTRY=robertdj
UBUNTU_VERSION=20.04
R_VERSION=4.1.2
MRAN_DATE=2022-03-10
SHINY_VERSION=1.5.17.973

all: deps minimal base test 

deps:
	DOCKER_BUILDKIT=1 docker build --build-arg UBUNTU_VERSION=${UBUNTU_VERSION} --tag ${REGISTRY}/r-deps:${R_VERSION} r-deps

minimal:
	DOCKER_BUILDKIT=1 docker build --build-arg R_VERSION=${R_VERSION} --build-arg MRAN_DATE=${MRAN_DATE} --tag ${REGISTRY}/r-minimal:${R_VERSION} r-minimal

base:
	DOCKER_BUILDKIT=1 docker build --build-arg R_VERSION=${R_VERSION} --tag ${REGISTRY}/r-base:${R_VERSION} r-base

test:
	DOCKER_BUILDKIT=1 docker build --build-arg R_VERSION=${R_VERSION} --tag ${REGISTRY}/r-test:${R_VERSION} r-test

shiny:
	cd shiny-server && \
	DOCKER_BUILDKIT=1 docker build --build-arg R_VERSION=${R_VERSION} --build-arg SHINY_VERSION=${SHINY_VERSION} --tag ${REGISTRY}/shiny:${R_VERSION}-${SHINY_VERSION} .



minimal-cst:
	container-structure-test test --config r-minimal/minimal-tests.yaml --image ${REGISTRY}/r-minimal:${R_VERSION}

base-cst:
	container-structure-test test --config r-base/base-tests.yaml --image ${REGISTRY}/r-base:${R_VERSION}

shiny-cst:
	container-structure-test test --config shiny/shiny-tests.yaml --image ${REGISTRY}/shiny:${R_VERSION}-${SHINY_VERSION} 
