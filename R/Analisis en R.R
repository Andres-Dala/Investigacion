library(tidyverse)
library(forecast)
datos1<-read.csv("C:/Users/Andres Dala/Downloads/GlobalLandTemperaturesByCountry.csv")
datos2<-read.csv("C:/Users/Andres Dala/Downloads/GlobalTemperatures.csv")

honduras<-datos1 %>%
  filter(Country == "Honduras")

honduras$dt<-as.Date(honduras$dt)

honduras <- honduras %>%
  filter(as.numeric(format(dt,"%Y"))>=1980)

honduras <- honduras %>%
  select(dt, AverageTemperature)

serie1<-ts(honduras$AverageTemperature, frequency = 12, start = 1980)

autoplot(object = serie1)
