FROM rocker/r-ver:4.2.1
RUN apt-get update -qq && apt-get install -y --no-install-recommends \
      libssl-dev \
      libxml2 \
      libcurl4-gnutls-dev
MAINTAINER Felipe Daiha Alves (Data Scientist)
RUN R -e "install.packages(c('tidyverse', 'caret', 'xgboost', 'plumber'), dependencies=TRUE)"
COPY . .
EXPOSE 80
ENTRYPOINT ["Rscript", "run.R"]