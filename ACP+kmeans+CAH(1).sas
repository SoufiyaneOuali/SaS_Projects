%LET var = nbpers_au_foyer catholique protestant autre_religion
sans_religion marie concubin autre_relation celibataire
sans_enfant avec_enfant niv_etude_haut niv_etud_moy niv_etud_bas
PCStop PCScadre PCSagri PCSinter PCSouvr_quali PCSouvr locataire
proprietaire auto1 auto2 auto0 revenu1 revenu2 revenu3 revenu4
revenu5 ;

ODS OUTPUT Eigenvalues = valprop ;
PROC PRINCOMP DATA = bdsas.assurance  n=2  OUT=individus OUTSTAT=stat ;
VAR &var;
RUN ;


/*PROC STANDARD DATA= individus OUT=reduit MEAN=0 STD=1;
VAR &var;
RUN;*/

PROC FASTCLUS DATA=individus MAXC=20 MAXITER=50 CONVERGE=0.02
MEAN=centres OUT=partitio outstat=essai CLUSTER=numclus  DELETE=5 DRIFT;
VAR &var;
RUN;

PROC PRINT DATA=centres (obs=20); RUN;

PROC PRINT DATA=partitio (obs=10); RUN;

PROC FREQ DATA=partitio ORDER=freq;
TABLE numclus;
RUN;

PROC FREQ DATA=centres;
TABLE _freq_;
RUN;

GOPTIONS RESET=all;
/*GOPTIONS COLORS=(green);*/
/*goptions csymbol=red;*/
PROC GPLOT DATA=partitio;
PLOT prin2*prin1=numclus;
RUN;
QUIT;

/*classification Ascendante hierarchique */

PROC CLUSTER DATA=centres OUTTREE=tree METHOD=ward CCC PSEUDO PRINT=10;
VAR &var;
COPY numclus;
RUN;

PROC PRINT DATA=tree;
RUN;

PROC SORT DATA=tree;
BY _ncl_;
RUN;

SYMBOL1 color=black INTERPOL=join VALUE=dot HEIGHT=1 ;
PROC GPLOT DATA=tree ;
WHERE _ncl_ < 20 ;
PLOT (_rsq_ _sprsq_ _ccc_ _rmsstd_ _psf_ _pst2_) * _ncl_ ;
RUN ;
GOPTIONS RESET=all ;
QUIT ;

PROC TREE DATA=tree NCL=4 OUT=segmhier ;
COPY numclus ;
RUN ;
PROC PRINT DATA=segmhier ;
RUN ;

PROC SORT DATA=partitio; BY numclus; RUN;
PROC SORT DATA=segmhier; BY numclus; RUN;
DATA bdsas.segm;
MERGE partitio segmhier;
BY numclus;
RUN;

PROC FREQ ORDER=freq; TABLE cluster; RUN;
/*   fin du processus */
GOPTIONS RESET=all;
GOPTIONS COLORS=(black);
PROC GPLOT;
PLOT prin2*prin1=cluster;
RUN; QUIT;

