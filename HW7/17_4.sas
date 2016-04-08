/*
Akond Rahman 
Date: April 07, 2016 
Section 001B
Title: 17.4 problem for HW#7 
*/
/*Loading data*/
data bull_calf;
   input bull @ ;
   do k = 1 to 6;
      input avg_weight @;
      output;
   end;
   cards;
   1 1.20 1.39 1.36 1.39 1.22 1.31 
   2 1.16 1.08 1.22 0.97 1.17 1.12 
   3 0.75 1.12 1.02 1.08 0.83 0.98 
   4 0.96 1.16 1.05 1.00 1.12 1.15 
   5 0.99 0.85 1.10 1.03 0.94 0.89 
;
run;
/* Executing the random effects model using GLM */
proc glm data = bull_calf;
   * bull is the only factor ; 
   class bull;
   model avg_weight = bull; 
   random bull; * tell GLM that bull is the random factor ; 
run;
quit;
/* Executing the random effects model using MIXED model with Type III */
proc mixed data = bull_calf method = type3;
   * bull is the only factor ; 
   class bull; 
   model avg_weight = ; * as no fixed effects so nothing goes here ; 
   random bull; * tell MIXED model that bull is the random factor ; 
run;
quit;
/* Executing the random effects model using MIXED model with restricted maximum likelihood */
proc mixed data = bull_calf method = reml; 
   * bull is the only factor ; 
   class bull;
   model avg_weight =; * as no fixed effects so nothing goes here ; 
   random bull; * tell MIXED model that bull is the random factor ;
   estimate 'Avg. daily weight gain' intercept 1 / cl; * get CI of the estimate of the avg. weight daily weight gain ;
run;
quit;
