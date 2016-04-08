***************************************************
Author: Jonathan W. Duggins
Last Update: 2016-03-29

Notes: Create sire data for all Unit 7 examples
       in ST 512 Lecture Notes
**************************************************;

*Set options;
options formdlim = "~" nodate pageno = 1;

*read in data;
data Sires;
   input Sire @;
   do calf = 1 to 8;
      input weight @; 
      output;
   end;
   cards;
   177 61 100 56 113 99 103 75 62
   200 75 102 95 103 98 115 98 94
   201 58 60 60 57 57 59 54 100
   202 57 56 67 59 58 121 101 101
   203 59 46 120 115 115 93 105 75
   ;
run;

ods pdf file = "S:\Documents\CURRENT COURSES\ST 512\SAS Code\Example 7.x Output.pdf" startpage = never;

options orientation = landscape;
*Plot data using dots with height = 2;
symbol v = dot h = 2;
proc gplot data = sires;
   plot weight*sire;
run;
quit;
options orientation = portrait;

ods pdf startpage = now columns = 2;

*run incorrect glm analysis;
title 'RE Model with GLM';
title2 'NOT THE CORRECT APPROACH IN GENERAL!';
proc glm data = sires;
   class sire;
   model weight = sire;
   random sire;
run;
quit;

ods pdf startpage = now columns = 1;

*run correct mixed analysis using type3 estimation (equating sums of squares);
title 'Type 3 Analysis with MIXED';
title2 'CORRECT TYPE 3 APPROACH!';
proc mixed data = sires method = type3 cl;
   class sire;
   model weight =;
   random sire;
   estimate 'Mean Birth Weight' intercept 1 / cl;
run;

ods pdf startpage = now;

*repeat using reml;
title 'Restricted Maximum Likelihood with MIXED';
title2 'More modern and widely accepted approach';
proc mixed data = sires method = reml cl;
   class sire;
   model weight = ;
   random sire;
   estimate 'Mean Birth Weight' intercept 1 / cl;
run;

title;
ods pdf close;
