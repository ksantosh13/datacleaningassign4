
## run_analysis.R
## This code performs data analysis on data collected from the accelerometers
## from the Samsung Galaxy S smartphone.

## Create a directory data if does not exist and then download and unzip the file
if(!file.exists("./data")){
    dir.create("./data")   ## create directory
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileUrl,destfile="./data/Dataset.zip",method="curl") ## download the file
    unzip(zipfile="./data/Dataset.zip",exdir="./data") ## unzip the file
}

## read the X_test and X_train file and then merge into a single data set
X_test  <- read.table("./data/UCI HAR Dataset/test/X_test.txt", col.names=features[,2])
X_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt", col.names=features[,2])
features <- read.table("./data/UCI HAR Dataset/features.txt",head=FALSE)

X_test_train <- rbind(X_test,X_train)  ## merge the data

## Find the index from feature table and use it to extracts only the measurements 
## on the mean and standard deviation for each measurement. 
meanandstddevfeatures <- features[grep("(mean|std)\\(", features[,2]),]
meanandstddev <- X_test_train[,meanandstddevfeatures[,1]]

# Using descriptive activity names to name the activities in the data set
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt", col.names = c('activity'))
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt", col.names = c('activity'))
y_test_train <- rbind(y_test, y_train)
    

labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
for (i in 1:nrow(labels)) {
    code <- as.numeric(labels[i, 1])
    name <- as.character(labels[i, 2])
    y_test_train[y_test_train$activity == code, ] <- name
}

## Now labels the data set with descriptive activity names. 
X_with_labels <- cbind(y_test_train, X_test_train)
meanandstd_with_labels <- cbind(y_test_train, meanandstddev)

# Creates a second, independent tidy data set with the average of each variable 
# for each activity and each subject.
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", col.names = c('subject'))
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", col.names = c('subject'))
subject_test_train <- rbind(subject_test, subject_train)
averages <- aggregate(X_test_train, by = list(activity = y_test_train[,1], subject = subject_test_train[,1]), mean)

write.csv(averages, file='data/result.txt', row.names=FALSE) ## write the file
