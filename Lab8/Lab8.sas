ods graphics off;
options formdlim = "~";

data cheese;
   input case taste acetic h2s lactic;
   cards;
   1     12.3    4.543    3.135   0.86
   2     20.9    5.159    5.043   1.53
   3     39.0    5.366    5.438   1.57
   4     47.9    5.759    7.496   1.81
   5      5.6    4.663    3.807   0.99
   6     25.9    5.697    7.601   1.09
   7     37.3    5.892    8.726   1.29
   8     21.9    6.078    7.966   1.78
   9     18.1    4.898    3.850   1.29
   10    21.0    5.242    4.174   1.58
   11    34.9    5.740    6.142   1.68
   12    57.2    6.446    7.908   1.90
   13     0.7    4.477    2.996   1.06
   14    25.9    5.236    4.942   1.30
   15    54.9    6.151    6.752   1.52
   16    40.9    6.365    9.588   1.74
   17    15.9    4.787    3.912   1.16
   18     6.4    5.412    4.700   1.49
   19    18.0    5.247    6.174   1.63
   20    38.9    5.438    9.064   1.99
   21    14.0    4.564    4.949   1.15
   22    15.2    5.298    5.220   1.33
   23    32.0    5.455    9.242   1.44
   24    56.7    5.855   10.199   2.01
   25    16.8    5.366    3.664   1.31
   26    11.6    6.043    3.219   1.46
   27    26.5    6.458    6.962   1.72
   28     0.7    5.328    3.912   1.25
   29    13.4    5.802    6.685   1.08
   30     5.5    6.176    4.787   1.25
   ;
run;

*Step 1;
proc glm data = cheese;
   model taste = acetic;
   output out = step01 r = yx1;
run;
quit;

*Step 2;
proc glm data = step01;
   model h2s = acetic;
   output out = step02 r = x2x1;
run;
quit;


*Step 3;
proc glm data = step02;
   model yx1 = x2x1;
   output out = step03 r = yx2_x1;
run;
quit;

*Step 4;
proc glm data = step03;
   model taste = acetic h2s;
   output out = step04 r = yx1x2;
run;
quit;

proc print data = step04;
run;
quit;

* Step-Extra  ;

proc corr data = step04 nosimple noprob; 
  var case taste acetic h2s lactic yx1 x2x1 yx2_x1 yx1x2  ;

run; 
quit; 

/*Answers */
/*

SSR_Step1 = Type I SS of x_1 in Step 4 
SSR_Step3 = Type I/Type III SS of x_2 in Step 4 

r_y|x1 = 0.549 
r_y|x_2x_1 = 0.529 
r-sqaure_y|x1 + r-square_y|x2_x1 = R-square in Step-4 
r_x2|x2x1 = 0 


*/
