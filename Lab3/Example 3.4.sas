/**************************************************
Author: Jonathan W. Duggins
Last Update: 2016-01-19

Notes: Obtain contrast SS for theta_med, theta_sev,
       and theta_med*sev.
***************************************************/

options pageno=1 nodate formdlim="~";

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


*Introducing the RTF command that allows you to create Rich Text Format documents,
which are readable in programs like Microsoft Word;
*STARTPAGE = never prevents SAS from inserting any page breaks except when necessary.;
ods rtf file = "E:\SCHOOL\TEACHING\NCSU COURSES\ST 512\SAS Code\Example 3.4 Output.rtf" startpage=never;
ods pdf file = "E:\SCHOOL\TEACHING\NCSU COURSES\ST 512\SAS Code\Example 3.4 Output.pdf" startpage=never;

*Recall the CONTRAST statement has the same basic syntax as the ESTIMATE statement;
proc glm data = bp plots = none;
   class treat;
   model temp = treat;
   *-------------------------------------------------AH----AL----BH----BL--;
   contrast 'Medication'          intercept 0 treat 0.50  0.50 -0.50 -0.50;
   contrast 'Severity'            intercept 0 treat 0.50 -0.50  0.50 -0.50;
   contrast 'Medication*Severity' intercept 0 treat 0.50 -0.50 -0.50  0.50;
run;

quit;

ods pdf close;
ods rtf close;
