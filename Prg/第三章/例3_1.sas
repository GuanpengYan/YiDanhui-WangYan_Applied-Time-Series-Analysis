goptions vsize=6.8cm hsize=10cm;
data a;
x1_1=0;
x2_1=0;
x3_1=0;
x3_2=0;
x4_1=0;
x4_2=0;
do t=-100 to 100;
e=rannor(12345);
x1=0.8*x1_1+e;
x2=-1.1*x2_1+e;
x3=x3_1-0.5*x3_2+e;
x4=x4_1+0.5*x4_2+e;
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
proc gplot data=a;
plot x1*t=1;
plot x2*t=1;
plot x3*t=1;
plot x4*t=1;
symbol1 c=red i=join v=none;
run;

