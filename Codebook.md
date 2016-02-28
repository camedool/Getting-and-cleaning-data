#Codebook
The Codebook gives on overview of the variables in **tidy_dataset.txt** file - the output dataset from run_analysis.R script.

####Raw data
The raw data for this project is accelerometer data collected from the Samsung Galaxy S smartphone, and was provided at the links below:

+ Data file: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
+ CodeBook: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

This data included both the raw sampled data (folder ../Inertial Signals) and features. In this project only features are examined.

There are 3 types of files:

1. x: rows of feature measurements
2. y: the activity labels corresponding to each row of X. Encoded as numbers.
3. subject: the subjects on which each row of X was measured. Encoded as numbers.

####Identifiers
+ **subject** - the ID of the subject. Overall 30 subjects.
+ **activity** - the type of activity performed when the measurement was performed. Overall 6 activities.
  
####Activity labels
+ 1 - WALKING - subject was walking during the test.
+ 2 - WALKING_UPSTAIRS - subject was walking up a staircase during the test.
+ 3 - WALKING_DOWNSTAIRS - subject was walking down a staircase during the test.
+ 4 - SITTING - subject was sitting during the test.
+ 5 - STANDING - subject was standing during the test.
+ 6 - LAYING - subject was laying during the test.

####Script performance (run_analysis.R)
1. Download the data from source and save in source directory "Getting and cleaning data" in working directory. If such directory doesn't exist, it creates.
2. Unzip the file (download.zip) in that directory.
3. Creates 2 dataframes (*activityLabels* and *features*) which are taken from *activity_labels.txt* and *features.txt*.
4. Subsets the *features* with only mean and standart deviation and saving the result as *meanSDfeature*.
  * Creates the dataframe *meanSDfeature_names* - which contains only the variable names from the *features*.
  * Replaces "mean" as "Mean" and "std" as "Std" in *meanSDfeature_names*.
  * Removes "-" in *meanSDfeature_names*.
5. Loads the file *X_train.txt* as dataframe *train*.
  * Creates dataframe *trainActivities* by loading file *Y_train.txt*.
  * Creates dataframe *trainSubjects* by loading file *subject_train.txt*.
  * Binds all those 3 dataframes into one in the following order: train = trainSubjects + trainActivities + train.
6. Loads the file *X_test.txt* as vector *test*.
  * Creates dataframe *testActivities* by loading file *Y_test.txt*.
  * Creates dataframe *testSubjects* by loading file *subject_test.txt*.
  * Binds all those 3 dataframes into one in the following order: test = testSubjects + testActivities + test.
7. Merges dataframes *train* and *test* with variable names as *subjet*, *activity* and *meanSDfeature_names*. 
  * Merged dataframe saved as *mergedData*.
8. Creates factors as *subject* and *activity* in dataframe *mergedData*.
9. Melts the data in dataframe *mergedData* with id *subject* and *activity*. Results saved as *mergedData_melted*. (This is to  calculate the mean for each variable in easy way).
  * Calculates the mean for each variable and reverts back from long format to wide format. Result saved as *mergedData_mean*. 
10. Copies the data as output tidy dataset - tidy_dataset.txt.
11. Gives the final message to indicate whether script run successfully or not.
