
run_analysis.R 

This is the script to produce tidy.txt    
  
It requires the UCI HAR Dataset which is available at the address below:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
  
It also requires the data.table and dplyr packages which can be installed using: 
install.packages("data.table")
install.packages("dplyr")
  
The script gathers all the test and train data files and merges them into one data.table
called merged.  It replaces the activity code with the activity labels in 
activity_labels.txt

It extract only the columns from feature.txt that correspond to means or standard deviations. 

Groups the extracted data by subjectid and activity.
Averages the features of the groups. 
Writes the file tidy.txt with the averaged features for each of the 30 subjects while partaking in each of the 6 activities.

tidy.txt can be read back into R using:

tidy <- fread("tidy.txt")


  

    