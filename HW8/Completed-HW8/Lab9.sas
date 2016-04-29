options formdlim = "~";
data beer;
   input sodium brand bottle;
   cards;
   24.4      1      1
   22.6      1      2
   23.8      1      3
   22.0      1      4
   24.5      1      5
   22.3      1      6
   25.0      1      7
   24.5      1      8
   10.2      2      1
   12.1      2      2
   10.3      2      3
   10.2      2      4
    9.9      2      5
   11.2      2      6
   12.0      2      7
    9.5      2      8
   19.2      3      1
   19.4      3      2
   19.8      3      3
   19.0      3      4
   19.6      3      5
   18.3      3      6
   20.0      3      7
   19.4      3      8
   17.4      4      1
   18.1      4      2
   16.7      4      3
   18.3      4      4
   17.6      4      5
   17.5      4      6
   18.0      4      7
   16.4      4      8
   13.4      5      1
   15.0      5      2
   14.1      5      3
   13.1      5      4
   14.9      5      5
   15.0      5      6
   13.4      5      7
   14.8      5      8
   21.3      6      1
   20.2      6      2
   20.7      6      3
   20.8      6      4
   20.1      6      5
   18.8      6      6
   21.1      6      7
   20.3      6      8
;
run;

**Code Block #1***********************;
symbol v = dot h = 2;
proc gplot data = beer;
   plot sodium*brand;
run;
quit;
**************************************;

**Code Block #2***********************;
proc glm data = beer;
   class brand;
   model sodium = brand;
   random brand;
run;
quit;
**************************************;

**Code Block #3***********************;
proc mixed data = beer method = type3;
   class brand;
   model sodium =;
   random brand;
run;
quit;
**************************************;

**Code Block #4***********************;
proc mixed data = beer method = reml;
   class brand;
   model sodium =;
   random brand;
run;
quit;
**************************************;
