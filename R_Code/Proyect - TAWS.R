library(tseries)

#Through this function the databases are enabled: Unemployment_female / Unemployment_male
attach(unemployment_female)
attach(unemployment_male)

#Histograms
#Histogram of the variable unemployment female
hist(unemployment_female$Number, main = "Histogram of the variable unemployment female", col = "lightsalmon", xlab = "Unemployment female", ylab = "Frequency")

#Histogram of the variable unemployment male
hist(unemployment_male$Number, main = "Histogram of the variable unemployment male", col = "royalblue1", xlab = "Unemployment male", ylab = "Frequency")


#Time Series
#Time series unemployment female (This graph only shows the points corresponding to unemployment female according to the date)
plot(unemployment_female, main = "Time Series of the unemployment female", col = "lightsalmon", ylab = "Unemployment female", xlab = "Year")

#Time series unemployment female (This graph shows the time series corresponding to unemployment female)
unemployment_female_ts = ts(unemployment_female$Number, start = c(2013,1), frequency = 12)
print(unemployment_female_ts) #This function shows a table about unemployment female: rows -> year, columns -> Months
plot(unemployment_female_ts, main = "Time Series of the unemployment female", col = "lightsalmon",  ylab = "Unemployment female", xlab = "Year")

#Time series unemployment male (This graph only shows the points corresponding to unemployment male according to the date)
plot(unemployment_male, main = "Time Series of the unemployment male", col = "royalblue1", ylab = "Unemployment male", xlab = "Year")

#Time series unemployment male (This graph shows the time series corresponding to unemployment male)
unemployment_male_ts = ts(unemployment_male$Number, start = c(2013,1), frequency = 12)
print(unemployment_male_ts) #This function shows a table about unemployment male: rows -> year, columns -> Months
plot(unemployment_male_ts, main = "Time Series of the unemployment male", col = "royalblue1",  ylab = "Unemployment male", xlab = "Year")


#Boxplots
#Boxplot(Unemployment Female)
boxplot(unemployment_female_ts ~ cycle(unemployment_female_ts), main = "Boxplot - Unemployment Female", col = "lightsalmon")

#Boxplot(Unemployment Male)
boxplot(unemployment_male_ts ~ cycle(unemployment_male_ts), , main = "Boxplot - Unemployment Male", col = "royalblue1")


#Decomposition of additive time series: This function shows the structural components of an observed time series
#Observed time series = Trend + Seasonal effect + Random

#Decomposition of additive time series (Unemployment Female)
unemployment_female_desc <- decompose(unemployment_female_ts)
plot(unemployment_female_desc, xlab = "Year",  col = "lightsalmon")

#Decomposition of additive time series (Unemployment Male)
unemployment_male_desc <- decompose(unemployment_male_ts)
plot(unemployment_male_desc, xlab = "Year", col = "royalblue1")

#Transformation Of the serie
#Stabilization of variance
unemployment_female_log <- log(unemployment_female_ts)
unemployment_male_log <- log(unemployment_male_ts)
plot(unemployment_female_log, xlab = "Year", ylab = "Unemployment Female", col = "lightsalmon", main = "Stabilization of variance")
plot(unemployment_male_log, xlab = "Year", ylab = "Unemployment Male", col = "royalblue1", main = "Stabilization of variance")

#Dickey-Fuller Test (1)
adf.test(unemployment_female_log,k = 12)
adf.test(unemployment_male_log,k = 12)
#As we can see, the p-values are greater than the level of significance (p>0.05), so the conclusion 
#is that the series are not stationary one.

#Trend elimination
unemployment_female_diff <- diff(unemployment_female_log)
unemployment_male_diff <- diff(unemployment_male_log)
plot(unemployment_female_diff, xlab = "Year", ylab = "Unemployment Female", col = "lightsalmon", main = "Trend elimination")
plot(unemployment_male_diff, xlab = "Year", ylab = "Unemployment Male", col = "royalblue1", main = "Trend elimination")


#Dickey-Fuller Test (2)
adf.test(unemployment_female_diff,k = 12)
adf.test(unemployment_male_diff,k = 12)
#As we can see, the p-values are greater than the level of significance (p>0.05), so the conclusion 
#is that the series are not integrated in order one I(1)

# Elimination of seasonality
unemployment_female_diff2 <- diff(unemployment_female_diff)
unemployment_male_diff2 <- diff(unemployment_male_diff)
plot(unemployment_female_diff2, xlab = "Year", ylab = "Unemployment Female", col = "lightsalmon", main = "Elimination of seasonality")
plot(unemployment_male_diff2, xlab = "Year", ylab = "Unemployment Male", col = "royalblue1", main = "Elimination of seasonality")

#Dickey-Fuller Test (3)
adf.test(unemployment_female_diff2,k = 12)
adf.test(unemployment_male_diff2,k = 12)
#As we can see, the p-value is smaller than the level of significance (p<0.05), so the conclusion 
#is that the series are integrated in order one I(2)

#Autocorrelation function estimation & Partial Autocorrelation function estimation
library(astsa)
acf2(unemployment_female_diff2, plot = TRUE, main = "ACF & PACF - Unemployment Female")

#Cross-Correlation Function Estimation
ccf(unemployment_female_diff2,unemployment_male_log, plot = TRUE, main = "CCF - Unemployment Female & Unemployment Male")

# ARIMA MODEL 

# AR 
ar(unemployment_female_diff2)

# Stimation
# AR
simf1<-arima.sim(list(ar=c(-0.5)),n=200,innov=unemployment_female_log)
simf2<-arima.sim(list(ar=c(.5,-0.5)),n=200,innov=unemployment_female_log)
simf3<-arima.sim(list(ar=c(.2,-.4,.6)),n=200,innov=unemployment_female_log)
simf4<-arima.sim(list(ar=c(.5,.4,-.6,.4)),n=200,innov=unemployment_female_log)

ts.plot(simf1)
ts.plot(simf2)
ts.plot(simf3)
ts.plot(simf4)

acf2(simf1, plot = TRUE, main = "ACF & PACF - Unemployment Female Simf1")
acf2(simf2, plot = TRUE, main = "ACF & PACF - Unemployment Female Simf2") 
acf2(simf3, plot = TRUE, main = "ACF & PACF - Unemployment Female Simf3")
acf2(simf4, plot = TRUE, main = "ACF & PACF - Unemployment Female Simf4")

arima(simf1)
arima(simf2)
arima(simf3)
arima(simf4)

# MA
simff1<-arima.sim(list(ma=c(1)),n=200,innov=unemployment_female_log)
simff2<-arima.sim(list(ma=c(1,-1)),n=200,innov=unemployment_female_log)
simff3<-arima.sim(list(ma=c(1,1,1)),n=200,innov=unemployment_female_log)
simff4<-arima.sim(list(ma=c(1/4,1/4,1/4,1/4)),n=200,innov=unemployment_female_log)

ts.plot(simff1)
ts.plot(simff2)
ts.plot(simff3)
ts.plot(simff4)

acf2(simff1, plot = TRUE, main = "ACF & PACF - Unemployment Female Simff1")
acf2(simff2, plot = TRUE, main = "ACF & PACF - Unemployment Female Simff2") 
acf2(simff3, plot = TRUE, main = "ACF & PACF - Unemployment Female Simff3")
acf2(simff4, plot = TRUE, main = "ACF & PACF - Unemployment Female Simff4")

arima(simff1)
arima(simff2)
arima(simff3)
arima(simff4)

# ARIMA
arima(unemployment_female_diff2)
arima(unemployment_male_log)

arima.sim(unemployment_female_diff2)
arima.sim(unemployment_male_log)
