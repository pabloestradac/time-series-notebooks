****************************************************************************************************
* Graphing time series in Stata
****************************************************************************************************
// Simple
tsline pib
tsline ipc14
tsline pib depvis

// More elaborated
twoway line pib time, title("Tasa de crecimiento del PIBpc") ///
          subtitle("1994-2017", size(medium) color(black)) ///
          note(Fuente: BCE, size(small))

twoway connected pib time, title("Tasa de crecimiento del PIBpc") ///
          subtitle("1994-2017", size(medium) color(black)) ///
          note(Fuente: BCE, size(small))

twoway (line pib time) (line depvis time), ///
    title("Tasa de variación trimestral(%) PIBpc vs Depósitos a la vista ", size(medlarge) color(black)) ///
    legend(label(1 "PIB real per cápita")label(2 "Depósitos a la vista"))

// graph export pib1.pdf, as(pdf) replace
// graph export oil_trend.png, as(png) replace

/// Even some more
tsline pib, lwidth(thick) lcolor(midblue) yti("PIB real per cápita" " ", height(10)) || ///
  (tsline depvis, lwidth(thick) lcolor(orange_red) yaxis(2) ///
  yti(" " "Depósitos a la vista", height(10) axis(2)) ylabel(-39(13)39, axis(2))) in 2/86, xsize(20) ysize(7) ///
  xmtick(#2) xlabel(#44, labsize(small) angle(vertical)) xtitle("", height(9)) ylab(-6(2)6,nogrid) ///
  legend(label(1 "PIB real per cápita (eje izquierdo)") label(2 "Depósitos a la vista (eje derecho)") ///
  label(3 "") label(4 "") order(1 3 2 4) size(medium) region(lwidth(none))) ///
  title("Tasa de variación trimestral(%) PIBpc vs Depósitos a la vista ", size(medlarge) color(black)) ///
  subtitle("1994-2015", size(medium) color(black)) ///
  note(Fuente: BCE y SBS, size(small)) ///
  graphregion(fcolor(white))
