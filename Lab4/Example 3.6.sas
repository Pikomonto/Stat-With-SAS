/**************************************************
Author: Jonathan W. Duggins
Last Update: 2016-01-25

Notes: Obtain two-way analysis for Example 3.6 from
       ST 512 Lecture Notes.

WARNING: Instructor copy of output has manual highlighting 
         IF YOU ARE AN INSTRUCTOR - DO NOT RUN THIS CODE
         UNLESS YOU PLAN TO REPLACE THE HIGHLIGHTING!
***************************************************/

options pageno=1 nodate formdlim="~";
ods graphics on;

data ent;
   input temp sucrose trt energy; 
   cards;
   20 20 1  3.1 
   20 20 1  3.7 
   20 20 1  4.7 
   20 40 2  5.5 
   20 40 2  6.7 
   20 40 2  7.3 
   30 20 3  6.0 
   30 20 3  6.9 
   30 20 3  7.5 
   30 40 4 11.5 
   30 40 4 12.9 
   30 40 4 13.4 
   40 20 5  7.7 
   40 20 5  8.3 
   40 20 5  9.5 
   40 40 6 15.7 
   40 40 6 14.3 
   40 40 6 15.9 
   ;
run;


ods pdf file = "E:\SCHOOL\TEACHING\NCSU COURSES\ST 512\SAS Code\Example 3.6 Output.pdf" startpage=never;

*Fit Two-way ANOVA model;
*Requst only the interaction plot. (What we call the profile plot);
title 'GLM for Energy using Temperature and Sucrose';
title2 'Includes Tukey Adjustment for LS Energy Means';
proc glm data = ent plots(only) = intplot ;
   class temp sucrose;
   *Recall from Ex 3.5 the vertical Bar fits all combinations 
    of TEMP and SUCROSE (main effects and interactions);
   model energy = temp|sucrose;
   lsmeans temp*sucrose / adjust = tukey cl;
   *Exclude the adjusted p-values;
   *(This is just to make the output fit on the pages the way I want for class!);
   ods exclude diff;
run;

quit;

*Insert a manual page break;
ods pdf startpage = now;

*Get tests for certain groups of simple effects together (not discussed in class);
title 'GLM for Energy using Temperature and Sucrose';
title2 'Includes Tests for LS Energy Means Sliced by Sucrose';
title3 'Includes Tests for LS Energy Means Sliced by Temperature';
proc glm data = ent plots = none;
   class temp sucrose;
   model energy = temp|sucrose;
   lsmeans temp*sucrose / cl slice = sucrose;
   lsmeans temp*sucrose / slice = temp;
   *Only SELECT the new information: the sliced LS means;
   ods select slicedANOVA;
run;

quit;

/*Optional for in-class*/
*Insert a manual page break;
/*ods pdf startpage = now;*/
/**/
/**Get tests for certain groups of simple effects together (not discussed in class);*/
/*title 'GLM for Energy using Temperature and Sucrose';*/
/*title2 'Pairwise Contrasts for Temperature Sliced by Sucrose Level';*/
/*proc glm data = ent plots = none;*/
/*   class temp sucrose;*/
/*   *Use a Bonferonni correction on the nine pairwise comparisons;*/
/*   model energy = temp|sucrose / clparm alpha = 0.00556;*/
/*   estimate 'Temp 20 vs 30 at Sucrose 20' intercept 0 */
/*                                          temp 1 -1 0 */
/*                                          sucrose 0 0*/
/*                                          temp*sucrose 1 0 -1 0 0 0 / e;*/
/*   estimate 'Temp 20 vs 40 at Sucrose 20' intercept 0 */
/*                                          temp 1 0 -1 */
/*                                          sucrose 0 0*/
/*                                          temp*sucrose 1 0 0 0 -1 0;*/
/*   estimate 'Temp 30 vs 40 at Sucrose 20' intercept 0 */
/*                                          temp 0 1 -1 */
/*                                          sucrose 0 0*/
/*                                          temp*sucrose 0 0 1 0 -1 0;*/
/*   estimate 'Temp 20 vs 30 at Sucrose 40' intercept 0 */
/*                                          temp 1 -1 0 */
/*                                          sucrose 0 0*/
/*                                          temp*sucrose 0 1 0 -1 0 0;*/
/*   estimate 'Temp 20 vs 40 at Sucrose 40' intercept 0 */
/*                                          temp 1 0 -1 */
/*                                          sucrose 0 0*/
/*                                          temp*sucrose 0 1 0 0 0 -1;*/
/*   estimate 'Temp 30 vs 40 at Sucrose 40' intercept 0 */
/*                                          temp 0 1 -1 */
/*                                          sucrose 0 0*/
/*                                          temp*sucrose 0 0 0 1 0 -1;*/
/*   estimate 'Sucrose 20 vs 40 at Temp 20' intercept 0*/
/*                                          temp 0 0 0*/
/*                                          sucrose 1 -1*/
/*                                          temp*sucrose 1 -1 0 0 0 0;*/
/*   estimate 'Sucrose 20 vs 40 at Temp 30' intercept 0*/
/*                                          temp 0 0 0*/
/*                                          sucrose 1 -1*/
/*                                          temp*sucrose 0 0 1 -1 0 0;*/
/*   estimate 'Sucrose 20 vs 40 at Temp 40' intercept 0*/
/*                                          temp 0 0 0*/
/*                                          sucrose 1 -1*/
/*                                          temp*sucrose 0 0 0 0 1 -1;*/
/*run;*/
/**/
/*quit;*/
/**/

ods pdf close;

title;
