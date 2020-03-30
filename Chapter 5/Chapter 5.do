cd "D:\Git Resposity\YiDanhui-WangYan_Applied-Time-Series-Analysis\Chapter 5\"
*第五章 无季节效应的非平稳序列分析

*5.1 Cramer分解定理

*5.2 差分平稳

**例5-1 P128
clear all
use "A1-11.dta"
tsset year
//Plot Time-Series			
twoway (tsline sha)
twoway (tsline D.sha)
graph save 5-1_ts.gph,replace

**例5-2 P129
clear all
use "A1-12.dta"
tsset year
//Plot Time-Series			
twoway (tsline x)
twoway (tsline D.x)
twoway (tsline D2.x)
graph save 5-2_ts.gph,replace

**例5-3 P130
clear all
use "A1-13.dta"
tsset time
//Plot Time-Series	
twoway (tsline milk)
twoway (tsline D.milk)
gen D12D1milk = D1.milk - L12.D1.milk
twoway (tsline D12D1milk)
graph save 5-3_ts.gph,replace

*5.3 ARIMA模型

**例5-6 P136
clear all
use "A1-14.dta"
tsset year
//Plot Time-Series	
twoway (tsline gnp)
twoway (tsline D.gnp)
//ADF test
forval i = 0/2{
    dfuller D.gnp, lags(`i') noconstant
}
forval i = 0/2{
	dfuller D.gnp, drift lags(`i')
}
forval i = 0/2{
    dfuller D.gnp, trend lags(`i') 
}
//LB test
wntestq D.gnp,lags(6)
wntestq D.gnp,lags(12)
wntestq D.gnp,lags(18)
//Plot ACF
ac D.gnp,lags(20)		
graph save 5-6_acf.gph,replace
//Plot PACF
pac D.gnp,lags(20)
graph save 5-6_pacf.gph,replace
//Plot ACF and PACF
graph combine 5-6_acf.gph 5-6_pacf.gph,rows(2)
graph save 5-6_acf_pacf.gph,replace
//ARIMA(1,1,0) estimate
arima D.gnp,arima(1,0,0) condition vce(oim)
arima gnp,arima(1,1,0) condition vce(oim)
predict e,res
//LB test and para test for MA(2)
wntestq e,lags(6)
wntestq e,lags(12)
wntestq e,lags(18)

**例5-6续 P141
clear all
use "A1-14.dta"
tsset year
//AR(1)
quietly arima gnp,arima(1,1,0) condition
tsappend,add(10)
predict y,dynamic(1971) y
predict mse, mse  // Stata Manual P105
gen std=sqrt(mse)
gen lb=y-1.96*std
gen ub=y+1.96*std
list year y std lb ub if year>1970
twoway rarea lb ub year,bcolor (gs14) lp(dash)||scatter gnp year,color(red) msymbol(X)||tsline y,color(blue)

*5.4 疏系数矩阵

**例5-8 P142
clear all
use "A1-15.dta"
tsset year
//Plot Time-Series	
twoway (tsline fertility)
twoway (tsline D.fertility)
//ADF test
forval i = 0/2{
    dfuller D.fertility, lags(`i') noconstant
}
forval i = 0/2{
	dfuller D.fertility, drift lags(`i')
}
forval i = 0/2{
    dfuller D.fertility, trend lags(`i') 
}
//LB test
wntestq D.fertility,lags(6)
wntestq D.fertility,lags(12)
wntestq D.fertility,lags(18)
//Plot ACF
ac D.fertility,lags(15)		
graph save 5-8_acf.gph,replace
//Plot PACF
pac D.fertility,lags(15)
graph save 5-8_pacf.gph,replace
//Plot ACF and PACF
graph combine 5-8_acf.gph 5-8_pacf.gph,rows(2)
graph save 5-8_acf_pacf.gph,replace
//ARIMA((1,4),1,0) estimate
arima D.fertility,ar(1 4) condition vce(oim)

predict e,res
//LB test and para test for MA(2)
wntestq e,lags(6)
wntestq e,lags(12)