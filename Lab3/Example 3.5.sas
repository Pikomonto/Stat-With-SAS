/**************************************************
Author: Jonathan W. Duggins
Last Update: 2016-01-25

Notes: Obtain two-way analysis for Example 3.5 from
       ST 512 Lecture Notes.
***************************************************/

options pageno=1 nodate formdlim="~";
ods graphics on;

data bp;
   input drug $ sev $ temp;
   *Create a single factor TREAT for the one-way analysis;
   treat = compress(drug||sev);
   cards;
   A L 97.8
   A L 97.2
   A L 97.6
   A L 97.2
   A L 97.6
   B L 98.1
   B L 98.1
   B L 98.0
   B L 97.7
   B L 97.7
   A H 97.5
   A H 97.9
   A H 97.6
   A H 97.6
   A H 97.7
   B H 97.6
   B H 97.7
   B H 97.9
   B H 97.9
   B H 97.8
   ;
run;


*STARTPAGE = never prevents SAS from inserting any page breaks except when necessary.;
ods pdf file = "E:\SCHOOL\TEACHING\NCSU COURSES\ST 512\SAS Code\Example 3.5 Output.pdf" startpage=never;

*We can now use the two way model!;
*Now that we're doing this the better way, we'll go ahead and check assumptions too!;
proc glm data = bp plots = all;
   class drug sev;
   model temp = drug sev drug*sev;
   lsmeans drug;
run;

quit;

ods pdf close;


/*******************************************************
An alternative to the MODEL statement above is to use a 
SAS shortcut:

   MODEL DRUG|SEV;

The vertical bar tells SAS to include both main effects
and the interaction.

This is very useful when fitting a model with more than
two factors - taking the time to type out all the factors
and their interactions is typically not needed!
********************************************************/
