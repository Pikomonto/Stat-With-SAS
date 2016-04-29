***************************************************
Author: Jonathan W. Duggins
Last Update: 2016-04-10

Notes: Create phosphorus data for Example 9.4
       in ST 512 Lecture Notes
**************************************************;

*Set options;
options formdlim = "~" nodate pageno = 1;
ods graphics on;

*read in data;
data bashor;
   infile "S:\Documents\CURRENT COURSES\ST 512\Data Sets\bashor.dat" firstobs = 2;
   input day location y; 
   logy = log(y);
run;

ods pdf file = "S:\Documents\CURRENT COURSES\ST 512\SAS Code\Example 9.4 Output.pdf" startpage = never columns = 1;
ods noproctitle;

*Get diagnostic graphs with original data;
proc mixed data = bashor method = type3 plots = all;
   class day location;
   model y = location;
   random day day*location;
   ods select ResidualPanel;
run;

*Get analysis with transformed data;
*Look at all those graphs!;
proc mixed data = bashor method = type3 plots = all;
   class day location;
   model logy = location / ddfm = satterth cl;
   random day day*location;
   lsmeans location / adjust=tukey cl;
run;

ods pdf close;
