/**************************************************
Author: Jonathan W. Duggins
Last Update: 2016-01-26

Notes: Obtain three-way analysis for Example 3.8 from
       ST 512 Lecture Notes.
***************************************************/

options pageno=1 nodate formdlim="~";
ods graphics on;

data shrimp;
   input Temp Density Salinity @;
   do k = 1 to 3;
      input wt_gain @;
      output;
   end;
   cards;
   25  80 10  86  52  73
   25  80 25 544 371 482
   25  80 40 390 290 397 
   25 160 10  53  73  86
   25 160 25 393 398 208
   25 160 40 249 265 243
   35  80 10 439 436 349
   35  80 25 249 245 330
   35  80 40 247 277 205
   35 160 10 324 305 364
   35 160 25 352 267 316
   35 160 40 188 223 281
;
run;

ods pdf file = "E:\SCHOOL\TEACHING\NCSU COURSES\ST 512\SAS Code\Example 3.8 Output.pdf" startpage = never;

*Fit 3-way ANOVA model;
title1 "Three-Way Analysis with Slices for each set of Simple Effects";
proc glm data = shrimp plots = none;
   class temp density salinity;
   model wt_gain = temp|density|salinity;
   lsmeans temp*density*salinity / slice = density*temp;
   lsmeans temp*density*salinity / slice = density*salinity;
   lsmeans temp*density*salinity / slice = temp*salinity;
run;
quit;

ods pdf close;


*Clear the title so it doesn't carry over to later procedures inadvertently;
title;

/*Investigating a three-way interaction can be VERY
  time consuming! We start with a graphical exploration.

  The next step would be the SLICES shown in the PROC GLM above.

  The next step would be manually constructing contrasts for any 
  necessary simple effects, using the correct MCP. (This is NOT 
  included in this code.) */

*Sort data so we can get means next;
proc sort data = shrimp;
   by temp density salinity;
run;

*Get the WT_GAIN means separately for each combination of TEMP, DENSITY, and SALINITY;
proc means data = shrimp mean noprint;
   by temp density salinity;
   var wt_gain;
   *Store the means in a dataset (MEANZ) and name the mean (AVG_GAIN);
   output out = meanz mean = Avg_Gain;
run;

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
      order = (50 to 475 by 25) 
      label = (a=90 font=swissb height = 2 "Mean Weight Gain");

*Define how you want the horizontal axis to look:
   set the size of the tick mark labels,
   move the drug labels away from the edges of the graph,
   define the font, size, and value, for the label
   ;
axis2 value = (h=2) 
      offset = (5cm) 
      order = (10 25 40)
      label = (f = swissb h = 2 "Salinity");

*Define how you want the legend to look:
   set the font, size, and value for the label,
   set the font and size for the tick mark labels
   ;
legend1 label = (f = swissb h = 1.75 "Temperature") value = (f = swiss h = 1.5);

*Define the location and filename for the graph, then set the type and size;
filename wt_prof1 "E:\SCHOOL\TEACHING\NCSU COURSES\ST 512\Lecture Notes\Graphics\Weight_Profile_Density80.png";
goptions device = png gsfname = wt_prof1 hsize = 12in vsize = 9in;

*Define useful titles, and set their font and sizes;
title1 f = swissb h = 2.5 "Profile Plot for Shrimp Weight Gain Data";
title2 f = swissb h = 2.25 "Controlling for Density = 80 shrimp / 40 liters";
title3 f = swissb h = 2 "Same Scale as the Original Data";

*Create the profile plot;
proc gplot data = meanz;
   *Plotting y*x = z uses a different color for each value of z;
   where density eq 80;
   plot avg_gain*salinity = temp / vaxis = axis1 haxis = axis2 legend = legend1;
                              *Be sure to _USE_ the axes we defined above!;
run;

*Define the location and filename for the next graph, then set the type and size;
filename wt_prof2 "E:\SCHOOL\TEACHING\NCSU COURSES\ST 512\Lecture Notes\Graphics\Weight_Profile_Density160.png";
goptions device = png gsfname = wt_prof2 hsize = 12in vsize = 9in;

*Define useful titles, and set their font and sizes;
title1 f = swissb h = 2.5 "Profile Plot for Shrimp Weight Gain Data";
title2 f = swissb h = 2.25 "Controlling for Density = 160 shrimp / 40 liters";
title3 f = swissb h = 2 "Same Scale as the Original Data";

*Create the profile plot;
proc gplot data = meanz;
   *Plotting y*x = z uses a different color for each value of z;
   where density eq 160;
   plot avg_gain*salinity = temp / vaxis = axis1 haxis = axis2 legend = legend1;
                              *Be sure to _USE_ the axes we defined above!;
run;

quit;
