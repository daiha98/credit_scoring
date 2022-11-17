library(tidyverse)
library(caret)
library(xgboost)
library(plumber)

options(scipen = 999, warn=-1)

#* @apiTitle Credit Scoring Model
#* @apiDescription API to predict new records for loan request.
#* @apiVersion V0

#* Read model

xg_model <- readr::read_rds(
  "xg_model.RDS")

#* Test if API service is running properly
#* @get /connection-status
function(){
  
  list(
    status = "Connection to xg_model API sucessfully done.",
    time = base::Sys.time(),
    version.string = version$version.string)
  
}

#* Predict new records individually
#* @param age
#* @param agesInResidence
#* @param agesInTheJob
#* @param bestPaymentDay
#* @param personalNetIncome
#* @post /predict
predictions <- function(
    age, agesInResidence, agesInTheJob, bestPaymentDay, personalNetIncome){
  
  new_records <- base::data.frame(
    age = base::as.integer(age), 
    agesInResidence = base::as.integer(agesInResidence), 
    agesInTheJob = base::as.integer(agesInTheJob), 
    bestPaymentDay = base::as.integer(bestPaymentDay), 
    personalNetIncome = base::as.numeric(personalNetIncome)
  )
  
  new_records <- new_records %>%
    dplyr::mutate(personalLifeIncome = base::as.numeric(personalNetIncome * 12 * agesInTheJob))
  
  prediction <- predict(
    object = xg_model, newdata = new_records, type = "prob")
  
  return(base::list(bad.1_probability = prediction[1, 2]))
  
}

#* @plumber 
function(pr){
  
  pr %>%
    plumber::pr_set_serializer(plumber::serializer_unboxed_json())
  
}
