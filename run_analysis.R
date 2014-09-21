## run_analysis.R - course project for Getting and Cleaning Data (Coursera)
# Creates a tidy data set with summary 

# Before running, extract the raw data package to the working directory
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

library(data.table)
library(reshape2)
library(dplyr)

#   Set paths for all relevant files
features_path <- "features.txt" #List of features (col names in X data)
activity_labels_path <- "activity_labels.txt" #Links the class labels (numbers in y data) with their activity name.
subject_train_path <- "train/subject_train.txt" #Identifies the subject who performed the activity
X_train_path <- "train/X_train.txt" #observations for train set
y_train_path <- "train/y_train.txt" #labels for train set
subject_test_path <- "test/subject_test.txt"
X_test_path <- "test/X_test.txt"
y_test_path <- "test/y_test.txt"
output_path <- "tidy_data.txt"

#   Read all relevant files into tables
features_table <- read.table(features_path,comment.char = "")
activity_labels_table <-read.table(activity_labels_path,comment.char = "",colClasses = "factor")
subject_train_table <- read.table(subject_train_path,comment.char = "",colClasses = "factor")
X_train_table <- read.table(X_train_path,comment.char = "",colClasses = "numeric")
y_train_table <- read.table(y_train_path,comment.char = "",colClasses = "factor")
subject_test_table <- read.table(subject_test_path,comment.char = "",colClasses = "factor")
X_test_table <- read.table(X_test_path,comment.char = "",colClasses = "numeric")
y_test_table <- read.table(y_test_path,comment.char = "",colClasses = "factor")

# add names to activity_labels table for merging later
names(activity_labels_table) <- c("activityId","activityName")

# create data tables for the test and train data
test_set <- data.table(X_test_table)
train_set <- data.table(X_train_table)

# Get a character vector of feature names from feature_names
feature_names<-as.character(unlist(features_table[2],use.names=FALSE))
# Fix feature names to satisfy the principles of good variable names:
#   - Not have underscores or dots or white spaces
#   - descriptive (replace abbrev with full words)
#   - Not duplicated

feature_names <- gsub("BodyBody","Body",feature_names)
feature_names <- gsub("(.*)-mean\\(\\)","mean\\1",feature_names)
feature_names <- gsub("(.*)-std\\(\\)","stdev\\1",feature_names)
feature_names <- gsub("fBody","FrequencyBody",feature_names)
feature_names <- gsub("tBody","TimeBody",feature_names)
feature_names <- gsub("tGravity","TimeGravity",feature_names)
feature_names <- gsub("Acc","Accelerometer",feature_names)
feature_names <- gsub("Gyro","Gyroscope",feature_names)
feature_names <- gsub("Mag","Magnitude",feature_names)
feature_names <- gsub("\\-","",feature_names)
feature_names <- gsub("\\.","",feature_names)

# Rename the variables in the data sets with the feature names. 
 setnames(test_set,old=feature_names)
 setnames(train_set,old=feature_names)

# add columns for subject (based on subject_... tables) and activity (based on
# y_...tables), and create a column that labels all rows with a set 'test' or
# 'train' based on the data set they are from
test_set$subjectId <- subject_test_table[1]
test_set$activityId <- y_test_table[1]

train_set$subjectId <- subject_train_table[1]
train_set$activityId <- y_train_table[1]


combined_set <- rbind(test_set,train_set)
# 2. Extracts only the measurements on the mean and standard deviation for each
# measurement. (Subset out the columns with feature names starting with 'mean and
# 'stdev')
combined_set <- select(combined_set,starts_with("mean"),starts_with("stdev"),subjectId,activityId)

# 3. Uses descriptive activity names to name the activities in the data set
combined_set <- left_join(x = combined_set,y = activity_labels_table,by = "activityId")

# 5. From the data set in step 4, creates a second, independent tidy data set
#   with the average of each variable for each activity and each subject.

#   fix the factor levels in the subject and activity columns
levels(combined_set$subjectId) <- as.character(sort(as.numeric(levels(combined_set$subjectId))))
levels(combined_set$activityName) <- activity_labels_table$activityName
#   sort the rows by activity and columns (using the factors fixed above)
combined_set <- arrange(combined_set,activityName,subjectId)
# Put the categorical tables on the far left, remove activity ID column as it
# has been replaced with activity name
combined_set <- select(combined_set,activityName,subjectId,starts_with("mean"),starts_with("stdev"))

# Define groups on activity and subject, for dplyr summary below
combined_set <- group_by(combined_set,activityName, subjectId)
# Create final data table with observations averaged for each combination of
# activity and subject.
combined_set_summaries <- summarise_each(combined_set,funs(mean))

# Write final (tidy) data table to file
write.table(combined_set_summaries,output_path,row.name=FALSE)
# Verify by opening and viewing 
View(read.table(output_path,header = TRUE))