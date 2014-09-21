###Course project for Coursera Getting and Cleaning Data
============
This is my course project for the Coursera course Getting and Cleaning Data. (Sept 2014 session)
The goal is to create a subset of tidy data from the Human Activity Recognition (HAR) Using Smartphones Dataset found here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
The tidy data will hypothetically be used for downstream analysis. The raw data includes 10299 data observations of 561 variables and this analysis only requires the mean of observations for each activity and subject (180 observations of 2 grouping factors and 66 data variables.

##Files included
run_analysis.r	Script to create tidy data from raw data.
tidy_data.txt	Tidy data output by run_analysis
CodeBook.md		Describes methods and variables used in tidy_data.txt
README.md		This file - describes purpose and contents of the project

##Steps to reproduce 
1. Download and unzip the dataset to R's working directory from the URL listed above (keeping folder structure intact)
2. Run run_analysis.r
3. run_analysis will create a tidy data file named "tidy_data.txt" in R's working directory