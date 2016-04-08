data growth;
   input salinity $ app @;
   do rep = 1 to 3;
      input growth @;
      output;
   end;
   cards;
   c   1  11.29 11.08 11.1
   c   2  7.37 6.55 8.5
   6b  1  5.64 5.98 5.69
   6b  2  4.2 3.34 4.21
   12b 1  4.83 4.77 5.66
   12b 2  3.28 2.61 2.69
   ;
run;

*Code Block #1*************************************;
proc glm data = growth;
   class salinity app;
   model growth = salinity app(salinity);
run;
quit;
***************************************************;

*Code Block #2*************************************;
proc glm data = growth;
   class salinity app;
   model growth = salinity app(salinity) / clparm alpha = 0.00833;
*for each theta we need coeff on*****mu********alpha1**alpha2**alpha3***********beta11**beta12**beta21**beta22**beta31**beta32*** use a divisor, if needed;
*                                    |            |       |      |                 |      |        |       |       |      |                 |             ;
*                                    |            |       |      |                 |      |        |       |       |      |                 |             ;
   estimate '12b vs 6b' intercept    0   salinity 2      -2      0   app(salinity) 1      1       -1      -1       0      0     / divisor = 2 e;
   estimate;
   estimate;
   estimate;
   estimate;
   estimate;
run;
quit;
***************************************************;
