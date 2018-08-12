Dockerfiles for R
=================

Greatly inspired by the [Version-stable Rocker images](https://github.com/rocker-org/rocker-versioned), but using Ubuntu instead of Debian.

Check the [Makefile](r-base/Makefile) for build commands for the `r-base` images.


# Devtools

The `r-devtools` image is based on an `r-base` image and you must choose the R version (tag). To use e.g. version 3.4.3 run this command in the `r-devtools` folder:

	docker build --build-arg R_VERSION=3.4.3 --tag r-devtools:3.4.3 .


# Test

The `r-test` image is used a *base* image for testing R packages and save test results in the JUnit XML format and code coverage in the Cobertura format. It builds on `r-devtools` and you must therefore choose a version of R.

However, `r-test` does not run on it own -- you have to use `r-test` as a `FROM` image and copy the source of an R packages into `/home/shiny/package`. That is, include a Dockerfile with the following content in the top folder of your R package:

    FROM r-test:3.4.4

    COPY --chown=shiny:shiny . /home/shiny/package


# License

For the `r-base` image I have scrutinized the Dockerfiles for the Version-stable Rocker images and therefore I have no choice but to use the GPL 2 license.

The other Dockerfiles are licensed under MIT.

