data a;
x1_1=0;
x2_1=0;
x3_1=0;
x3_2=0;
x4_1=0;
x4_2=0;
do t=-100 to 1000;
e=rannor(12345);
x1=0.8*x1_1+e;
x2=-0.8*x2_1+e;
x3=x3_1-0.5*x3_2+e;
x4=-x4_1-0.5*x4_2+e;
x1_1=x1;
x2_1=x2;
x3_2=x3_1;
x4_2=x4_1;
x3_1=x3;
x4_1=x4;
if t>0 then output ;
end;
data a;
set a;
keep t x1 x2 x3 x4;
run;
proc arima data=a;
identify var=x1 nlag=20 outcov=out1;
identify var=x2 nlag=20 outcov=out2;
identify var=x3 nlag=20 outcov=out3;
identify var=x4 nlag=20 outcov=out4;
run;
symbol c=red i=needle v=none;
proc gplot data=out1;
plot corr*lag ;
proc gplot data=out2;
plot corr*lag ;
proc gplot data=out3;
plot corr*lag ;
proc gplot data=out4;
plot corr*lag ;
proc gplot data=out1;
plot partcorr*lag ;
proc gplot data=out2;
plot partcorr*lag ;
proc gplot data=out3;
plot partcorr*lag ;
proc gplot data=out4;
plot partcorr*lag ;
run;


