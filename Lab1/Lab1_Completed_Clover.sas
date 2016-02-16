proc import datafile="C:\SAS_Stuff\CloverdataNew.txt" out=cloverDataNew dbms=csv replace;
     *input strain $ nitrogen;
     getnames=yes;
run;
proc print data = cloverDataNew; 
run;
proc sort data = cloverDataNew;
     by Strain;
run;
proc means data = cloverDataNew; 
  /*get summary stats for each strain (col#1) */
  by Strain; 
  /* response variable is nitrogen */
  var nitrogen; 
run;
proc glm data = cloverDataNew plots=all;
     *Use STRAIN as a classification (i.e. categorical) variable;
     class strain;
     *Model the NITROGEN level based on the STRAIN;
     model nitrogen = strain;
run;
quit;
