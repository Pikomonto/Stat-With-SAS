proc import datafile="C:\SAS_Stuff\Firm.xls" out=firmData dbms=xls replace;
     /*if the file is .xlsx* then dbms=xlsx/
     SHEET="Sheet1"; /*you have to tell which sheet you want to load */
     getnames=yes;
	 /*Do not keep the excel sheet open while executing this program*/
run;
proc print data = firmData; 
run;
proc sort data = firmData;
     by Gender;
run;
proc means data = firmData; 
  /*get summary stats for each gender (col#2) */
  by Gender; 
  /* response variable is nitrogen */
  var Bonus; 
run;
proc glm data = firmData plots=all;
     *Use Gender as a classification (i.e. categorical) variable;
     class Gender;
     *Model the Bonus level based on the Gender;
     model Bonus = Gender;
run;
quit;

