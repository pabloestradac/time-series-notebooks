// Auto regressive
arima y, ar(1) nolog                     // By MLE
arima y, arima(1,0,0) nolog                 // By MLE, more restrictive
arima y, ar(1/4) nolog

// Moving average
arima y, ma(1/3) nolog
arima y trend, ma(1/3) nolog // Un shock de una unidad genera un efecto de 0.17 unidades

// Automatic
eststo clear
forvalues i=2(1)6{
  eststo arima`i': qui arima y, ma(1/`i') nolog
  predict yhat`i'      // within sample prediction
  predict res1to`i', resid
}
sktest res1to*
tsline y yhat*
estimates stats arima* // Busca al valor mas pequeno


// Out-of-sample forecast
predict variable_y, y                            // One-step ahead, utiliza la informacion real. Puedo hacer esto porque use el operador diferencia
predict variable_y, dynamic(tm(2017m11)) y      // Estimacion dinamica, utiliza el pronostico como una observacion
tsline yinf finf_ma dfinf_ma if time>=tm(2016m1), tline(2017m11)
list time yinf finf_ma dfinf_ma if time>=tm(2017m1)


// Normality Test
sktest res                          // Todos son menores a 0.05 y por tanto no son normales
swilk res                         // Test de Shapiro-Wilk
qnorm res, grid                         // Normal quantile plot
