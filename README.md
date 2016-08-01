# datacleaningassign4
Assignment 4 for data cleaning course

# run_analysis.R code does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Labels the data set with descriptive activity names.
5. Creates a second, independent tidy .csv data set with the average of each variable for each activity and each subject.

The flow of the soluion is as follows:

1. if the data is not present on local drive, Download the dataset  
2. rbind two data files to achieve the first goal. The result is stored in X_test_train 
2. Then subset the dataset using only std and mean features to get the second answer. The result is stored in meanandstd
3. Load the activity labels and replace indices with names. This will solve problem 3.
4 Combines the labels and the data set using cbind; doing that for both meanandstd and X_test_train. This will provide answer to question 4
5. Using the X_test_train, calculate aggregate using mean for averaging, averaging over activity and subject, and then save the result to a .csv file thus get the result for fifth question
