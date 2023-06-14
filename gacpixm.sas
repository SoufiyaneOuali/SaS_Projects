%macro gacpixm(x=1,y=2,coeff=1);

%* Graphique des individus apres classification;
%*    x : numero axe horizontal;
%*    y : numero axe vertical;

data anno;
 retain  xsys ysys '2';
 set coorindq nobs=nind;
%* style='swiss';
 x= prin&x;
 y= prin&y;
 text=substr(ident,1);
 size=coeff*(1.6-max(0,nind/100)+(cosca&x+cosca&y)/1.8);
 label y = "Axe &y"
       x = "Axe &x";
run;

proc gplot data=anno;
 axis1 length=13.6cm;
 axis2 length=7.7cm;
 title;
 symbol1 v='none';
 plot y*x=1 / annotate=anno frame  href=0 vref=0;
run;

goptions reset=all;
quit;

%mend;