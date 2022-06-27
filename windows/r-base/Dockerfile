FROM mcr.microsoft.com/windows/servercore:ltsc2019

ARG R_VERSION

RUN curl.exe -o rtools.exe https://cran.r-project.org/bin/windows/Rtools/rtools42/files/rtools42-5253-5107-signed.exe && rtools.exe /VERYSILENT -NoNewWindow -Wait && del rtools.exe

RUN curl.exe -o R-%R_VERSION%-win.exe https://cran.r-project.org/bin/windows/base/old/%R_VERSION%/R-%R_VERSION%-win.exe && R-%R_VERSION%-win.exe /VERYSILENT /DIR="C:\R" && del R-%R_VERSION%-win.exe

RUN setx /M path "%path%;C:\R\bin;C:\rtools42\usr\bin"


ARG MRAN_DATE

RUN echo options(repos = c(MRAN = "https://mran.microsoft.com/snapshot/%MRAN_DATE%")) >> "C:\R\library\base\R\Rprofile"

USER ContainerUser

RUN echo "R_LIBS_USER=~/R/%p-library/%V" >> "%USERPROFILE%\Documents\.Renviron"

RUN Rscript -e "dir.create(Sys.getenv('R_LIBS_USER'), recursive = TRUE)"

RUN Rscript -e "install.packages('remotes'); unlink(file.path(Sys.getenv('TMP'), '*'), recursive = TRUE)"

CMD [ "R", "--no-save" ]

