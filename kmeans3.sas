data cities;
input city $ work price salary;
cards;
Amsterdam	1714	65.6	49.0
Athens	1792	53.8	30.4
Bogota	2152	37.9	11.5
Bombay	2052	30.3	5.3
Brussels	1708	73.8	50.5
Buenos_Aires	1971	56.1	12.5
Caracas	2041	61.0	10.9
Chicago	1924	73.9	61.9
Copenhagen	1717	91.3	62.9
Dublin	1759	76.0	41.4
Dusseldorf	1693	78.5	60.2
Frankfurt	1650	74.5	60.4
Geneva	1880	95.9	90.3
Helsinki	1667	113.6	66.6
Hong_Kong	2375	63.8	27.8
Houston	1978	71.9	46.3
Johannesburg	1945	51.1	24.0
Kuala_Lumpur	2167	43.5	9.9
Lagos	1786	45.2	2.7
Lisbon	1742	56.2	18.8
London	1737	84.2	46.2
Los_Angeles	2068	79.8	65.2
Luxembourg	1768	71.1	71.1
Madrid	1710	93.8	50.0
Manila	2268	40.0	4.0
Mexico_City	1944	49.8	5.7
Milan	1773	82.0	53.3
Montreal	1827	72.7	56.3
Nairobi	1958	45.0	5.8
New_York	1942	83.3	65.8
Nicosia	1825	47.9	28.3
Oslo	1583	115.5	63.7
Panama	2078	49.2	13.8
Paris	1744	81.6	45.9
Rio_de_Janeiro	1749	46.3	10.5
Sao_Paulo	1856	48.9	11.1
Seoul	1842	58.3	32.7
Singpore	2042	64.4	16.1
Stockholm	1805	111.3	39.2
Sydney	1668	70.8	52.1
Taipei	2145	84.3	34.5
Tel_Aviv	2015	67.3	27.0
Tokyo	1880	115.0	68.0
Toronto	1888	70.2	58.2
Vienna	1780	78.0	51.3
Zurich	1868	100.0	100.0
;
run;

proc princomp data=cities  out=individus outstat=stat;
var work price salary; 
run;
proc fastclus data=individus   maxc=5 maxiter=100 out=clus converge=0.001 Mean=centres cluster=num delete=3 DRIFT ;
var work price salary; 
run; 
proc sort data=clus;
by num;
run;

proc print data=clus;
var city num;
run;

Proc freq data=clus order=freq ;
table num;
run;
goptions reset=all;
goptions colors=(red);
proc gplot data=clus;
plot prin2*prin1=num;
run;
quit;

