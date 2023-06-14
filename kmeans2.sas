data t2;
	input cid $ 1-2 income educ;
cards;
c1 5 5
c2 6 6
c3 15 14
c4 16 15
c5 25 20
c6 30 19
run;

PROC FASTCLUS MAXC=20 MAXITER=50 CONVERGE=0.02
MEAN=centres OUT=partitio CLUSTER=presegm DELETE=5 DRIFT;
VAR income educ;
RUN;
