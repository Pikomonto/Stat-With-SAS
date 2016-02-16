/**************************************************
Author: Jonathan W. Duggins
Last Update: 2016-01-20

Notes: Create CORN data set for Lab 3
***************************************************/

options nodate pageno=1 formdlim="~";

/*
   create a single factor 'treatVar' for the one-way analysis;


*/
data cornData;
   input yield variety Density $ Time $;
   treatVar = compress(Density||Time); 
   cards;
   34.7	    1	Close	Early
   31.48	1	Close	Early
   34.65	1	Close	Early
   34.68	1	Close	Early
   38.29	2	Close	Late
   31.61	2	Close	Late
   31.46	2	Close	Late
   34.92	2	Close	Late
   32.06	3	Far	Early
   37.13	3	Far	Early
   34.57	3	Far	Early
   36.65	3	Far	Early
   40.31	4	Far	Late
   42.62	4	Far	Late
   42.28	4	Far	Late
   37.14	4	Far	Late
   ;
run;


/*Put your code here!*/
ods pdf file = "C:\Lab3.pdf" ;
*ods rtf file = "C:\Lab3.rtf" ;
proc glm data = cornData plots = all;
   /*Version 1: One Way ANOVA  to see the overall picture */
   /* Starts here*/ 
   class treatVar;
   model yield = treatVar;
   *See slide -4 page 10 on how you got the intercepts; 
   contrast 'Density'      intercept 0 treatVar 0.50  0.50 -0.50 -0.50;
   contrast 'Time'         intercept 0 treatVar 0.50 -0.50  0.50 -0.50;
   contrast 'Density*Time' intercept 0 treatVar 0.50 -0.50 -0.50  0.50;
   
   *ends here */
   /* 
     to recraete original ANOVA table see slide 4 pg 15, 18. 
     Use the Contrast SS, and contrast df , and MSE to get the 
     F-statistic
   */
   /*Version 2: 2 Way ANOVA  to see interation among the 2 factors, via interaction plot */
    /* Starts here */
    *class Density Time; 
    *model yield = Density Time Density*Time;
    *lsmeans Density ;
	*lsmeans Time ;
	* only ran the two factors for which p-value <0.05
	* lsmeans Density*Time;
   *as part of version 2 
   end here  */
run;
quit;
ods pdf close;
*ods rtf file = "C:\Lab3.rtf" ;









