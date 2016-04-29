***************************************************
Author: Jonathan W. Duggins
Last Update: 2016-04-10

Notes: Create phosphorus data for Example 9.5
       in ST 512 Lecture Notes
**************************************************;

*read data from file;
options nodate nonumber nodate;

ods pdf file = "S:\Documents\CURRENT COURSES\ST 512\Data Sets\Example 9.5 Output.pdf" startpage = never;

data plantacid;
   infile "S:\Documents\CURRENT COURSES\ST 512\Data Sets\plantacids.dat" firstobs = 2;
   input y plant leaf rep;
run;

*analyze model with ci for the mean;
proc mixed method = type3 cl;
   class plant leaf;
   model y = / ddfm = satterthwaite cl;
   random plant leaf(plant);
run;

ods pdf close;
