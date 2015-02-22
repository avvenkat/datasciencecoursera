# Human Activity Recognition database built from the recordings of 30 subjects 
# performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.
# This R script runanalysis.R performe the following --
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


# This function is used to download the data
download.data = function() {
        # download the data
        fileURL <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileURL, destfile="data/UCI_HAR_data.zip")
        unzip("data/UCI_HAR_data.zip", exdir="data")
}

# This function is used to merge the data sets
# Merges the training and the test sets to create one data set.
merge.datasets = function() {
    training.x <- read.table("data/UCI HAR Dataset/train/X_train.txt")
    training.y <- read.table("data/UCI HAR Dataset/train/y_train.txt")
    training.subject <- read.table("data/UCI HAR Dataset/train/subject_train.txt")
    tocombine.x <- read.table("data/UCI HAR Dataset/test/X_test.txt")
    tocombine.y <- read.table("data/UCI HAR Dataset/test/y_test.txt")
    test.subject <- read.table("data/UCI HAR Dataset/test/subject_test.txt")

    merged.x <- rbind(training.x, tocombine.x)
    merged.y <- rbind(training.y, tocombine.y)
    merged.subject <- rbind(training.subject, test.subject)
    # merge train and test datasets and return
    list(x=merged.x, y=merged.y, subject=merged.subject)
}


# Extracts only the measurements on the mean and standard deviation for each measurement.

extract.mean.and.std = function(df) {

    features <- read.table("data/UCI HAR Dataset/features.txt")
    mean.col <- sapply(features[,2], function(x) grepl("mean()", x, fixed=T))
    std.col <- sapply(features[,2], function(x) grepl("std()", x, fixed=T))
    var1 <- df[, (mean.col | std.col)]
    colnames(var1) <- features[(mean.col | std.col), 2]
    var1
}

# Uses descriptive activity names to name the activities in the data set
name.activities = function(df) {
    colnames(df) <- "activity"
    df$activity[df$activity == 1] = "WALKING"
    df$activity[df$activity == 2] = "WALKING_UPSTAIRS"
    df$activity[df$activity == 3] = "WALKING_DOWNSTAIRS"
    df$activity[df$activity == 4] = "SITTING"
    df$activity[df$activity == 5] = "STANDING"
    df$activity[df$activity == 6] = "LAYING"
    df
}

bind.data <- function(x, y, subjects) {
    # Combine mean-std values (x), activities (y) and subjects into one data
    # frame.
    cbind(x, y, subjects)
}

create.tidy.dataset = function(df) {
    # Given X values, y values and subjects, create an independent tidy dataset
    # with the average of each variable for each activity and each subject.
    tidy <- ddply(df, .(subject, activity), function(x) colMeans(x[,1:60]))
    tidy
}

clean.data = function() {
    # Download data
    download.data()
    # merge training and test datasets. merge.datasets function returns a list
    # of three dataframes: X, y, and subject
    merged <- merge.datasets()
    # Extract only the measurements of the mean and standard deviation for each
    # measurement
    cx <- extract.mean.and.std(merged$x)
    # Name activities
    cy <- name.activities(merged$y)
    # Use descriptive column name for subjects
    colnames(merged$subject) <- c("subject")
    # Combine data frames into one
    combined <- bind.data(cx, cy, merged$subject)
    # Create tidy dataset
    tidy <- create.tidy.dataset(combined)
    # Write tidy dataset as csv
    write.csv(tidy, "UCI_HAR_tidy.csv", row.names=FALSE)
    # Write tidy dataset as text
    write.table(tidy, "UCI_HAR_tidy.txt", row.names=FALSE)
}