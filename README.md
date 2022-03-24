Dockerfiles for R
=================

Dockerfiles related to the [R programming language](https://www.r-project.org) and RStudio's [Shiny Server](https://github.com/rstudio/shiny-server).
Greatly inspired by the [Version-stable Rocker images](https://github.com/rocker-org/rocker-versioned2).

The `Makefile` contains commands to build each of the Linux images.
Check the file to see the build arguments for Docker.

I have one folder for each image, but not for different versions.
Instead, each version of R has its own tag.
To get the files for e.g. R version 3.6.2, checkout the tag `v3.6.2`.
(This approach does not seem to work with automatic builds on Docker Hub, so I push selected images manually 😰)


# Deps

Contains the runtime dependencies for R.
Available on [Docker Hub](https://hub.docker.com/r/robertdj/r-deps).


# Minimal

The `r-minimal` image contains R and the package repository is set to an appropriate [MRAN snapshot](https://mran.microsoft.com/documents/rro/reproducibility#snapshot) to ensure compatability with the R version.
Available on [Docker Hub](https://hub.docker.com/r/robertdj/r-minimal).


# Base

The `r-base` image is based on `r-minimal` and contains C, C++ and Fortran compilers as well as the [{remotes} package](https://cran.r-project.org/package=remotes).
Available on [Docker Hub](https://hub.docker.com/r/robertdj/r-base).


# Test

The `r-test` image is used as a *base* image for testing R packages. 
The image has the [{covr} package](https://cran.r-project.org/package=covr), the [{devtools} package](https://cran.r-project.org/package=devtools), the [{roxygen2} package](https://cran.r-project.org/package=roxygen2) and the [{testthat} package](https://cran.r-project.org/package=testthat) installed.

The working dir in this image is `/home/shiny/package`.
My usecase is to copy/clone a package (repository) into this folder and then test it in `r-test`.


# Shiny

The shiny image contains a Shiny server installed from source as [described in Shiny server's wiki](https://github.com/rstudio/shiny-server/wiki/Building-Shiny-Server-from-Source).
Available on [Docker Hub](https://hub.docker.com/r/robertdj/shiny).

The configuration file `shiny-server.conf` is very basic:
It exposes the Shiny server at port 3838 and includes some example apps.

Example apps from Shiny server are available at `<url>/sample-apps`.

Example apps from the [{shiny} package](https://cran.r-project.org/package=shiny) are available at `<url>/<app name>`, where `<app name>` is one of the following: 
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

To test if the Shiny server is working, run the command

    docker run --rm -p <port>:3838 robertdj/shiny:<tag>

with an appropriate value of `<port>` (e.g. 3838) and navigate to this URL: <https://localhost:&lt;port&gt;>


# Windows

The `windows` folder contain Dockerfiles for an `r-base` image and an `r-test` image that are counterparts to the Linux images above, but based on a [Windows Server Core image](https://hub.docker.com/_/microsoft-windows-servercore).
These images have R and [Rtools](https://cran.r-project.org/bin/windows/Rtools) installed and the same packages as their Linux counterparts.

The Dockerfile for `r-base` contain long lines because the usual "newline character" in Windows' CMD (the caret `^`) is not parsed correctly by Docker.

The Windows images are not included in `Makefile`, but from the folder `windows/r-base` the following command builds the base image with an appropriate value of `<R version>` and associated `MRAN date`

```
docker build --build-arg R_VERSION=<R version> --build-arg MRAN_date=<MRAN date> --tag r-base:<R version> .
```

The `Makefile` contains R versions and matching MRAN dates.
In the folder `windows/r-test` the following command builds the test image:

```
docker build --build-arg R_VERSION=<R version> --tag r-test:<R version> .
```


# Details

Some technical considerations.


## BuildKit

The Linux Dockerfiles use the [BuildKit](https://docs.docker.com/develop/develop-images/build_enhancements) to enable faster builds and the use of [heredocs](https://www.docker.com/blog/introduction-to-heredocs-in-dockerfiles) in the Dockerfiles.


## Tests

I use [Container Structure Tests](https://github.com/GoogleContainerTools/container-structure-test) to test images.
The tests for an image is the `yaml` file in the same folder as the `Dockerfile` and the commands for testing are in `Makefile`.


## `whoami`

When this repo began, all images started R as a normal/non-privileged user.
This is in accordance with the [best practices for writing Dockerfiles](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#user). 
However, these best practices also recommend not to change users too often, which I did.

My current approach is that a user `shiny` is still available in all R images, but no images swich to `shiny`.
Instead, each image is considered a starting image -- use it in the `FROM` line of a Dockerfile and then swtich to `shiny` with `USER shiny` in the end.

The username of the non-root user is usually not important.
I use the username `shiny` because this is [Shiny Server's default non-root user](https://docs.rstudio.com/shiny-server/#running-shiny-server-with-root-privileges).


## Ubuntu

Why am I using Ubuntu as the Linux distribution?

- R packages (with system requirements) are usually tested on popular/larger Linux distributions, making the installation seamless (once the requirements are available).
- I use Ubuntu on my "daily laptop", so I have to figure out how to install R on Ubuntu anyway.

I have experimented with Alpine Linux, but 

- It is much more work to install packages with system requirements.
- The runtime dependencies for R actually make the final images so large that they are comparable in size to the Ubuntu images.


# License

For the `r-minimal` image I have scrutinized the Dockerfiles for the Version-stable Rocker images and therefore I have no choice but to use the GPL 2 license.

The other Dockerfiles are licensed under MIT.

