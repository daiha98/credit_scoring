# Funcoes de uso global

## 1 - Renderizar o RMD (sem criar outputs)

source_rmd <- function(file, ...) {
  tmp_file = tempfile(fileext=".R")
  on.exit(unlink(tmp_file), add = TRUE)
  knitr::purl(file, output=tmp_file)
  source(file = tmp_file, ...)
}
