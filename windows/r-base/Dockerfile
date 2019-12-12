FROM mcr.microsoft.com/windows/servercore:ltsc2019 as builder

ARG R_VERSION

RUN curl.exe -o R-%R_VERSION%-win.exe https://cran.r-project.org/bin/windows/base/old/%R_VERSION%/R-%R_VERSION%-win.exe

RUN R-%R_VERSION%-win.exe /VERYSILENT /DIR="C:\R\"

RUN curl.exe -o Rtools.exe https://cran.r-project.org/bin/windows/Rtools/Rtools35.exe

RUN Rtools.exe /VERYSILENT -NoNewWindow -Wait


# ------------------------------------------------------------------------------

FROM mcr.microsoft.com/windows/servercore:ltsc2019

COPY --from=builder ["C:/R", "C:/Program Files/R"]

COPY --from=builder C:/Rtools C:/Rtools

ARG MRAN_DATE

# RUN echo options(repos = c(CRAN = "https://mran.microsoft.com/snapshot/%MRAN_DATE%")) >> "C:\Program Files\R\library\base\R\Rprofile"
RUN echo options(repos = c(CRAN = "https://cloud.r-project.org")) >> "C:\Program Files\R\library\base\R\Rprofile"

USER ContainerUser

RUN setx path "%path%;C:\Program Files\R\bin;C:\Rtools\bin"

RUN echo "R_LIBS_USER=~/R/%p-library/%V" >> "C:\Users\ContainerUser\Documents\.Renviron"
RUN Rscript -e "dir.create(Sys.getenv('R_LIBS_USER'), recursive = TRUE)"

RUN Rscript -e "install.packages('remotes')"

CMD [ "R", "--no-save" ]

