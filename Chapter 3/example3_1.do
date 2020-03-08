clear all
use "D:\Stata Dataset\example3_1.dta"
tsset t
//LB test
sum x
wntestq x,lags(6)
wntestq x,lags(12)
wntestq x,lags(18)
//Calculate AC,PAC,Q and Prob>Q
corrgram x,lags(20)
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

sum y
wntestq y,lags(6)
wntestq y,lags(12)
wntestq y,lags(18)
corrgram y,lags(20)					
twoway (tsline y)
graph save p1.gph,replace
ac y,lags(20)
graph save p2.gph,replace
pac y,lags(20)
graph save p3.gph,replace
graph combine p1.gph p2.gph p3.gph

sum z
wntestq z,lags(6)
wntestq z,lags(12)
wntestq z,lags(18)
corrgram z,lags(20)					
twoway (tsline z)
graph save p1.gph,replace
ac z,lags(20)
graph save p2.gph,replace
pac z,lags(20)
graph save p3.gph,replace
graph combine p1.gph p2.gph p3.gph


