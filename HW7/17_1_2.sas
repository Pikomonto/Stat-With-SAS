data paint_data;
   input batch @ ;
   do k = 1 to 5;
      input percent_value @;
      output;
   end;
   cards;
   1 4.18 2.29 1.40 8.69 1.01
   2 5.60 4.74 1.86 6.29 2.25
   3 7.59 7.46 5.79 5.09 5.47
   4 4.25 5.39 4.81 7.75 6.10
   5 2.18 5.88 3.07 5.25 3.50
   6 5.11 7.61 3.46 6.57 6.35
   7 5.68 7.55 2.30 2.15 8.92
   8 4.61 7.14 4.61 5.23 3.56
   9 8.72 6.93 5.25 8.97 4.34
   10 4.67 7.85 2.21 9.57 4.85
;
run;

proc glm data = paint_data;
   class batch;
   model percent_value = batch;
   random batch;
run;
quit;

proc mixed data = paint_data method = type3;
   class batch;
   model percent_value = ; *evrything in the model statement si fixed .. nothing given means nothign si fixed; 
   random batch; *evrything in the random statement si random ; 
run;
quit;
proc mixed data = paint_data method = reml; 
   class batch;
   model percent_value =;
   random batch;
   estimate 'Avg. fade' intercept 1 / cl;
run;
quit;


