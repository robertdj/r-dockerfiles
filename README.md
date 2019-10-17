Dockerfiles for R
=================

Greatly inspired by the [Version-stable Rocker images](https://github.com/rocker-org/rocker-versioned), but using Ubuntu instead of Debian.

The `Makefile` contains commands to build each of the images.
Check the file to see the build arguments for Docker.


# Minimal

The `r-minimal` image contains R and the [remotes package](https://cran.r-project.org/package=remotes), but no compilers.
The repository is set to an appropriate [MRAN snapshot](https://mran.microsoft.com/documents/rro/reproducibility#snapshot) to ensure compatability with the R version.


# Base

The `r-base` image is based on `r-minimal` and contains C(++) and Fortran compilers.


# Test

The `r-test` image is used as a *base* image for testing R packages and save test results in the JUnit XML format and code coverage in the Cobertura format. 

However, `r-test` does not run on it own -- you have to use `r-test` as a `FROM` image and copy the source of an R packages into `/home/shiny/package`. That is, include a Dockerfile with the following content in the top folder of your R package:

    FROM r-test:3.5.0

    COPY --chown=shiny:shiny . /home/shiny/package

Any system requirements must be installed before the `COPY` line.


# Shiny

The shiny image contains a Shiny server installed from source as [described in Shiny server's wiki](https://github.com/rstudio/shiny-server/wiki/Building-Shiny-Server-from-Source).

The configuration file `shiny-server.conf` is very basic:
It exposes the Shiny server at port 3838 and includes some example apps.

Example apps from Shiny server are available at `<url>/sample-apps`.

Example apps from the [shiny package](https://cran.r-project.org/package=shiny) are available at `<url>/<app name>`, where `<app name>` is one of the following: 
`01_hello`; `02_text`; `03_reactivity`; `04_mpg`; `05_sliders`; `06_tabsets`; `07_widgets`; `08_html`; `09_upload`; `10_download`; `11_timer`.


# License

For the `r-minimal` image I have scrutinized the Dockerfiles for the Version-stable Rocker images and therefore I have no choice but to use the GPL 2 license.

The other Dockerfiles are licensed under MIT.

