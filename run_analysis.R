
setwd("C:/Users/e79309/Documents/Coursera_DataScience/3.CleanData/project")

## 1.Merges the training and the test sets to create one data set.
TrainSet <- read.table("./UCI HAR Dataset/train/X_train.txt")
head(TrainSet)
dim(TrainSet) # [1] 7352  561
TrainLabel <- read.table("./UCI HAR Dataset/train/y_train.txt")
TrainSubject <- read.table("./UCI HAR Dataset/train/subject_train.txt")

TestSet <- read.table("./UCI HAR Dataset/test/X_test.txt")
head(TestSet)
dim(TestSet) # [1] 2947  561
TestLabel <- read.table("./UCI HAR Dataset/test/y_test.txt")
TestSubject <- read.table("./UCI HAR Dataset/test/subject_test.txt")

Merge <- rbind(TrainSet, TestSet)
dim(Merge) # [1] 10299   561
MergeLabel <- rbind(TrainLabel, TestLabel)
MergeSubject <- rbind(TrainSubject, TestSubject)
Merge <- cbind(Merge, MergeLabel, MergeSubject)
colnames(Merge) <- c(colnames(Merge)[-(562:563)],"Label","Subject")

## 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
features <- read.table("./UCI HAR Dataset/features.txt")
head(features)
MeanStdNum <- grep("mean\\(\\)|std\\(\\)", features[,2])
MeanStdNum
MeanStdVec <- paste0("V", MeanStdNum) # match with the column names in Merge dataset
MeanStdVec
subset <- Merge[, c(MeanStdVec,"Label","Subject")]
dim(subset) # [1] 10299    68
colname <- as.vector(features[MeanStdNum, 2])
names(subset) <- c(colname,"Label","Subject")
head(subset)

## 3.Uses descriptive activity names to name the activities in the data set
activity <- read.table("./UCI HAR Dataset/activity_labels.txt")
activity
names(activity) <- c("Label","Activity")
subset <- merge(subset, activity, by="Label")
head(subset)

## 4.Appropriately labels the data set with descriptive variable names. 
names(subset) <- gsub("\\(\\)","",names(subset))
names(subset) <- gsub("-","",names(subset))
names(subset) <- gsub("mean","Mean",names(subset))
names(subset) <- gsub("std","Std",names(subset))
names(subset)
dim(subset) # [1] 10299    69
write.table(subset, "df1.txt")

## 5.From the data set in step 4, creates a second, independent tidy data set 
##   with the average of each variable for each activity and each subject.
library(reshape2)
subsetMelt <- melt(subset[,-1], id=c("Subject","Activity")) # remove column "Label", 
# so the data frame is left with two key variables "Activity" and "Subject", and the mean/std related variables
head(subsetMelt)
dim(subsetMelt)

library(dplyr)
df2 <- subsetMelt %>% group_by(Subject,Activity) %>% summarize(Avg = mean(value))
df2
write.table(df2, "tidy.txt")
