# Steps para execução do rmd sem precisar renderizar o output

wd <- paste0(getwd(), '/GitHub/credit_scoring/machine_learning/')

## 1 - config.R

source(paste0(wd, 'config/src/config.R'))

## 2 - creditScoring_ML.Rmd

source_rmd(paste0(wd, 'prod/creditScoring_ML.Rmd'))

# Salvando modelo em .RDS para aplicacao futura

base::saveRDS(
  xg_model, 
  paste0(getwd(), "/GitHub/credit_scoring/xg_model.RDS"))