##Script for the getting the data for wearable devices and tidying. 

library(reshape2)

#1. Downloading the data
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
sourceDir <- "./Getting and cleaning data"
unzipDir <-paste(sourceDir, c("/UCI HAR Dataset"), sep = "", collapse = NULL)
filename <-  paste(sourceDir, c("/dataset.zip"), collapse = NULL, sep ="")

if (!file.exists(filename)){
    if(!dir.exists(sourceDir)) {
            dir.create(sourceDir)
    }
        download.file(fileUrl, filename)
        }
#2. Unzip the downloaded file
if (!dir.exists(unzipDir)){
        unzip(zipfile = filename, exdir = sourceDir)
        }

#3. Getting the label of downoaded data
activityLabels <- read.table(paste(unzipDir, c("/activity_labels.txt"), sep = "", collapse = NULL))
activityLabels[,2] <- as.character(activityLabel[,2])
features <- read.table(paste(unzipDir, c("/features.txt"), collapse = NULL, sep = ""))
features[,2] <- as.character(features[,2])

#4. Creating vectors from features with only the data for mean and standard deviation
meanSDfeature <- grep(".*mean.*|.*std.*", features[,2])
meanSDfeature_names <- features[meanSDfeature,2]
meanSDfeature_names = gsub('-mean', 'Mean', meanSDfeature_names)
meanSDfeature_names = gsub('-std', 'Std', meanSDfeature_names)
meanSDfeature_names <- gsub('[-()]', '', meanSDfeature_names)

#5. Load the datasets (train)
train <- read.table(paste(unzipDir, c("/train/X_train.txt"), sep ="", collapse = NULL))[meanSDfeature]
trainActivities <- read.table(paste(unzipDir, c("/train/Y_train.txt"), sep ="", collapse = NULL))
trainSubjects <- read.table(paste(unzipDir, c("/train/subject_train.txt"), sep = "", collapse = NULL))
train <- cbind(trainSubjects, trainActivities, train)

#6. Load the datasets (test)
test <- read.table(paste(unzipDir, c("/test/X_test.txt"), collapse = NULL, sep =""))[meanSDfeature]
testActivities <- read.table(paste(unzipDir, c("/test/Y_test.txt"), collapse = NULL, sep =""))
testSubjects <- read.table(paste(unzipDir, c("/test/subject_test.txt"), collapse = NULL, sep =""))
test <- cbind(testSubjects, testActivities, test)

#7. Merging datasets(train + test)
mergedData <- rbind(train, test)
colnames(mergedData) <- c("subject", "activity", meanSDfeature_names)

#8. Creating factors as subject and activity
mergedData$activity <- factor(mergedData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
mergedData$subject <- as.factor(mergedData$subject)

#9. Melting the data to calculate the mean for each variable and reverting back (making the long melted data again wide)
mergedData_melted <- melt(mergedData, id = c("subject", "activity"))
mergedData_mean <- dcast(mergedData_melted, subject + activity ~ variable, mean)

#10. Copying the data
write.table(mergedData_mean, file = paste(sourceDir, c("/tidy_dataset.txt"), collapse = NULL, sep = ""), row.names = FALSE, quote = FALSE)

#11. Final message
if (file.exists(paste(sourceDir, c("/tidy_dataset.txt"), collapse = NULL, sep = ""))) {
        print("The analysis has run successfully. Please examine the output file: tidy_dataset.txt")
        } else {print("Ooups, something went wrong...")}