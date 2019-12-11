FROM mcr.microsoft.com/windows/servercore:ltsc2019 as builder

ARG R_VERSION

RUN curl.exe -o R-%R_VERSION%-win.exe https://cran.r-project.org/bin/windows/base/old/%R_VERSION%/R-%R_VERSION%-win.exe

RUN R-%R_VERSION%-win.exe /VERYSILENT /DIR="C:\R\"

RUN curl.exe -o Rtools.exe https://cran.r-project.org/bin/windows/Rtools/Rtools35.exe

RUN Rtools.exe /TYPE=full /VERYSILENT -NoNewWindow -Wait


# ------------------------------------------------------------------------------

FROM mcr.microsoft.com/windows/servercore:ltsc2019

COPY --from=builder C:\\R C:\\R

COPY --from=builder C:\\Rtools C:\\Rtools

RUN setx path "%path%;C:\R\bin;C:\Rtools\bin"

ARG MRAN_DATE

RUN echo options(repos = c(CRAN = "https://mran.microsoft.com/snapshot/%MRAN_DATE%")) >> C:\R\library\base\R\Rprofile

RUN Rscript.exe -e "install.packages('remotes')"

CMD [ "R.exe", "--no-save" ]

