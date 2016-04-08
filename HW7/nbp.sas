/*
Akond Rahman 
Date: April 07, 2016 
Section 001B
Title: Non book problem for HW#7 
*/
/*Loading data*/
data nbp;
   input a b @ ;
   do k = 1 to 3;
      input bloodsugar @;
      output;
   end;
   cards;
   1 1 18 16 13 
   1 2 23 19 17 
   2 1 20 19 21 
   2 2 17 15 20 
   3 1 30 28 26 
   3 2 33 36 30 
;
run;
quit;
/*Answering Part (a), (b), and (d)*/
proc glm data = nbp plots = none;
   /*settting up model, telling SAS what are the factors , in thsi case it is a and b */
   class a b;
   * (a) ; 
   /*creating the model ... this will give the ANOVA table to answer part (a), and (b) */
   model bloodsugar = a b(a) / clparm ;
   * answering part (d) thsi will give the results of multiple comparison test using tukey 
   * for different levels of factor a ; 
   lsmeans a  / adjust = tukey cl;
run;
quit; 
/*Answering Part (c) */
proc glm data = nbp plots = none;
   class a b;
   * simultaneous CIs for factor b within factor, as there are three comparisons, 
   * according to Bonferroni, alpha_i = alpha_e / 3  ;
   model bloodsugar = a b(a) / clparm alpha = 0.03333 ;
   * doing the comparisons one by one ;
   estimate 'B-1 vs. B-2 within A=1' intercept 0 a 0 0 0 b(a) 1 -1  0 0   0 0  ;
   estimate 'B-1 vs. B-2 within A=2' intercept 0 a 0 0 0 b(a) 0 0   1 -1  0 0  ;
   estimate 'B-1 vs. B-2 within A=3' intercept 0 a 0 0 0 b(a) 0 0   0 0   1 -1 ;
run;
quit; 
/*sanity check plots ... not used in answer */
/*
proc gplot data = nbp;
   plot bloodsugar*a;
run;
quit;
*/




