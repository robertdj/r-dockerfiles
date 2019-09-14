Dockerfiles for R
=================

Greatly inspired by the [Version-stable Rocker images](https://github.com/rocker-org/rocker-versioned), but using Ubuntu instead of Debian.


# Base

The `r-base` images contains a compiled R and the [remotes package](https://cran.r-project.org/package=remotes).

An image depends on three `build-arg`'s: The Ubuntu version, the R version and the [MRAN snapshot](https://mran.microsoft.com/documents/rro/reproducibility#snapshot) to download packages from.
Check the [Makefile](r-base/Makefile) for standard combinations of build commands.

The remotes package makes it easy to copy your R package into the image and make a local installation.


# Test

The `r-test` image is used a *base* image for testing R packages and save test results in the JUnit XML format and code coverage in the Cobertura format. It builds on `r-base` and you must therefore choose a version of R.

However, `r-test` does not run on it own -- you have to use `r-test` as a `FROM` image and copy the source of an R packages into `/home/shiny/package`. That is, include a Dockerfile with the following content in the top folder of your R package:

    FROM r-test:3.5.0

    COPY --chown=shiny:shiny . /home/shiny/package

Any system requirements must be installed before the `COPY` line.


# Shiny

The shiny image contains a Shiny server installed from source as [described in the Shiny server's wiki](https://github.com/rstudio/shiny-server/wiki/Building-Shiny-Server-from-Source).

The configuration file `shiny-server.conf` is very basic:
It exposes the Shiny server at port 3838 and includes some example apps.

Example apps from Shiny server are available at `<url>/sample-apps`.

Example apps from the [shiny package](https://cran.r-project.org/package=shiny) are available at `<url>/<app name>`, where `<app name>` is one of the following: 
`01_hello`; `02_text`; `03_reactivity`; `04_mpg`; `05_sliders`; `06_tabsets`; `07_widgets`; `08_html`; `09_upload`; `10_download`; `11_timer`.


# License

For the `r-base` image I have scrutinized the Dockerfiles for the Version-stable Rocker images and therefore I have no choice but to use the GPL 2 license.

The other Dockerfiles are licensed under MIT.

