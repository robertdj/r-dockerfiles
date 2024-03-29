REGISTRY = robertdj
UBUNTU_VERSION = 22.04
R_VERSION = 4.2.3
SHINY_VERSION = 1.5.20.1002

MINIMAL_NAME := ${REGISTRY}/r-minimal:${R_VERSION}
BASE_NAME    := ${REGISTRY}/r-base:${R_VERSION}
PPTM_NAME    := ${REGISTRY}/r-pptm:${R_VERSION}
TEST_NAME    := ${REGISTRY}/r-test:${R_VERSION}
SHINY_NAME   := ${REGISTRY}/shiny:${R_VERSION}-${SHINY_VERSION}

DOCKER_BUILD = DOCKER_BUILDKIT=1 docker build
R_BUILD_ARG := --build-arg R_VERSION=${R_VERSION}
CST = container-structure-test test


all: minimal base pptm test shiny

minimal:
	${DOCKER_BUILD} --build-arg UBUNTU_VERSION=${UBUNTU_VERSION} ${R_BUILD_ARG} --tag ${MINIMAL_NAME} r-minimal

base:
	${DOCKER_BUILD} ${R_BUILD_ARG} --tag ${BASE_NAME} r-base

pptm:
	${DOCKER_BUILD} ${R_BUILD_ARG} --tag ${PPTM_NAME} r-pptm

test:
	${DOCKER_BUILD} ${R_BUILD_ARG} --tag ${TEST_NAME} r-test

shiny:
	cd shiny-server && \
	${DOCKER_BUILD} ${R_BUILD_ARG} --build-arg SHINY_VERSION=${SHINY_VERSION} --tag ${SHINY_NAME} .


minimal-cst:
	${CST} --config r-minimal/minimal-tests.yaml --image ${MINIMAL_NAME}

base-cst:
	${CST} --config r-base/base-tests.yaml --image ${BASE_NAME}

test-cst:
	${CST} --config r-test/test-tests.yaml --image ${BASE_NAME}

shiny-cst:
	${CST} --config shiny-server/shiny-tests.yaml --image ${SHINY_NAME}

