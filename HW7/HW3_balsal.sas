options pageno=1 nodate formdlim="~";
ods graphics on;

data rating;
   input sweetener milkfat air @;
   do k = 1 to 3;
      input rating_val @;
      output;
   end;
   cards;
   12  10 5   23  24  25
   12  10 10  36  35  36
   12  10 15  28  24  27
   12  12 5   27  28  26
   12  12 10  34  38  39
   12  12 15  35  35  34
   12  15 5   31  32  29
   12  15 10  33  34  35
   12  15 15  26  27  25
   16  10 5   24  23  28
   16  10 10  37  39  35
   16  10 15  26  29  25
   16  12 5   38  36  35
   16  12 10  34  38  36
   16  12 15  36  37  34
   16  15 5   34  36  39
   16  15 10  34  36  31
   16  15 15  28  26  24
;
run;
proc glm data = rating plots = none;
   class sweetener milkfat air;
   model rating_val = sweetener|milkfat|air;
   *lsmeans temp*density*salinity / slice = density*temp;
   *lsmeans temp*density*salinity / slice = density*salinity;
   *lsmeans temp*density*salinity / slice = temp*salinity;
run;
quit;
proc sort data = rating;
   by sweetener milkfat air;
run;

*Get the WT_GAIN means separately for each combination of TEMP, DENSITY, and SALINITY;
proc means data = rating mean noprint;
   by sweetener milkfat air;
   var rating_val;
   *Store the means in a dataset (MEANZ) and name the mean (AVG_GAIN);
   output out = meanz mean = Avg_Gain;
run;
quit;
*Set some graphical options: 
   the plotting symbol,
   connect the dots with lines,
   set the height of the dot,
   set the width of the line
   ;
symbol v=dot i = join height = 3 width = 3;

*Define how you want the vertical axis to look: 
   set the size of the tick marks labels,
   set the range of values and the BY value to determine where tick marks appear,
   define the angle (90 degrees), font, size, and value, for the label
   ;                                            
axis1 value = (h=1.5) 
      order = (20 to 40 by 5) 
      label = (a=90 font=swissb height = 2 "Mean Rating Val");

*Define how you want the horizontal axis to look:
   set the size of the tick mark labels,
   move the drug labels away from the edges of the graph,
   define the font, size, and value, for the label
   ;
axis2 value = (h=2) 
      offset = (5cm) 
      order = (5 10 15)
      label = (f = swissb h = 2 "Air");

*Define how you want the legend to look:
   set the font, size, and value for the label,
   set the font and size for the tick mark labels
   ;
legend1 label = (f = swissb h = 1.75 "MilkFat") value = (f = swiss h = 1.5);

*Define the location and filename for the graph, then set the type and size;
filename wt_prof1 "C:\Sweetener_12.png";
goptions device = png gsfname = wt_prof1 hsize = 12in vsize = 9in;

*Define useful titles, and set their font and sizes;
title1 f = swissb h = 2.5 "Profile Plot for Icecream Rating Data";
title2 f = swissb h = 2.25 "Controlling for Sweetener=12%";


*Create the profile plot;
proc gplot data = meanz;
   *Plotting y*x = z uses a different color for each value of z;
   where sweetener eq 12;
   plot avg_gain*air = milkfat / vaxis = axis1 haxis = axis2 legend = legend1;
                              *Be sure to _USE_ the axes we defined above!;
run;
quit;
*Define useful titles, and set their font and sizes;
title1 f = swissb h = 2.5 "Profile Plot for Icecream Rating Data";
title2 f = swissb h = 2.25 "Controlling for Sweetener=16%";


*Create the profile plot;
proc gplot data = meanz;
   *Plotting y*x = z uses a different color for each value of z;
   where sweetener eq 16;
   plot avg_gain*air = milkfat / vaxis = axis1 haxis = axis2 legend = legend1;
                              *Be sure to _USE_ the axes we defined above!;
run;
quit;

