
#Setting working directory, downloading and unzipping data.

    setwd("C:/Users/User/Desktop/Cabinet/Career/Data Analysis/R/Coursera/3) Getting and cleaning data/Assignment")
    
    fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        
    if(!file.exists("UCI HAR Dataset.zip")){
    download.file(url = fileurl, destfile = "UCI HAR Dataset.zip")}
    
    if(!file.exists("UCI HAR Dataset")){
    unzip(zipfile = "UCI HAR Dataset.zip")}

    setwd("./UCI HAR Dataset")
    
    
#Reading tables

    train <- read.table("train/X_train.txt")
    trainlbls <- read.table("train/y_train.txt")
    test <- read.table("test/X_test.txt")
    testlbls <- read.table("test/y_test.txt")
    features <- read.table("features.txt")
    subject_test <- read.table("test/subject_test.txt")
    subject_train <- read.table("train/subject_train.txt")
    

#1) Merges the training and the test sets to create one data set.

    #Adding the column and row labels
    names(train) <- t(features[2])
    names(test) <- t(features[2])
    train1 <-cbind(subject_train, trainlbls, train)
    test1 <- cbind(subject_test, testlbls, test)
    
    names(train1)[c(1, 2)] <- c("subject", "activity")
    names(test1)[c(1, 2)] <- c("subject", "activity")
    
    MD <- rbind(test1, train1)
    MD[c(1:5, (nrow(MD)-5):nrow(MD)), 1:5]
    

#2) Extracts only the measurements on the mean and standard deviation for each measurement.

    colnames(MD)[1:50]
    a <- grep("mean\\(\\)|std\\(\\)", features[,2], value=FALSE)
    b <- c(1, 2, a+2)
    
    MD1 <- MD[, b]
    MD1[1:7, 1:5]

    
#3) Uses descriptive activity names to name the activities in the data set

    MD1[MD1[2] == 1, 2] <- "Walking"
    MD1[MD1[2] == 2, 2] <- "Walking upstairs"
    MD1[MD1[2] == 3, 2] <- "Walking downstairs"
    MD1[MD1[2] == 4, 2] <- "Sitting"
    MD1[MD1[2] == 5, 2] <- "Standing"
    MD1[MD1[2] == 6, 2] <- "Laying"

    
#4) Appropriately labels the data set with descriptive variable names.

    names(MD1) <- gsub("\\(|\\)", "", names(MD1))
    names(MD1) <- gsub("Acc", "Acceleration", names(MD1))
    names(MD1) <- gsub("Gyro", "Gyroscope", names(MD1))
    names(MD1) <- gsub("Mag", "Magnitude", names(MD1))
    names(MD1) <- gsub("std", "STD", names(MD1))
    names(MD1) <- gsub("mean", "MEAN", names(MD1))
    names(MD1) <- gsub("^t", "time", names(MD1))
    names(MD1) <- gsub("^f", "frequency", names(MD1))
    names(MD1) <- gsub("BodyBody", "Body", names(MD1))


#5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
   
    library(plyr)
    MD2 <- ddply(MD1, c("subject","activity"), numcolwise(mean))
    
    write.table(MD2,file="tidydata.txt")
