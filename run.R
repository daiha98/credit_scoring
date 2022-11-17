library(plumber)
options(warn=-1)

plumber::plumb(
  file='plumber.R')$run(
    port = 5958, host = "0.0.0.0", 
    swagger = TRUE
  )

