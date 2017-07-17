#Include reshape2 library
library(reshape2)

#Download and unzip the data
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", dest="dataset.zip", mode="wb")
unzip("dataset.zip")
setwd("UCI HAR Dataset")

#Read the data sets
test<-read.table("test/X_test.txt")
train<-read.table("train/X_train.txt")

#Read the subject vector for each data set
subject_test<-read.table("test/subject_test.txt", col.names = "Subject")
subject_train<-read.table("train/subject_train.txt", col.names = "Subject")

#Read the activity vector for each data set
activity_test<-read.table("test/y_test.txt", col.names = "Activity")
activity_train<-read.table("train/y_train.txt", col.names = "Activity")

#Set variable names to feature names in both data sets
features<-read.table("features.txt")
colnames(test)<-features[,2]
colnames(train)<-features[,2]

#Add Subject and Activity vectors as columns
test_all<-cbind(subject_test, activity_test, test)
train_all<-cbind(subject_train, activity_train, train)

#Merge the data sets
dataset<-rbind(test_all, train_all)

#Add descriptive activity names
activities<-read.table("activity_labels.txt")
dataset$Activity<-factor(dataset$Activity, labels = activities[,2])

#Select only mean() and std() for each measurement
match<-grep("mean\\(\\)|std\\(\\)", colnames(dataset), value = TRUE)
dataset<-dataset[,c("Subject", "Activity", match)]

#Make variable names descriptive:

#Time and frequency variables are specified in the code book
colnames(dataset)<-gsub("^t","", colnames(dataset))
colnames(dataset)<-gsub("^f","FFT", colnames(dataset))

#Variable characteristics and names are expanded. "Body" is removed and is assumed wherever there is no "Gravity".
patterns<-c("Body", "Gravity", "Acc", "Gyro", "Jerk", "Mag")
names<-c("", "Gravity", "Acceleration", "AngularVelocity", "Jerk", "Magnitude")
for (i in 1:length(patterns)){
  colnames(dataset)<-gsub(patterns[i], names[i], colnames(dataset))
}

#Functions and axes retain their names, underscores are less ambiguous than dashes
patterns<-c("-mean\\(\\)", "-std\\(\\)", "-X", "-Y", "-Z")
names<-c("_mean", "_std", "_X", "_Y", "_Z")
for (i in 1:length(patterns)){
  colnames(dataset)<-gsub(patterns[i], names[i], colnames(dataset))
}

#Create an independent tidy data set with the average of each variable for each activity and each subject
melted<-melt(dataset, id=c("Activity", "Subject"), measure.vars=colnames(dataset)[-(1:2)])
tidy<-dcast(melted, Activity+Subject~variable, mean)

#Write the tidy dataset to a file
write.table(tidy, "tidy.csv", sep=",", row.names=FALSE)