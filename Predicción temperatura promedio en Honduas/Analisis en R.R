library(tidyverse)
library(forecast)
datos<-read.csv("https://raw.githubusercontent.com/Andres-Dala/Seminario_de_Investigacion_MM700/main/R/LandTemperature.csv")
# Origen de los datos : 
#  http://berkeleyearth.org/data/
#  https://data.world/data-society/global-climate-change-data/workspace/project-summary?agentid=data-society&datasetid=global-climate-change-data

honduras<-datos %>%
  filter(Country == "Honduras")

honduras$dt<-as.Date(honduras$dt)

honduras <- honduras %>%
  filter(as.numeric(format(dt,"%Y"))>=1980)

honduras <- honduras %>%
  select(dt, AverageTemperature)

serie1<-ts(honduras$AverageTemperature, frequency = 12, start = 1980)

autoplot(object = serie1, main = "Temperatura promedio en Honduras", ylab = "Celsius", xlab = "Años")
