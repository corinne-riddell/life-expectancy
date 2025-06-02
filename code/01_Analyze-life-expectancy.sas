/**SAS version of code for Github course**/

/*Part I working alone*/

/*This is a .sas file, used for writing code in SAS.*/
/*Text enclosed within the slash-asterisk and asterisk-slash are comments that SAS will ignore.*/


/*First, import the data from a .csv file into a SAS data file*/
/*You could do this using the file menu (but beware, some text variables may get cut off) or, better, 
using the following code--but to use this code you'll have to fill in the file path*/

PROC IMPORT OUT= WORK.LE_DATA 
            DATAFILE= "YourFilePathHere\data\Life-expectancy-by-state-long.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
	 GUESSINGROWS=max;
RUN;

/*Run a regression model with time coded using a linear term*/

proc reg data=le_data;
	model le = year;
	where state="California" and race="black" and sex="Female";
	run;
	quit;
/*Examine the output. The fit plot shows the observed data and the fitted line.*/

/*In order to save the fit plot, use ods commands below and then repeat the proc reg*/
ods listing gpath="YourFilePathHere\images";
ods graphics / imagename="ca-black-women-LE" imagefmt=png;
proc reg data=le_data  plots(only)=fitplot; /*We just want to save one of the plots it can make: the fit plot*/
	model le = year;
	where state="California" and race="black" and sex="Female";
	run;
	quit;
ods listing close;

/*Note that numbers and/or underscores might get appended to the image file name if you run the code more than once.*/
