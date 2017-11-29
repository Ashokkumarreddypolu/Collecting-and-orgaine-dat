
#downloading and perform unzip
#z='D:/Data science/Cleaning data/dataset.zip'
#download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",z) 
#unzip("D:/Data science/Cleaning data/dataset.zip",exdir = "D:/Data science/Cleaning data")

#reading testing data
X_test <- read.table("D:/Data science/Cleaning data/UCI HAR Dataset/test/X_test.txt", quote="\"", comment.char="", stringsAsFactors=FALSE)
Y_test <- read.table("D:/Data science/Cleaning data/UCI HAR Dataset/test/Y_test.txt", quote="\"", comment.char="", stringsAsFactors=FALSE)
Subject_test <- read.table("D:/Data science/Cleaning data/UCI HAR Dataset/test/Subject_test.txt", quote="\"", comment.char="", stringsAsFactors=FALSE)
Subject=subject_test$V1
activity<-Y_test$V1
test=X_test
test$activity=activity
test$Subject=Subject
#reading traing data
X_train <- read.table("D:/Data science/Cleaning data/UCI HAR Dataset/train/X_train.txt", quote="\"", comment.char="", stringsAsFactors=FALSE)
Y_train <- read.table("D:/Data science/Cleaning data/UCI HAR Dataset/train/Y_train.txt", quote="\"", comment.char="", stringsAsFactors=FALSE)
Subject_train <- read.table("D:/Data science/Cleaning data/UCI HAR Dataset/Subject_train.txt", quote="\"", comment.char="", stringsAsFactors=FALSE)
Subject=Subject_train$V1
activity<-Y_train$V1
train=X_train
train$activity=activity
train$Subject=Subject


#1.Merges the training and the test sets to create one data set.
final=rbind(test,train)
#reading feature description
features <- read.table("D:/Data science/Cleaning data/UCI HAR Dataset/features.txt", quote="\"", comment.char="", stringsAsFactors=FALSE)
#renaem column names features name
colnames(final)<-features$V2
colnames(final)[562:563]=c("activity","Subject")

#extraction mean and std of each measurement
x=c(grep('mean',names(final)),grep('std',names(final)),c(562,563))
final1=final[,x]
#labeling Activity

final1$activity=factor(final$activity,levels=activity_labels$V1,labels =activity_labels$V2 )

stand=aggregate(final1[, 1:79], list(final1$activity,final$Subject), sd)
mean=aggregate(final1[, 1:79], list(final1$activity,final$Subject), mean)
colnames(mean)=paste("mean_",colnames(mean))
colnames(mean)[1:2]=c("Activity","Subject")

colnames(stand)=paste("sd_",colnames(stand))
colnames(stand)[1:2]=c("Activity","Subject")

tidydatset=merge(mean,stand,by=c("Activity","Subject"))

rite.csv(tidydatset,file='D:/Data science/Cleaning data/tidy_data_set.txt')



