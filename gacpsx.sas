%macro gacpsx;

proc gplot data=lambda;
title;
footnote;
symbol1 i=join v=dot;
plot pctvar*k=1 / haxis= 0 to &pvar by 1 hminor=0
                  vaxis= 0 to 1 by 0.2 vminor=1;
run;
quit;
goptions reset=all;
%mend;