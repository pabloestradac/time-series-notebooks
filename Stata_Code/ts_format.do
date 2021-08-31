****************************************************************************************************
* Time Series in Stata

* We need to tell Stata the data frequency: daily, weekly, quarterly, annual.
generate time = q(1994q2) + _n-1
format time %tq
tsset time              // Tell Stata which is your time reference variable
                        // Alternatively: tsset time, quarterly

* Other options:
* Yearly
gen time = y(1994)+_n-1
format time %ty
* Semester
gen time=h(1994h1)+_n-1
format time %th
* Monthly
gen time=m(1994m1)+_n-1
format time %tm
* Weekly
gen time=w(1994w1)+_n-1
format time %tw
* Daily
gen time=d(1jan1994)+_n-1
format time %td
