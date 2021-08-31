// Generate trend
gen trend = _n
gen trend2 = trend ^ 2
gen trend3 = trend ^ 3

// Record mean to use it later
summ y, meanonly
gen meany = r(mean)

// Dummies estacionales (mensuales)
//gen w = week(dofw(time))
gen m = month(dofm(time))
//gen q = quarter(dofq(time))
//gen h = halfyear(dofh(time))
tab m, gen(md)

// Trend variable
eststo clear
eststo: quietly reg y trend, robust //
eststo: quietly reg y trend trend2, robust //
eststo: quietly reg y trend trend2 trend3, robust //
esttab, se star(* 0.10 ** 0.05 *** 0.01)

// Escoge el mejor modelo y...
predict ynet, resid
predict yhat, xb
tsline y ynet yhat
corrgram ynet, lags(20)
wntestq ynet
wntestb ynet
