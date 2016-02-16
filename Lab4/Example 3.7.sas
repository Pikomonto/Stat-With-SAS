/**************************************************
Author: Jonathan W. Duggins
Last Update: 2016-01-26

Notes: Obtain two-way analysis for Example 3.7 from
       ST 512 Lecture Notes.
***************************************************/

options pageno=1 nodate formdlim="~";
ods graphics on;

/*Sometimes our data isn't how we want it! If I'm lucky
and each group has the same number of observations (so,
a balanced design!) there's an easy way to get SAS to 
create vertical data

I use a single @ character to tell SAS to "hold" the value
of VARIETY and DENSITY until I'm done with it.

I use a loop to read in 3 YIELD varieties per treatment
combination. The single @ sign here tells SAS to "hold"
the first line of data until I'm done reading in all 3
replciates.

This is handy if you need to copy and paste data from a 
source, e.g. a pdf copy of a textbook...*/
data tomato;
   input variety density @;
      do k = 1 to 3;
         input yield @;
         output;
      end; 
   cards;
   1 10  7.9  9.2 10.5
   2 10  8.1  8.6 10.1
   3 10 15.3 16.1 17.5
   1 20 11.2 12.8 13.3
   2 20 11.5 12.7 13.7
   3 20 16.6 18.5 19.2
   1 30 12.1 12.6 14.0
   2 30 13.7 14.4 15.4
   3 30 18.0 20.8 21.0
   1 40  9.1 10.8 12.5
   2 40 11.3 12.5 14.5
   3 40 17.2 18.4 18.9
   ;
run;


ods pdf file = "E:\SCHOOL\TEACHING\NCSU COURSES\ST 512\SAS Code\Example 3.7 Output.pdf" startpage=never;

*Fit Two-way ANOVA model;
title 'GLM for Yield using Variety and Planting Density';
title2 'Includes Tukey Adjustment for LS Mean Yields';
proc glm data = tomato plots = none ;
   class variety density;
   model yield = variety|density;
   lsmeans variety density / cl adjust = tukey;
run;

quit;

ods pdf close;

title;
