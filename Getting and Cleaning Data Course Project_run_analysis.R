## 1. Merge the training and the test sets to create one data set.

## step 1: download zip file from website
if(!file.exists("./data")) dir.create("./data")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/projectData_getCleanData.zip")

## step 2: unzip data
unzip <- unzip("./data/projectData_getCleanData.zip")

## step 3: load data into R
train data
train.x <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
train.y <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
train.subject <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

test data
test.x <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
test.y <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
test.subject <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

## step 4: merge train and test data
trainData <- cbind(train.subject, train.y, train.x)
testData <- cbind(test.subject, test.y, test.x)
fullData <- rbind(trainData, testData)

--------------------------------------------------------------------------------
## 2. Extract only the measurements on the mean and standard deviation for each measurement. 

## step 1:  extract mean and standard deviation of each measurements
featureIndex <- grep(("mean\\(\\)|std\\(\\)"), features[,2])
final <- fullData[, c(1, 2, featureIndex+2)]
colnames(final) <- c("subject", "activity", featureName[featureIndex])

-------------------------------------------------------------------------------
## 3. Uses descriptive activity names to name the activities in the data set

## step 1: load activity data into R
activityName <- read.table("./data/UCI HAR Dataset/activity_labels.txt")

## step 2: replace 1 to 6 with activity names
final$activity <- factor(final$activity, levels = activityName[,1], labels = activityName[,2])

-------------------------------------------------------------------------------
## 4. Appropriately labels the data set with descriptive variable names.

## step 1:
names(final) <- gsub("^t", "time", names(final))
names(final) <- gsub("^f", "frequence", names(final))
names(final) <- gsub("-mean", "Mean", names(final))
names(final) <- gsub("-std", "Std", names(final))

-------------------------------------------------------------------------------
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##step 1:
CleanedData<-data.table(final)
TidyData <- CleanedData[, lapply(.SD, mean), by = 'subject, activity']

write.table(TidyData, file = "Tidy.txt", row.names = FALSE)
