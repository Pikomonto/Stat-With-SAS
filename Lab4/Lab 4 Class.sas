/**************************************************
Author: Jonathan W. Duggins
Last Update: 2016-01-27

Notes: Create ROOT data set for Lab 4
***************************************************/

options nodate pageno=1 formdlim="~";

data root;
   input pretreat replicate variety length;
   cards;
   1  1  1  11
   1  1  2  26
   1  1  3  17
   1  1  4  08
   1  2  1  05
   1  2  2  13
   1  2  3  30
   1  2  4  05
   1  3  1  07
   1  3  2  15
   1  3  3  21
   1  3  4  05
   2  1  1  15
   2  1  2  20
   2  1  3  15
   2  1  4  15
   2  2  1  17
   2  2  2  21
   2  2  3  29
   2  2  4  12
   2  3  1  04
   2  3  2  20
   2  3  3  28
   2  3  4  10
   3  1  1  03
   3  1  2  05
   3  1  3  06
   3  1  4  10
   3  2  1  01
   3  2  2  04
   3  2  3  03
   3  2  4  10
   3  3  1  06
   3  3  2  04
   3  3  3  04
   3  3  4  05
   ;
run;

/*Put your code here!*/
/*Two-way ANOVA model*/

proc glm data = root plots=all ;
   class  pretreat variety;
   model length = pretreat|variety/ alpha=0.00833 clparm;
   * benfoerroni  mc , alpha = .05/6 = 0.00833; 
   * simple effects with tukey corrections ;
   lsmeans pretreat*variety / adjust = tukey cl pdiff alpha=0.05;
   estimate 'mu11-mu12' intercept 0 pretreat 0 0 0  variety 1 -1 0 pretreat*variety 1 -1 0 0  0 0 0 0  0 0 0 0  ;
   estimate 'mu12-mu22' intercept 0 pretreat 1 -1 0 variety 0 0  0 pretreat*variety 0 1 0 0   0 -1 0 0  0 0 0 0  ;
   estimate 'mu14-mu24' intercept 0 pretreat 1 -1 0 variety 0 0  0 pretreat*variety 0 0 0 1   0 0 0 -1  0 0 0 0  ;
   estimate 'mu13-mu23' intercept 0 pretreat 1 -1 0 variety 0 0  0 pretreat*variety 0 0 1 0   0 0 -1 0  0 0 0 0  ;
   * pretreat has three categories so we ahve three splits for alpha, variety has four types so we have four betas ;
run;
quit;

proc glm data = root plots = none;
   class  pretreat variety;
   model length = pretreat|variety;
   * what is the effect on each pretrat of variety ; 
   lsmeans pretreat*variety / cl slice = pretreat;
   * what is the effect on each variety of pretreat ; 
   lsmeans pretreat*variety / slice = variety;
run;
quit;
