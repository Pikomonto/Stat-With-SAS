/*
Name: Akond Rahman 
Unity ID: aarahman 
Section: 001B 
Title: Solution to HW1-Question 3
Descritpion: 
This program solves Question # 8.32 of the course book. 
I did not use any external files. 
*/

/*
The first to solve this question is create the dataset using the 'data'
command 
*/
data corn;
 input type $ yields;
 cards;

 A 2.5 
 A 3.6 
 A 2.8 
 A 2.7 
 A 3.1 
 A 3.4 
 A 2.9 
 A 3.5 
 B 3.6 
 B 3.9 
 B 4.1 
 B 4.3 
 B 2.9 
 B 3.5 
 B 3.8 
 B 3.7 
 C 4.3 
 C 4.4 
 C 4.5 
 C 4.1 
 C 3.5 
 C 3.4 
 C 3.2 
 C 4.6 
 D 2.8 
 D 2.9 
 D 3.1 
 D 2.4 
 D 3.2 
 D 2.5 
 D 3.6 
 D 2.7 
;

run;

/*
  The next step is to sort the data by the category variable. In this 
  case this it is 'type of corn'
*/
proc sort data = corn;

    by type;

run;
/*
Using the sorted data we use the 'GLM' procedure 
to perform ANOVA test. To get the diganostic plots we 
use the 'plots' command. This command will generate 
diagnostic plots using which we can determine the 
assumptions of ANOVA are satsified by the dataset 
of interest.  
*/


proc glm data = corn plots=diagnostics residuals;

    *Use type as a classification (i.e. categorical) variable;

    class type;

    *Model the yields level based on the type;

    model yields = type; 

run;
quit;
/*

Answer to (a) 
Model for parameters y_pq = mu_p + epsilon_pq 
here y_pq is the q-th recorded yields for the p-th 
corn type. Recorded yields are measured in bushels 
per plot  
p = 1, 2, 3, 4 respectively for corn variety A, B, C, D 

Answer to (b) 
Hypotheses for parameter fo interest 
NULL Hypthesis,  H_0 = mu_1 = mu_2 = mu_3 = mu_4 
Alt. Hypothesis, H_A = at least one of mu_1 , mu_4, mu_3, mu_4  is different 

Assumptions made on the model:
i. single, continuous response variable obtained 
   from a simple random sample, OR, a compeltely 
   randomized design is used 
ii. Within each treatment group the residuals are
    homescedastic, independent, and normally distributed 

Diagnostic plots are generated from the code

Comments on the assumptions: 
Asssumption # i is satisifed as the corn types 
are randomly assigned to the eight plots, as per problem 
statement. 

From the 'Residual-Quantile' plot excpet for two, all 
residulas fit the straight 
line, so the residuals are normal. Except for one residual, 
from the 'RStudent-Predicted Value' plot 
we see the residuals lie within the range of 
(-2, 2). Overall, we observe that assumption # ii is 
satisifed for the datset. 

 
The tets statistic is: 11.05 
The p-value: 0.0001
Conclusion: As p-value < 0.05, we reject the null hypothesis.

There is staistically sufficient sample evidence to suggest that  
at least one of the mean yields of each corn types is different. 
*/
