# Getting-and-cleaning-data
Course project for Coursera project "Getting and Cleaning Data"

The repository contains of files:
  1. README.md - high level description of repo and files.
  2. run_analysis.R - script with the instruction how to get the data and clean it.
  3. Codebook.md - code book with all variables.
  4. tidy_dataset.txt - the tidy output dataset.
  
--------------------------------------------------
#####run_analysis.R does the following things:

1. Downloads the data from the source and saves as download.zip 
2. Creates a direcrtory "Getting and cleaning data" in working dorectory, if it's not yet created and unzip the downloaded file in that directory.
3. Gets the activity labels and features and saves as vectors: activityLabels, features.
4. Subsets vector features  with only the data for mean and standard deviation.
5. Loads the datasets (train)
6. Loads the datasets (test)
7. Merges datasets(train + test)
8. Creates factors as subject and activity
9. Melts the data to calculate the mean for each variable and reverting back (making the long melted data again wide)
10. Copies the data as output tidy dataset - tidy_dataset.txt. 
11. Gives the final message to indicate whether script run successfully or not.




