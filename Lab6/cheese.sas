/*
       1. Case: Sample number (i.e. replicate)
       2. Taste: Subjective taste test score, obtained by combining the scores of several tasters
       3. Acetic: Log of concentration of acetic acid
       4. H2S: Log of concentration of hydrogen sulfide
       5. Lactic: Concentration of lactic acid
*/

data cheese;
   input case taste acetic h2s lactic;
   cards;
     1       12.3    4.543   3.135   0.86
     2       20.9    5.159   5.043   1.53
     3       39      5.366   5.438   1.57
     4       47.9    5.759   7.496   1.81
     5       5.6     4.663   3.807   0.99
     6       25.9    5.697   7.601   1.09
     7       37.3    5.892   8.726   1.29
     8       21.9    6.078   7.966   1.78
     9       18.1    4.898   3.85    1.29
     10      21      5.242   4.174   1.58
     11      34.9    5.74    6.142   1.68
     12      57.2    6.446   7.908   1.9
     13      0.7     4.477   2.996   1.06
     14      25.9    5.236   4.942   1.3
     15      54.9    6.151   6.752   1.52
     16      40.9    6.365   9.588   1.74
     17      15.9    4.787   3.912   1.16
     18      6.4     5.412   4.7     1.49
     19      18      5.247   6.174   1.63
     20      38.9    5.438   9.064   1.99
     21      14      4.564   4.949   1.15
     22      15.2    5.298   5.22    1.33
     23      32      5.455   9.242   1.44
     24      56.7    5.855   10.199  2.01
     25      16.8    5.366   3.664   1.31
     26      11.6    6.043   3.219   1.46
     27      26.5    6.458   6.962   1.72
     28      0.7     5.328   3.912   1.25
     29      13.4    5.802   6.685   1.08
     30      5.5     6.176   4.787   1.25
;
run;
ods graphics on; 
proc corr data = cheese plots=matrix; 
  var acetic h2s lactic ;
run; 
ods graphics off;
quit; 
/*code goes here */

ods graphics on; 
proc glm data = cheese plots=all; 
  *model taste = acetic h2s lactic; 
  *model taste = acetic h2s lactic / clparm ;
  model taste = acetic h2s lactic / clparm xpx i;
run; 
ods graphics off;
quit; 
data newtaste; 
  input acetic h2s lactic;
  cards; 
  10 5.5 4
  ;
run;
quit;
data allData;
  set cheese newtaste;
run;
quit;
/*
Predictign new values 
*/
proc glm data=allData plots = none; 
  model taste = acetic h2s lactic / cli; 
  output out = predictions   /*this creates  a dataset to hold your predictions, name anythign you want */
    p = pred_value_bal_sal  /*creates a variable name to hold ...*/  
    lcl = lower_pi          /*create a vraible for the lower limit */
	ucl = upper_pi          /*upper limti varaible */
    lclm = lower_ci         /* lower limit of ... */ 
    uclm = upper_ci         /* lower limit of ... */ 
    ;
run;
quit;
proc glm data =allData; 
  model taste = acetic h2s lactic / clm alpha = 0.10; 
run; 
quit;  
proc glm data =allData; 
  model taste = acetic h2s lactic / cli alpha = 0.10; 
run; 
quit;  
/*what is the predicted valeu for 12.5 ro 49 ? */
ods graphics on; 
proc reg data=cheese plots=all ; 
  model taste = acetic h2s lactic / cli ; 
run; 
quit;  
ods graphics off; 

 
