%macro gacpvx(x=1,y=2,nc=4,coeff=2);

%*    Graphique des variables avec cercle des correlations;
%*    x : numero axe horizontal;
%*    y : numero axe vertical;
%*   nc : nombre max de caracteres;
 data anno;
 retain  xsys ysys '2';
 set covarfac nobs=p;
 y= v&y;
 x= v&x;
%* style='swiss';
 text=substr(_name_,1,&nc);
 size=&coeff*sqrt(x*x+y*y);
 label y = "Axe &y"
       x = "Axe &x";
 output;
    function='pie';
    x=0;text='';
    y=0;style='E';
    hsys='8';size=1;
    rotate=360;output;
run;
proc gplot data=anno;
 symbol1 v='none' i=join;
 title;
 axis1 order = (-1 to 1 by 0.5) length=10CM; /* attention taille */
 plot y*x=1/ annotate=anno haxis=axis1 vaxis=axis1;
run;
goptions reset=all;
quit;
%mend;