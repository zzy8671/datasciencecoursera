---
title: "Prediction Assignment Writeup"
author: "Zhiyi Zhang"
date: "October 22, 2018"
output: html_document
---
## Background
Using devices such as Jawbone Up, Nike FuelBand, and Fitbit it is now possible to collect a large amount of data about personal activity relatively inexpensively. These type of devices are part of the quantified self movement - a group of enthusiasts who take measurements about themselves regularly to improve their health, to find patterns in their behavior, or because they are tech geeks. One thing that people regularly do is quantify how much of a particular activity they do, but they rarely quantify how well they do it. In this project, your goal will be to use data from accelerometers on the belt, forearm, arm, and dumbell of 6 participants. They were asked to perform barbell lifts correctly and incorrectly in 5 different ways.

## What you should submit
The goal of your project is to predict the manner in which they did the exercise. This is the "classe" variable in the training set. You may use any of the other variables to predict with. You should create a report describing how you built your model, how you used cross validation, what you think the expected out of sample error is, and why you made the choices you did. You will also use your prediction model to predict 20 different test cases.

## 0. Loading necessary packages
```{r}
library(caret); library(rattle); library(rpart); library(randomForest); 
```


## 1. Data cleaning and preprocessing
```{r}
### 1.1 Data cleaning
getwd()
training <- read.csv("./pml-training.csv", na.string = c("NA", "#DIV/0!", ""))
testing <- read.csv("./pml-testing.csv", na.string = c("NA", "#DIV/0!", ""))
training <- training[ ,colSums(is.na(training))==0]
testing <- testing[ ,colSums(is.na(training))==0]
names(training)
training <- training[,-c(1:7)]
testing <- testing[,-c(1:7)]

### 1.2 Data partition by training and validation (test data is in a separate .csv file)
set.seed(3523)
inTrain <- createDataPartition(y=training$classe, p=0.7, list=FALSE)
training <- training[inTrain,]
validation <- training[-inTrain,]

### 1.3 Quick histogram view by classe (prediction variable)
plot(training$classe, xlab = "classe", ylab = "Frequency", main = "Prediction variable classe by frequency")
```

## 2. Prediction using Decision Tree and Random Forest
```{r}
### 2.1 Decision Tree
set.seed(33833)
mod_dt <- rpart(classe ~., data=training, method = "class")
pred_dt <- predict(mod_dt, validation, type="class")
confusionMatrix(pred_dt, validation$classe)
fancyRpartPlot(mod_dt)

### 2.2 Random Forest
set.seed(33833)
mod_rf <- randomForest(classe ~., data=training, method = "class")
pred_rf <- predict(mod_rf, validation, type = "class")
confusionMatrix(pred_rf, validation$classe)
```

## 3. Conclusion
Random Forest algorithm is more accurate than Decision Trees. Accuracy for Random Forest model is equal/close to 100% (95% CI: (0.99, 1)) compared to Decision Tree model with ~75% (95% CI: (0.75, 0.77)). The out-of-sample error is estimated to be slightly higher than in-sample error which is close to 0%. 

## 4. Course Project Projection
```{r}
pred_test <- predict(mod_rf, testing, type = "class")
pred_test
```