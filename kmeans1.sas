%LET var = nbpers_au_foyer catholique protestant autre_religion
sans_religion marie concubin autre_relation celibataire
sans_enfant avec_enfant niv_etude_haut niv_etud_moy niv_etud_bas
PCStop PCScadre PCSagri PCSinter PCSouvr_quali PCSouvr locataire
proprietaire auto1 auto2 auto0 revenu1 revenu2 revenu3 revenu4
revenu5 ;


/* FORMAT SAS UTILISES */

PROC FORMAT ;
VALUE age
1     = ' < 30 ans'
2     = '30-40 ans'
3     = '40-50 ans'
4     = '50-60 ans'
5     = '60-70 ans'
6     = ' > 70 ans' ;
VALUE autrevar
0 = '     0 %'
1 = '1 - 10 %'
2 = '11 - 23%'
3 = '24 - 36%'
4 = '37 - 49%'
5 = '50 - 62%'
6 = '63 - 75%'
7 = '76 - 88%'
8 = '89 - 99%'
9 = '    100%' ;
RUN ;
libname bdsas "C:\SASTP";
data test;
set bdsas.assurancetic;
/* CREATION DE VARIABLES D'AGE */

DATA test ;
SET test ;
agemoins30 = (age_moyen = 1) * 9 ;
age30a40 = (age_moyen = 2) * 9 ;
age40a50 = (age_moyen = 3) * 9 ;
age50a60 = (age_moyen = 4) * 9 ;
age60a70 = (age_moyen = 5) * 9 ;
ageplus70 = (age_moyen > 5) * 9 ;
RUN ;




ODS OUTPUT Eigenvalues = valprop ;
PROC PRINCOMP DATA = test n=2 OUT=individus OUTSTAT=stat ;
VAR &var;
RUN ;


/*PROC STANDARD DATA= individus OUT=reduit MEAN=0 STD=1;
VAR &var;
RUN;*/

PROC FASTCLUS DATA=individus MAXC=20 MAXITER=50 CONVERGE=0.02
MEAN=centres OUT=partitio CLUSTER=presegm DELETE=5 DRIFT;
VAR &var;
RUN;

PROC PRINT DATA=centres (obs=20); RUN;

PROC PRINT DATA=partitio (obs=10); RUN;

PROC FREQ DATA=partitio ORDER=freq;
TABLE presegm;
RUN;

PROC FREQ DATA=centres;
TABLE _freq_;
RUN;

GOPTIONS RESET=all;
/*GOPTIONS COLORS=(green);*/
/*goptions csymbol=red;*/
PROC GPLOT DATA=partitio;
PLOT prin2*prin1=presegm;
RUN;
QUIT;



