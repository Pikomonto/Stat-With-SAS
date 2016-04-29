***************************************************
Author: Jonathan W. Duggins
Last Update: 2016-04-08

Notes: Create phosphorus data for Example 9.3
       in ST 512 Lecture Notes
**************************************************;

*Set options;
options formdlim = "~" nodate pageno = 1 orientation = portrait;
title;
footnote;

*read in data from an external file;
*File name is Milk.dat;
*File location is wherever you saved your data!;
*First line in the file is variable names, so start reading data on line 2;
data milkexp;
   infile "S:\Documents\CURRENT COURSES\ST 512\Data Sets\milk.dat" firstobs=2;
   input sample lab y;
   *data is NOT normal, so use transformed data;
   logy=log(y);
run;

ods pdf file = "S:\Documents\CURRENT COURSES\ST 512\SAS Code\Example 9.3 Output.pdf" startpage = never columns = 2;
ods noproctitle;

*INCORRECT analysis in GLM;
title 'Incorrect GLM Analysis';
proc glm;
   class lab sample;
   model logy = sample|lab;
   random sample lab sample*lab;
run;
quit;

ods pdf startpage = now;

*Better analysis in GLM;
title 'Correct GLM Analysis';
proc glm;
   class lab sample;
   model logy = sample|lab / clparm;
   random sample|lab;
   *In addition to the typical code we have to tell SAS:
     what we want to test, i.e. numerators of our F tests (this is the H=)
     what we want to use as our error term, i.e. denominators of our F tests (this is the E=);
   test h = sample lab e = sample*lab;
   *The next line could be used to get a CI, but it has the wrong SE;
   *estimate 'mean' intercept 1;
run;
quit;

ods pdf columns = 1 startpage = now;
*PROC MIXED is superior - even when using Method of Moments;
title 'Method of Moments with PROC MIXED';
title2 'Ignoring DF adjustment for fixed effects';
proc mixed method = type3 cl;
   class lab sample;
   model logy = / cl;
   random sample|lab;
run;

ods pdf startpage = now;

*Get correct CI for mean;
title 'Method of Moments with PROC MIXED';
title2 'Include Satterthwaite adjustment for fixed effects';
proc mixed method = type3 cl;
   class sample lab;
   *Need to request Satterthwaite DF for our fixed effect;
   model logy = / ddfm=satterth cl;
   random sample|lab;
run;

ods pdf startpage = now columns = 2;

*Switch to REML instead of MOM;
title 'REML with PROC MIXED';
proc mixed method = reml cl;
   class sample lab;
   *Need to request Satterthwaite DF for our fixed effect;
   model logy = / ddfm=satterth cl;
   random sample|lab;
run;

ods pdf close;
