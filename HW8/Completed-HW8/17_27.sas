/*
Akond Rahman 
Date: April 14, 2016 
Section 001B
Title: 17.27 and 17.28 problem for HW#8
*/
/*Loading data*/
data strength_data;
   input machine operator @ ;
   do k = 1 to 2;
      input strength @;
      output;
   end;
   cards;
   1 1 204 205
   1 2 205 207
   1 3 211 209
   2 1 205 210
   2 2 205 206
   2 3 207 210
   3 1 203 204
   3 2 206 204
   3 3 209 214
   4 1 205 203
   4 2 209 207
   4 3 215 212
;
run;
quit; 
/*Using Type III method*/
proc mixed data = strength_data method = type3 ;
   class  machine operator; /* machine and operator are the two factors*/
   model strength =;   /* strength is the response*/
   random  machine operator machine*operator; /* machine*operator, machine and operator are the random factors*/
run;
/* Ans.to 17.28 (a)  */
/*Using REML method*/
proc mixed data = strength_data method = reml  ;
   class  machine operator; /* machine and operator are the two factors*/
   model strength = / ddfm = satterth cl  ; /* strength is the response, used Satterwieth's adjustment for degrees of freedom */
   random  machine operator machine*operator; /* machine*operator, machine and operator are the random factors*/
   estimate 'Avg. solder strength' intercept 1 / cl; * get CI of the estimate of the avg. solder strength ;
run;






