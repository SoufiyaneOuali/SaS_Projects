%macro gacpix(x=1,y=2,nc=4,coeff=1);

%*    Graphique des individus;
%*    x : numero axe horizontal;
%*    y : numero axe vertical;
%*   nc : nombre max de caracteres;


 data anno;
 set coorindq nobs=nind;
 retain  xsys ysys '2';
%* style='swiss';
 y= prin&y;
 x= prin&x;
 text=substr(left(ident),1,&nc);
 size=&coeff*(cosca&x+cosca&y)+0.2;
 label y = "Axe &y"
       x = "Axe &x";
run;

proc gplot data=anno;
 title;
  symbol1 v='none';
 plot y*x=1 / annotate=anno frame  href=0 vref=0;
run;
goptions reset=all;
quit;
%mend;