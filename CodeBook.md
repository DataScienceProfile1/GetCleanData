###Course project for Coursera Getting and Cleaning Data

## Study Design
This project creates tidy data from the Human Activity Recognition (HAR) Using Smartphones Dataset found here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
Information about the experiment and collection methods for the data can be found here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
More detail is also provided in the readme.txt file included with the dataset.

The dataset contains accelerometer and gyroscope data from 30 subjects engaging in six activities of daily living (walking, sitting, standing, walking upstairs, walking downstairs, laying), collected using a Samsung Galaxy S II smartphone. 561 variables were reported for each observation, reflecting different elements of the captured motion. Some of those variables were summary statistics of the readings such as mean, standard deviation and kurtosis.

The goal of this project was to extract all observations of the variables that contain means and standard deviations, and aggregate them by activity and subject. The end product is a tidy data file that contains one row for each unique combination of activity and user, giving the mean of observations for each variable.
For example, there is one row for the mean results of subject 1 standing activity, one row for mean results of subject 2 standing activity, etc.

##Code book
Variables are written in camelCase as they are too long to be readable in all lowercase.

#activityName
The name of the activity the subject was engaging in for the given observations. This is a factor with six levels: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING.

#subjectId
Experiment subjects were numbered 1-30. This is a factor with 30 levels.

# meanTimeBodyAcceleration, stdevFrequencyBodyGyroscopeMagnitude, etc. (66 variables)
See features_info.txt included with the HAR dataset for technical definitions of each variable type.
These values are normalized so they do not have units.
Variables are named in the following format:
[statistic][domain][type of acceleration signal][instrument][measurement type(where applicable)][axis (where applicable)]
	statistic: mean or stdev (stdev denotes Standard Deviation)
	domain: time or frequency
	type of acceleration signal: body or gravity
	instrument: accelerometer or gyroscope
	measurement type (where applicable): jerk, magnitude, jerk magnitude
	axis (where applicable): X Y or Z

##Summary Choices
Data is summarized by mean of observations for activity and subject, which was given in the requirements for the project. 
I chose not to include mean frequency measurements (indicated in the raw data as meanFreq()). They were defined in features_info.txt as "Weighted average of the frequency components to obtain a mean frequency". I judged this to be redundant for the purpose of this analysis.

