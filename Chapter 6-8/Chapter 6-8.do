cd "D:\Git Resposity\YiDanhui-WangYan_Applied-Time-Series-Analysis\Chapter 6-8\"

*第六章 有季节效应的非平稳序列分析

*6.1 因素分解理论

*6.2 因素分解模型

*6.3 指数平滑预测模型

*6.4 ARIMA加法模型

**例6-6 P182-185
clear all
use "A1-20.dta"
tsset time
//Plot Time-Series			
twoway (tsline x)
twoway (tsline DS4.x)
graph save 6-6_ts.gph, replace
//ADF test
forval i = 0/2{
    dfuller DS4.x, lags(`i') noconstant
}
forval i = 0/2{
	dfuller DS4.x, drift lags(`i')
}
forval i = 0/2{
    dfuller DS4.x, trend lags(`i') 
}
//LB test
wntestq DS4.x,lags(6)
wntestq DS4.x,lags(12)
wntestq DS4.x,lags(18)
//Plot ACF
ac DS4.x,lags(15)		
graph save 6-6_acf.gph,replace
//Plot PACF
pac DS4.x,lags(15)
graph save 6-6_pacf.gph,replace
//Plot ACF and PACF
graph combine 6-6_acf.gph 6-6_pacf.gph,rows(2)
graph save 6-6_acf_pacf.gph,replace
//Estimate arima((1,4),(1,4),0)
arima DS4.x, ar(1 4) condition vce(oim)
predict e,res
predict y,y
//LB test
wntestq e,lags(6)
wntestq e,lags(12)
//Plot path
twoway scatter x time,color(red) msymbol(X)||tsline y,color(blue) legend(off)
graph save 6-6_path.gph,replace

**例6-7 P186-189\
clear all
use "A1-21.dta"
tsset time
//Plot Time-Series			
twoway (tsline x)
twoway (tsline DS12.x)
graph save 6-7_ts.gph,replace
//Plot ACF
ac DS12.x,lags(25)		
graph save 6-7_acf.gph,replace
//Plot PACF
pac DS12.x,lags(25)
graph save 6-7_pacf.gph,replace
//Plot ACF and PACF
graph combine 6-7_acf.gph 6-7_pacf.gph,rows(2)
graph save 6-7_acf_pacf.gph,replace
//Estimate arima(1,1,1)×(0,1,1)12
arima x,arima(1,1,1) sarima(0,1,1,12) vce(oim) nolog
predict e,res
predict y,y
//LB test
wntestq e,lags(6)
wntestq e,lags(12)
wntestq e,lags(18)
//Plot path
twoway scatter x time,color(red) msymbol(X)||tsline y,color(blue) legend(off)
graph save 6-7_path.gph,replace

*第七章 条件异方差模型

*7.1 异方差问题

*7.2 异方差的直观诊断

*7.3 方差齐性变换

*7.4 ARCH模型

**例7-2 P210
clear all
use "A1-23.dta"
tsset day
//Plot Time-Series			
twoway (tsline close)
twoway (tsline D.close)
graph save 7-2_ts.gph,replace
//estimate arch(4)
arch D.close, arch(1/4) nolog

**例7-2续(1) P213
clear all
use "A1-23.dta"
tsset day
//estimate arch(4)
quietly arch D.close, arch(1/4) nolog
predict y,xb
predict variance,variance  // Stata Manual P48
gen std = sqrt(variance)
gen lb = y-1.96*std
gen ub = y+1.96*std
twoway rarea lb ub day,bcolor (gs14) lp(dash)||tsline D.close,color(blue) legend(off)

local opt ",lc(black)"
twoway tsline lb ,color(red)||tsline ub,color(red) yline(-100 100,lp(dash))||tsline D.close,color(green) legend(off)


**例7-2续(2) P218
clear all
use "A1-23.dta"
tsset day
//PP test
forval i = 0/2{
    pperron D.close, lags(`i') noconstant
}
forval i = 0/2{
	pperron D.close, lags(`i')
}
forval i = 0/2{
    pperron D.close, trend lags(`i') 
}
//LB test
wntestq D.close,lags(6)
wntestq D.close,lags(12)
wntestq D.close,lags(18)
wntestq D.close,lags(24)
//autocorrelation coefficient
corrgram D.close,lags(30)

**例7-2续(3) P220
clear all
use "A1-23.dta"
tsset day
//estimate arch(4)
arch D.close, arch(1/4) nolog
predict e,res
quietly regress e
//ARCH test
forval i = 1/12{
  estat archlm,lag(`i')
}

**例7-2续(4) P222
clear all
use "A1-23.dta"
tsset day
//estimate arch(4)
arch D.close, arch(1/4) nolog

**例7-2续(5) P223
clear all
use "A1-23.dta"
tsset day
//estimate arch(4)
arch D.close, arch(1/4) nolog
estat ic
//estimate garch(1,1)
arch D.close, arch(1) garch(1) condition nolog
estat ic
predict e,res
//QQ graph
qnorm e
graph save 7-2_qq.gph,replace
*第八章 多元时间序列分析

*8.1 ARIMAX模型

*8.2 干预分析

*8.3 伪回归

*8.4 协整

**例8-3 P260
clear all
use "A1-27.dta"
tsset year
twoway tsline lnx||tsline lny,lp(dash) legend(off)
//EG test
forval i = 0/2{
  egranger lny lnx,lags(`i')
}
forval i = 0/2{
  egranger lny lnx,lags(`i') trend
}
//estimate OLS
regress lny lnx, noconstant
predict e, res
//LB test
wntestq e,lag(6)
//Plot ACF of residual
ac e,lags(6)
graph save 8-1_res_acf.gph,replace
//Plot PACF of residual
pac e,lags(6)
graph save 8-1_res_pacf.gph,replace
//Plot ACF and PACF of residual
graph combine 8-1_res_acf.gph 8-1_res_pacf.gph,rows(2)
graph save 8-1_res_acf_pacf.gph,replace
//add ar(1)
arima lny lnx,ar(1) condition noconstant nolog

**例8-3续(2) P266
clear all
use "A1-27.dta"
tsset year
//ECM model
gen ECM = lny - 0.9683*lnx
regress D.lny D.lnx L.ECM ,noconstant

*8.5 格兰杰因果检验