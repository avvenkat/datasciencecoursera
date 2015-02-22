Introduction

The script run_analysis.R performs the 5 steps described in the course project's definition.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


Function - download.data() - Is used to download data from "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

Function - merge.datasets() - Merges the training and the test sets to create one data set.

Function - extract.mean.and.std() - Extracts only the measurements on the mean and standard deviation for each measurement.

Function - name.activities() - Uses descriptive activity names to name the activities in the data set

bind.data <- function(x, y, subjects) - bind.data is used to combine mean standard values, activities and subjects into one data frame

create.tidy.dataset - this is used to create the tidy data set
