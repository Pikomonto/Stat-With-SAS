/*
Akond Rahman 
Date: April 14, 2016 
Section 001B
Title: 17.10 and 17.11 problem for HW#8
*/
/*Loading data*/
data fire_ant_killer;
   input chemical location @ ;
   do k = 1 to 2;
      input kill_count @;
      output;
   end;
   cards;
   1 1 7.2 9.6
   1 2 8.5 9.6
   1 3 9.1 8.6
   1 4 8.2 9.0
   1 5 7.8 8.0
   2 1 4.2 3.5
   2 2 2.9 3.3
   2 3 1.8 2.4
   2 4 3.6 4.4
   2 5 3.7 3.9
   3 1 9.5 9.3
   3 2 8.8 9.2
   3 3 7.6 7.1
   3 4 7.3 7.0
   3 5 9.2 8.3
   4 1 5.4 3.9
   4 2 6.3 6.0
   4 3 6.1 5.6
   4 4 5.0 5.4
   4 5 6.5 6.9
;
run;
quit; 
proc mixed data = fire_ant_killer method = type3 ;
   class  chemical location; /* chemical and location are the two factors*/
   model kill_count = chemical ; /*chemical is the fixed factor, kill_count is the response*/
   random  location location*chemical; /* location*chemical, and location are the random factors*/
run;


