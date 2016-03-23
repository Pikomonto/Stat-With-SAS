/**************************************************
Author: Jonathan W. Duggins
Last Update: 2016-03-08

Notes: Create vitamin supplement data for Example 6.3
       in ST 512 Lecture Notes
***************************************************/

options pageno=1 nodate formdlim="~";
ods graphics on;

ods pdf file = "S:\Documents\CURRENT COURSES\ST 512\SAS Code\Example 6.3 Output.pdf" startpage = never;

*read in data;
data vitamin;
   input supp gain caloric @@;
   cards;
   1  48  350  2  65  400  3  79  510  4  59  530
   1  67  440  2  49  450  3  52  410  4  50  520
   1  78  440  2  37  370  3  63  470  4  59  520
   1  69  510  2  75  530  3  65  470  4  42  510
   1  53  470  2  63  420  3  67  480  4  34  430
   ;
run;

*Fit basic One-way ANOVA model;
title1 'One-Way ANOVA Model';
title2 'Response: Weight Gain';
title3 'Factor: Vitamin Supplement';
proc glm data = vitamin plots = none;
   class supp;
   model gain = supp / solution xpx i;
run;
quit;

ods pdf startpage = now;

*Fit the GLM (ANCOVA);
title1 'GLM with Means and LS-Means Included';
title2 'Response: Weight Gain';
title3 'Factor: Vitamin Supplement';
title4 'Covariate: Caloric Intake';
proc glm data = vitamin plots = none;
   class supp;
   model gain = supp caloric / solution xpx i;
   means supp;
   lsmeans supp;
   means supp / tukey cldiff;
   lsmeans supp / stderr adjust = tukey cl;
run;
quit;

ods pdf startpage = now;

*Fit the GLM using only the necessary code
 and request plots;
title1 'GLM with Means and LS-Means Included';
title2 'Response: Weight Gain';
title3 'Factor: Vitamin Supplement';
title4 'Covariate: Caloric Intake';
proc glm data = vitamin plots = all;
   class supp;
   model gain = supp caloric / solution;
   lsmeans supp / adjust = tukey cl;
run;
quit;

ods pdf close;
