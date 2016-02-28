###################################################
#Final project : getting data cleaned
#
##################################################
rm(list=ls())
library(plyr)
library(dplyr)
library(knitr)

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
temp1 <- tempfile()
download.file(url,temp1)
temp1 <- unzip(temp1)

##Merging the training and test data set to create one dataset
train_df <- read.table("./UCI HAR Dataset/train/X_train.txt")
names_train_df <- read.table("./UCI HAR Dataset/train/y_train.txt")
trained <- read.table("./UCI HAR Dataset/train/subject_train.txt")

#Getting test data
test_df <- read.table("./UCI HAR Dataset/test/X_test.txt")
names_test_df <- read.table("./UCI HAR Dataset/test/y_test.txt")
tested <- read.table("./UCI HAR Dataset/test/subject_test.txt")

#Merge training and test data
joined_df<- bind_rows(train_df, test_df)
joined_label <- bind_rows(names_train_df, names_test_df)
Joined_subj <- bind_rows(trained, tested)

##Extract measurements on the mean and standard deviation for each measurement
feature_df <- read.table("./UCI HAR Dataset/features.txt")
meanstd <- grep("-mean\\(\\)|-std\\(\\)", feature_df[,2])
joined_df_feat <- joined_df[, meanstd]

##Using descriptive activity names to name the activities in the data set
names(joined_df_feat) <-feature_df[meanstd, 2]
names(joined_df_feat) <- tolower(names(joined_df_feat)) 
names(joined_df_feat) <- gsub("\\(|\\)", "", names(joined_df_feat))

activity <- read.table('./UCI HAR Dataset/activity_labels.txt')
activity[, 2] <- tolower(as.character(activity[, 2]))
activity[, 2] <- gsub("_", "", activity[, 2])

##Appropriately labeling the data set with descriptive variable names
joined_label[, 1] <- activity[joined_label[, 1], 2]
names(joined_label) <- "activity"
names(Joined_subj) <- "subject"

#make a data frame with all the infos
performance <- bind_cols(joined_label,Joined_subj,joined_df)
write.table(performance,"performance.txt", row.names = FALSE)

##From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
mean_df <- aggregate(. ~subject + activity, performance, mean) %>% arrange(subject, activity)
write.table(mean_df, "average_tidy.txt", row.names = FALSE)
knit2html("C:/Users/edemd/Documents/COURSERA/getting_clean_data/week4/codebook.Rmd");
