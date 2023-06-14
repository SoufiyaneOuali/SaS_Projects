libname TP3 "/folders/myshortcuts/tp1/TP2/TP3"; 
filename voiture "/folders/myshortcuts/tp1/TP2/TP3/voitures.xls"; 
proc import datafile=voiture dbms=xls out=TP3.voiture replace; 
run; 
proc princomp data=TP3.voiture n=4 plots=(all) out=M outstat=C ; 
run; 
proc princomp data=TP3.voiture n=4 plots=(all) out=M outstat=C ; 
run; 
data C; set M; 
array A{*} prin1-prin4;  
disto=uss(of A{*}) ; 
qlt1=prin1*prin1/disto; 
qlt2=prin2*prin2/disto; 
qlt3=prin3*prin3/disto; 
qlt4=prin4*prin4/disto; 
keep prin1-prin4 qlt1-qlt4 IND; 
run ; 
proc print data=C; 
 
var prin1-prin4 qlt1-qlt4; 
t
itle ‘Coordonnees et qualite de representation des individus sur les axes’ ; 
run ; 
proc sgplot data=C ; 
title " Representation des individus axe2 * axe1";  
plot (prin1*prin2)/annotate=C href=0 vref=0 ; 
 
 run; 