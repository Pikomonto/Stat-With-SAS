**  ST 512 Homework 8 Data Sets  ******************
**************************************************;

/* Prob. 17.10, 17.11 */
*Units for COUNT is thousands of ants killed;
data chemical;
  input loc @;
  do chem = 1 to 4;
     input count @;
    output;
  end;
cards;
1 7.2 4.2 9.5 5.4
1 9.6 3.5 9.3 3.9
2 8.5 2.9 8.8 6.3
2 9.6 3.3 9.2 6.0
3 9.1 1.8 7.6 6.1
3 8.6 2.4 7.1 5.6
4 8.2 3.6 7.3 5.0
4 9.0 4.4 7.0 5.4
5 7.8 3.7 9.2 6.5
5 8.0 3.9 8.3 6.9
;
run;

/* Prob. 17.27, 17.28 */
data airplane;
  input oper @;
  do mach = 1 to 4;
     input strength @;
    output;
  end;
cards;
1 204 205 203 205
1 205 210 204 203
2 205 205 206 209
2 207 206 204 207
3 211 207 209 215
3 209 210 214 212
;
run;


quit;
