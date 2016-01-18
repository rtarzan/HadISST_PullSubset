Read Me for HadISST Scripts

These scripts are designed to help people pull monthly, seasonal, or annual temperature
data from the HadISST txt files of temperature data. 

Generally, you'll want to use ProcessTemp, which will call Gettemp (need both files in
your directory)
If you want to run the script for a variety of locations stored in an Excel file, see
TempAnalDriver as an example
Detailed instructions for using the script are written as comments at the top

Warnings (areas for script improvement) 
-make sure that line 1+181n where n is a positive integer represents a header line
If not, you'll be pulling data from the wrong location
-script is slow but it gets the job done
-use the *full* data file or modify the script accordingly, the script as written assumes 
that the first data being read in are from January 1970

If you notice any issues or have questions I would like to know so they can be fixed:
rem2195 at columbia dot edu 