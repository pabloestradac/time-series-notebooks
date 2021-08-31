****************************************************************************************************
* Time Series in Stata

* TS Operators

* Lags:
l.var = var_t-1
l2.var = var_t-2

* Forward:
f.var = var_t+1

* Differences:
d.var = var_t - var_t-1
d2.var = (var_t - var_t-1) - (var_t-1 - var_t-2)= var_t - 2var_t-1 + var_t-2

 *Seasonals:
s.var = var_t - var_t-1
s2.var = var_t - var_t-2
s12.var = var_t - var_t-12
