# Getting and Cleaning Data Course Project

## Step 0: download and upzip zip files
getwd()
setwd("./Course Project")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./dataset.zip")
unzip(zipfile = "./dataset.zip")

## Step 1: merges the training and the test sets to create one data set

### Read data
xtrain<- read.table("UCI HAR Dataset/train/X_train.txt")
ytrain<- read.table("UCI HAR Dataset/train/Y_train.txt")
subjecttrain <-read.table("UCI HAR Dataset/train/subject_train.txt")

xtest<- read.table("UCI HAR Dataset/test/X_test.txt")
ytest<- read.table("UCI HAR Dataset/test/Y_test.txt")
subjecttest <-read.table("UCI HAR Dataset/test/subject_test.txt")

features<-read.table("UCI HAR Dataset/features.txt")
activity<-read.table("UCI HAR Dataset/activity_labels.txt")

dim(xtrain)
dim(ytrain)
dim(xtest)
dim(ytest)
dim(subjecttrain)
dim(subjecttest)
dim(features)
dim(activity)

### merge train, test and subject data
x<-rbind(xtrain, xtest)
y<-rbind(ytrain, ytest)
subject<-rbind(subjecttrain, subjecttest)
z<-cbind(x, y, subject)
dim(x)
dim(y)
dim(subject)
dim(z)

## Step 2: extracts only the measurements on the mean and standard deviation for each measurement
locator <- grep("mean\\(\\)|std\\(\\)", features[,2]) 
locator
length(locator)
x <- x[,locator]
dim(x)

## Step 3: uses descriptive activity names to name the activities in the data set
y$activity_name <- activity[y[,1] ,2] #look up y[,1] in activity [,2]
head(y)

## Step 4: appropriately labels the data set with descriptive variable names
xcolnames <- features[locator,2]
names(x) <- xcolnames
names(subject) <- "subject_id"
names(y) <- c("activity_label", "activity_name")
cleandata <- cbind(subject, y, x)
colnames(cleandata)
head(cleandata)

## Step 5: from the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
library(dplyr)
class(cleandata)
cleandata_2 <- data.table(cleandata)
colnames(cleandata_2)
tidydata <- ddply(cleandata_2, c("subject_id","activity_name"), numcolwise(mean))
head(tidydata)
dim(tidydata)
write.table(tidydata, file = "./tidydata.txt", row.name=FALSE)

