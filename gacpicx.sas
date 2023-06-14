%macro gacpicx(x=1,y=2,nc=4,tp=0.8);

%*    Graphique des individus;
%*    x : numero axe horizontal;
%*    y : numero axe vertical;
%*   nc : nombre max de caracteres;

data anno;
 set coorindq nobs=nind;
 retain  xsys ysys '2';
%*  style='swissb';
 x= prin&x;
 y= prin&y;
 coul=substr(ident,1,1);
 text=substr(ident,1,&nc);
 size=1;
 select;
 when(coul in('A')) color='magenta';
 when(coul in('B')) color='brown';
 when(coul in('C' 'c')) color='red';
 when(coul in('D')) color='DERO';
 when(coul in('E')) color='cream';
 when(coul in('F' 'o')) color='cyan';
 when(coul in('G')) color='gold';
 when(coul in('H')) color='gray';
 when(coul in('I' 'b')) color='green';
 when(coul in('J')) color='lilac';
 when(coul in('K')) color='lime';
 when(coul in('L')) color='maroon';
 when(coul in('M')) color='olive';
 when(coul in('N')) color='orange';
 when(coul in('O')) color='pink';
 when(coul in('P')) color='purple';
 when(coul in('Q')) color='rose';
 when(coul in('R')) color='salmon';
 when(coul in('S' 'a')) color='blue';
 when(coul in('T')) color='steel';
 when(coul in('U')) color='tan';
 when(coul in('V')) color='violet';
 when(coul in('W')) color='vigb';
 when(coul in('X')) color='black';
 when(coul in('Y')) color='yellow';
 when(coul in('Z')) color='STV';

 when(coul in('0')) do; color='red';text='.';size=&tp;end;
 otherwise do; color='black';text='.'; size=&tp;end;
 end;
 label y = "Axe &y"
       x = "Axe &x";
keep x y text xsys ysys size color;
proc gplot data=anno;
 title;
 axis1  length=14cm; /* attention taille */
 axis2  length=9cm;
 symbol v=none;
 plot y*x / annotate=anno frame  href=0 vref=0
  haxis=axis1 vaxis=axis2 ;

run;
goptions reset=all;
quit;
%mend;