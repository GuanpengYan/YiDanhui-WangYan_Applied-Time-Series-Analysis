cd "D:\Git Resposity\YiDanhui-WangYan_Applied-Time-Series-Analysis\Chapter 4\"
*第四章 平稳序列拟合与预测


*4.1 建模步骤

**a.平稳性检验
**b.计算 ACF,PACF
**c.ARIMA模型识别
**d.估计参数
**e.模型检验
**f.模型优化
**g.预测

*4.2 模型识别

**例4-1 P85
clear all
use "A1-7.dta"
tsset year
//Plot ACF
ac number,lags(20)		
graph save 4-1_acf.gph,replace
//Plot PACF
pac number,lags(20)
graph save 4-1_pacf.gph,replace
//Plot ACF and PACF
graph combine 4-1_acf.gph 4-1_pacf.gph,rows(2)
graph save 4-1_acf_pacf.gph,replace

**例4-2 P86
clear all
use "A1-8.dta"
tsset day
//Plot Time-Series			
twoway (tsline overshort)		
graph save 4-2_ts.gph,replace
//ADF test
forval i = 0/2{
    dfuller overshort,noconstant lags(`i')
}
forval i = 0/2{
	dfuller overshort, drift lags(`i')
}
forval i = 0/2{
    dfuller overshort, trend lags(`i')
}
//LB test
wntestq overshort,lags(6)
wntestq overshort,lags(12)
//Plot ACF
ac overshort,lags(15)		
graph save 4-2_acf.gph,replace
//Plot PACF
pac overshort,lags(15)
graph save 4-2_pacf.gph,replace
//Plot ACF and PACF
graph combine 4-2_acf.gph 4-2_pacf.gph,rows(2)
graph save 4-2_acf_pacf.gph

**例4-3 P88
clear all
use "A1-9.dta"
tsset year
//Plot Time-Series
twoway (tsline D.change)
graph save 4-3_ts.gph,replace
//ADF test
forval i = 0/2{
    dfuller D.change,noconstant lags(`i')
	dfuller D.change, lags(`i')
    dfuller D.change, trend lags(`i')
}
//LB test
wntestq D.change,lags(6)
wntestq D.change,lags(12)
//Plot ACF
ac D.change,lags(25)		
graph save 4-3_acf.gph,replace
//Plot PACF
pac D.change,lags(25)
graph save 4-3_pacf.gph,replace
//Plot ACF and PACF
graph combine 4-3_acf.gph 4-3_pacf.gph,rows(2)
graph save 4-3_acf_pacf.gph

*4.3 参数估计

**例4-1续(1) P95
clear all
use "A1-7.dta"
tsset year
//AR(1)
arima number,ar(1) nolog

**例4-2续(1) P95
clear all
use "A1-8.dta"
tsset day
//MA(1)
arima overshort,ma(1) nolog condition

**例4-3续(1) P96
clear all
use "A1-9.dta"
tsset year
//ARMA(1,1)
arima D.change,ar(1) ma(1) nolog condition
*4.4 模型检验

**例4-1续(2) P96
clear all
use "A1-7.dta"
tsset year
//AR(1)
arima number,ar(1) nolog
//LB test
predict e,res
wntestq e,lags(6)
wntestq e,lags(12)
wntestq e,lags(18)


**例4-1续(3) P98
clear all
use "A1-7.dta"
tsset year
//AR(1)
arima number,ar(1) nolog vce(oim)

**例4-2续(2) P98
clear all
use "A1-8.dta"
tsset day
//MA(1)
quietly arima overshort,ma(1) nolog condition
//LB test for e
predict e,res
wntestq e,lags(6)
wntestq e,lags(12)

**例4-3续(2) P98
clear all
use "A1-9.dta"
tsset year
//ARMA(1,1)
arima D.change,ar(1) ma(1) nolog condition 
//LB test for e
predict e,res
wntestq e,lags(6)
wntestq e,lags(12)
wntestq e,lags(18)

*4.5 模型优化

**例4-7 P99
clear all
use "A1-10.dta"
tsset time
//Plot Time-Series
twoway(tsline x)
graph save 4-7_ts.gph,replace
//ADF test
forval i = 0/2{
    dfuller x, lags(`i') noconstant
}
forval i = 0/2{
	dfuller x, drift lags(`i')
}
forval i = 0/2{
    dfuller x, trend lags(`i') 
}
//LB test
wntestq x,lags(6)
wntestq x,lags(12)
//Plot ACF
ac x,lags(20)		
graph save 4-7_acf.gph,replace
//Plot PACF
pac x,lags(20)
graph save 4-7_pacf.gph,replace
//Plot ACF and PACF
graph combine 4-7_acf.gph 4-7_pacf.gph,rows(2)
graph save 4-7_acf_pacf.gph,replace
//MA(2) estimate
arima x,ma(2) condition
predict e1,res
//AR(1) estimate
arima x,ar(1) condition
predict e2,res
//LB test and para test for MA(2)
wntestq e1,lags(6)
wntestq e1,lags(12)
wntestq e1,lags(18)
arima x,ma(2) condition
//LB test and para test for MA(1)
wntestq e2,lags(6)
wntestq e2,lags(12)
arima x,ar(1) condition

**例4-7续 P103
clear all
use "A1-10.dta"
tsset time
//AIC and BIC test
quietly arima x,ma(2) condition 
estat ic
quietly arima x,ar(1) condition
estat ic

*4.6 序列预测
**例4-1续(4) P108
clear all
use "A1-7.dta"
tsset year
//AR(1)
quietly arima number,ar(1) nolog
tsappend,add(10)
predict y,y
predict mse,mse  // Stata Manual P105
gen std=sqrt(mse)
gen lb=y-1.96*std
gen ub=y+1.96*std
list year y std lb ub if year>1998


