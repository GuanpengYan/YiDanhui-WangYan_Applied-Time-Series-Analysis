goptions vsize=6.8cm hsize=10cm;
data a;
input time	x;
cards;
1 	47 
2 	64 
3 	23 
4 	71 
5 	38 
6 	64 
7 	55 
8 	41 
9 	59 
10 	48 
11 	71 
12 	35 
13 	57 
14 	40 
15 	58 
16 	44 
17 	80 
18 	55 
19 	37 
20 	74 
21 	51 
22 	57 
23 	50 
24 	60 
25 	45 
26 	57 
27 	50 
28 	45 
29 	25 
30 	59 
31 	50 
32 	71 
33 	56 
34 	74 
35 	50 
36 	58 
37 	45 
38 	54 
39 	36 
40 	54 
41 	48 
42 	55 
43 	45 
44 	57 
45 	50 
46 	62 
47 	44 
48 	64 
49 	43 
50 	52 
51 	38 
52 	59 
53 	55 
54 	41 
55 	53 
56 	49 
57 	34 
58 	35 
59 	54 
60 	45 
61 	68 
62 	38 
63 	50 
64 	60 
65 	39 
66 	59 
67 	40 
68 	57 
69 	54 
70 	23 
;
proc gplot;
plot x*time=1;
symbol1 c=red v=star i=join;
proc arima data=a;
identify var=x stationarity=(Adf=2) ;
estimate q=2;
estimate p=1;
run;
