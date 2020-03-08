clear all
use "D:\Stata Dataset\example4_1.dta"
tsset time
//LB test
sum x
wntestq x,lags(6)
//Calculate AC,PAC,Q and Prob>Q
corrgram x,lags(6)
//Plot line				
twoway (tsline x)		
graph save p1.gph,replace
//Plot ACF
ac x,lags(20)		
graph save p2.gph,replace
//Plot PACF
pac x,lags(20)			
graph save p3.gph,replace
//Plot all
graph combine p1.gph p2.gph p3.gph
