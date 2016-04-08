***************************************************
Author: Jonathan W. Duggins
Last Update: 2016-04-02

Notes: Create phosphorus data for Examples 8.6
       in ST 512 Lecture Notes
**************************************************;

*Set options;
options formdlim = "~" nodate pageno = 1;

*read in data;
data phosph;
   input phos time $ tech;
   cards;
   42 AM 1
   44 AM 1
   43 AM 1
   44 AM 1
   43 AM 2
   44 AM 2
   45 AM 2
   42 AM 2
   47 AM 3
   46 AM 3
   47 AM 3
   43 AM 3
   50 PM 1
   49 PM 1
   52 PM 1
   50 PM 1
   49 PM 2
   48 PM 2
   49 PM 2
   47 PM 2
   47 PM 3
   51 PM 3
   46 PM 3
   48 PM 3
   ;
run;

ods pdf file = "C:\temp_sas\Output.pdf" startpage = never;
*analyze data and find estimates;
proc glm data = phosph plots = none;
   class time tech;
   *use parentheses to indicate the nested factor;
   model phos = time tech(time) / clparm;
   * lsmeans time tech(time) / adjust = tukey cl;
   /*
   *request the contrast for TIME - notice the DIVISOR option!;
   estimate 'Time' intercept 0 time 3 -3 tech(time) 1 1 1  -1 -1 -1 / divisor = 3;
   *request the contrasts for TECH(TIME) - notice no AM vs PM contrasts here;
   */

   *these are just like our simple effect contrasts from two-way ANOVA!;
   * as these are simple effects no need to follow the rule of contrats i.e. sum of co-effcients will be 1.0, so no divisors;
   estimate 'Tech 1 vs. 2 within Time=AM' intercept 0 time 0 0 tech(time) 1 -1  0  0  0  0 ;
   estimate 'Tech 1 vs. 3 within Time=AM' intercept 0 time 0 0 tech(time) 1  0 -1  0  0  0 ;
   estimate 'Tech 2 vs. 3 within Time=AM' intercept 0 time 0 0 tech(time) 0  1 -1  0  0  0 ;
   estimate 'Tech 1 vs. 2 within Time=PM' intercept 0 time 0 0 tech(time) 0  0  0  1 -1  0 ;
   estimate 'Tech 1 vs. 3 within Time=PM' intercept 0 time 0 0 tech(time) 0  0  0  1  0 -1 ;
   estimate 'Tech 2 vs. 3 within Time=PM' intercept 0 time 0 0 tech(time) 0  0  0  0  1 -1 ;
   
run;
quit;

ods pdf close;
/**/
/*proc glm data = phosph plots = none;*/
/*   class time tech;*/
/*   model phos = time|tech;*/
/*run;*/
/*quit;*/
