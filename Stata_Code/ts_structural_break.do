********* STRUCTURAL BREAK *********

** Theoretical break
gen dbreak = (time>=tq(2000q1))
tab dbreak
tsline vary, tline(2000q1)

** Chow's test for a single variable
reg vary dbreak, robust       // White errors
newey vary dbreak, lag(4)     // HAC errors
regress vary dbreak if trend>5 & trend<87, vce(bootstrap, cluster(time) reps(1000) seed(1234))    // Small data sample
** Chow's test for model parameters
regress vary varx if dbreak==0, robust    // Unrestricted
reg vary varx if dbreak==1, robust
reg vary varx, robust             // Restricted
** Test based on SSE
estat sbknown, break(tq(2000q1))
** Chow's test dummy version
gen dx = dbreak*varx
reg vary dbreak varx dx, robust
test dbreak dx        // Hipotesis conjunta de que no hay quiebre estructural

** CUSUM test for single variable
cusum dbreak varx     // Construye un intervalo de confianza de la sumatoria acumulada de la variable en el tiempo
cusum6 vary trend if trend<87, cs(cusum) lw(lower) uw(upper)
tsline cusum lower upper
reg vary varx, robust
estat sbsingle
