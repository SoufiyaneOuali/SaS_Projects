%macro gacpbx;
data conccomp (keep=k cc);
set compr (keep=prin1--prin&pvar);
array c{*} _numeric_;
do k = 1 to &pvar;
cc=c{k};
output;end;
run;
proc gplot data=conccomp;
footnote;
symbol1 i=box v=star;
plot cc*k=1 / haxis= 0 to &pvar by 1 hminor=0;
run;
quit;
goptions reset=all;
%mend;