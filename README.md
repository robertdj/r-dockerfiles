Dockerfiles for R
=================

Greatly inspired by the [Version-stable Rocker images](https://github.com/rocker-org/rocker-versioned), but using Ubuntu instead of Debian.

The `Makefile` contains commands to build each of the Linux images.
Check the file to see the build arguments for Docker.

# Deps

Contains the runtime dependencies for R.


# Minimal

The `r-minimal` image contains R and the [remotes package](https://cran.r-project.org/package=remotes), but no compilers.
The repository is set to an appropriate [MRAN snapshot](https://mran.microsoft.com/documents/rro/reproducibility#snapshot) to ensure compatability with the R version.


# Base

The `r-base` image is based on `r-minimal` and contains C(++) and Fortran compilers.


# Test

The `r-test` image is used as a *base* image for testing R packages. 
The image has the [covr package](https://cran.r-project.org/package=covr), the [devtools package](https://cran.r-project.org/package=devtools), the [roxygen2 package](https://cran.r-project.org/package=roxygen2) and the [testthat package](https://cran.r-project.org/package=testthat) installed.

To test a package in `r-test` copy it to the folder `/home/shiny/package` and run the script `/home/shiny/run_tests.R` to

- Install the package and all its dependencies.
- Run the tests and save the results in JUnit format in the file `test-results.xml`.
- Compute code coverage and save the results in Cobertura format in the file `coverage.xml`.


# Shiny

The shiny image contains a Shiny server installed from source as [described in Shiny server's wiki](https://github.com/rstudio/shiny-server/wiki/Building-Shiny-Server-from-Source).

The configuration file `shiny-server.conf` is very basic:
It exposes the Shiny server at port 3838 and includes some example apps.

Example apps from Shiny server are available at `<url>/sample-apps`.

Example apps from the [shiny package](https://cran.r-project.org/package=shiny) are available at `<url>/<app name>`, where `<app name>` is one of the following: 
- `01_hello`
- `02_text`
- `03_reactivity`
- `04_mpg`
- `05_sliders`
- `06_tabsets`
- `07_widgets`
- `08_html`
- `09_upload`
- `10_download`
- `11_timer`


# Windows

The `windows` folder contain Dockerfiles for an `r-base` image and an `r-test` image that are counterparts to the Linux images above, but based on a [Windows Server Core image](https://hub.docker.com/_/microsoft-windows-servercore).
These images have R and [Rtools](https://cran.r-project.org/bin/windows/Rtools) installed and the same packages as their Linux counterparts.

The Dockerfile for `r-base` contain long lines because the usual "newline character" in Windows' CMD (the caret `^`) is not parsed correctly by Docker.


# License

For the `r-minimal` image I have scrutinized the Dockerfiles for the Version-stable Rocker images and therefore I have no choice but to use the GPL 2 license.

The other Dockerfiles are licensed under MIT.

