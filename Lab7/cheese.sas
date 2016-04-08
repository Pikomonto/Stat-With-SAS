********************************************************
**SAS file corresponding to LAB 7 - MLR
**Justin Post - Spring 2015
********************************************************;

/*
       1. Case: Sample number
       2. Taste: Subjective taste test score, obtained by combining the scores of several tasters
       3. Acetic: Natural log of concentration of acetic acid
       4. H2S: Natural log of concentration of hydrogen sulfide
       5. Lactic: Concentration of lactic acid
*/

DATA cheese;
   INPUT case taste acetic h2s lactic;
   datalines;
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
RUN;

proc print data=cheese;
run;
quit; 
proc glm data = cheese; 
  model taste = acetic h2s lactic; 
run;
quit;
proc glm data = cheese; 
  model taste =  h2s lactic acetic; 
run;
quit;
proc glmselect data = cheese; 
  model taste = acetic h2s lactic / selection = forward(select = sl); 
run;
quit;
proc glmselect data = cheese; 
  model taste = acetic h2s lactic / selection = backward(select = sl) SLstay = 0.20; 
run;
quit;
proc glmselect data = cheese; 
  model taste = acetic h2s lactic / selection = backward(select = sl) SLentry = 0.20 SLstay = 0.30; 
run;
quit; 
proc glmselect data = cheese; 
  model taste = acetic h2s lactic / select = cp; 
run;
quit;




