Dockerfiles for R
=================

Greatly inspired by the [Version-stable Rocker images](https://github.com/rocker-org/rocker-versioned), but using Ubuntu instead of Debian.

Check the [Makefile](r-base/Makefile) for build commands for the `r-base` images.

The `r-devtools` image is based on an `r-base` image and you must choose the R version (tag). To use e.g. version 3.4.3 run this command in the `r-devtools` folder:

	docker build --build-arg R_VERSION=3.4.3 --tag r-devtools:3.4.3 .


# License

For the `r-base` image I have scrutinized the Dockerfiles for the Version-stable Rocker images and therefore I have no but to use the GPL 2 license.

The other Dockerfiles are licensed under MIT.

