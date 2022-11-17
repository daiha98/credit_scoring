import requests
import json

connect_api_url = "http://127.0.0.1:5958/predict?"
data_payload=json.dumps({
    "age" : "62",
    "agesInResidence" : "27",
    "agesInTheJob" : "5",
    "bestPaymentDay" : "10",
    "personalNetIncome" : "25000"
  })

response = requests.post(
  connect_api_url,
  data=data_payload)
  
print(response.text)
