# Human Activity Recognition Using Smartphones
Course project for "Getting and Cleaning Data" on Coursera 

This project uses the ["Human Activity Recognition Using Smartphones" data set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) to prepare a tidy data for later analysis in accordance with the following guidelines:

 - The training and the test sets are merged into a single data set
 - Only the measurements on the mean and standard deviation for each measurement
 - Activities and measurements are named in a descriptive manner
 - An independent tidy data set is created with the averages of each variable for each activity and each subject.
 
 All the processing is performed by run_analysis.R, which downloads and unzips the data, and exports the new tidy dataset to a csv file in the dataset folder.
 
 **Please set the working directory to the run_analysis.R source file location when running the script.**
