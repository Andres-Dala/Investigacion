library(forecast)
library(dplyr)
library(ggplot2)
library(tsibble)
library(bayesforecast)
library(cowplot)
library(loo)
library(bayesplot)

#Get data

data<-read.csv("Investigaciones/R Journal/temperature.csv")
serie<-ts(data$AverageTemperature, frequency = 12, start = 1980)

train = head(serie, round(length(serie) * 0.95))
h = length(serie) - length(train)
test = tail(serie, h)

#Data visualization

autoplot(object = train, ylab="Celsius", xlab = "Years",size=1) +
  theme(panel.background = element_rect(fill = "white", colour = "black",
                                        size = 1, color = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.text=element_text(size=12, color = "black"),
        axis.title=element_text(size=14,family="serif"))
# ACF and PACF plots

g1=cbind("Seasonally\n differenced" = diff(train,12),
      "Doubly\n differenced" = diff(diff(train,12))) %>%
  autoplot(facets = TRUE) +
  xlab("Years") + ylab("") +
  theme(panel.background = element_rect(fill = "white", colour = "black",
                                        size = 2, color = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.text=element_text(size=12, color = "black"),
        axis.title=element_text(size=14,family="serif"),
        strip.text.y  = element_text(size = 13))


g2 = ggacf(y = diff(train))  +
  theme(panel.background = element_rect(fill = "white", colour = "black",
                                        size = 2, color = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.text=element_text(size=12, color = "black"),
        axis.title=element_text(size=14,family="serif"))

g3 = ggpacf(y = diff(train))  +
  theme(panel.background = element_rect(fill = "white", colour = "black",
                                        size = 2, color = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.text=element_text(size=12, color = "black"),
        axis.title=element_text(size=14,family="serif"))

g4<-plot_grid(g2,g3, labels = NULL)
plot_grid(g1,g4, labels = NULL, ncol = 1, rel_heights = c(1.3,1))

# Figure 5

sf1Pars = data.frame(extract_stan(sf1, pars = c("mu0","ar")))
sf1Pars = cbind(Chain = sort(rep(1:4,1000)),sf1Pars)

sf2Pars = data.frame(extract_stan(sf1, pars = c("sigma0","ma")))
sf2Pars = cbind(Chain = sort(rep(1:4,1000)),sf2Pars)

sf3Pars = data.frame(extract_stan(sf1, pars = c("loglik","sar")))
sf3Pars = cbind(Chain = sort(rep(1:4,1000)),sf3Pars)

t1<-mcmc_combo(sf1Pars, widths = c(1,2),
               gg_theme = xaxis_text(angle=90)+ legend_none())

t2<-mcmc_combo(sf2Pars, widths = c(1,2),
               gg_theme = xaxis_text(angle=90)+ legend_none())

t3<-mcmc_combo(sf3Pars,widths = c(1,2.5),
               gg_theme = xaxis_text(angle=90))

plot_grid(t1,t2,t3, labels = NULL, ncols = 3, nrow = 1, rel_widths = c(1,1,1)) 

# Figure 6

check_residuals(sf1) 

# figure 7

forecast1<-forecast(sf1, h = 20)
pred<-ts(forecast1$mean, frequency = 12, start = c(2012,2))
forecast2<-forecast(sf2, h = 20)
pred2<-ts(forecast2$mean, frequency = 12, start = c(2012,2))
forecast3<-forecast(sf3, h = 20)
pred3<-ts(forecast3$mean, frequency = 12, start = c(2012,2))

co<-data.frame("Model 1" = pred, "Model 2" = pred2, 
               "Model 3" = pred3, "Test" = test)

comb<-ts(co, frequency = 12, start = c(2012,2))

autoplot(comb[,c("Model.1", "Model.2","Model.3", "Test")],size=1) +
  ylab("Celsius") + xlab("Years")  +
  theme(panel.background = element_rect(fill = "white", colour = "black",
                                        size = 1, color = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.text=element_text(size=12, color = "black"),
        axis.title=element_text(size=14,family="serif"))

#forecast

sf4<-stan_sarima(serie, order = c(2,1,2), seasonal = c(2,1,0))

ff<-forecast(sf4,15)

autoplot(ff)  + labs(title = "", y = "Celsius", x = "Years")  +
  xlim(2010,2015) + 
  
  theme(panel.background = element_rect(fill = "white", colour = "black",
                                        size = 1, color = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.text=element_text(size=12, color = "black"),
        axis.title=element_text(size=14,family="serif"))

