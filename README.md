Getting and Cleaning Data Course Project

The assignment is as follows:

"The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected. 
"Here are the data for the project: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

"You should create one R script called run_analysis.R that does the following:
1.Merges the training and the test sets to create one data set.
2.Extracts only the measurements on the mean and standard deviation for each measurement. 
3.Uses descriptive activity names to name the activities in the data set
4.Appropriately labels the data set with descriptive variable names. 
5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject."

Description of Analysis

The project uses only one R script,  run_data_analysis.R .
This script first checks for the existence of the dataset in the working directory; if it can't find the data, it downloads a copy.

Given that the data necessary to create the tidy data set specified in step 5 above is located across multiple text files, the script reads in each file as a separate data frame. These text files are:
• activity_labels.txt  – Links the activity labels with their activity name.
• features.txt  – List of all features (such as means and standard deviations of measurements).
• test/subject_test.txt  – Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
• test/X_test.txt  – Test set, with each column being a feature and each row being a measurement
• test/y_test.txt  – Test activity labels
• train/subject_text.txt  – Same as  test/subject_test.txt , but for the training set
• train/X_train.txt  – Training set, with each column being a feature and each row being a measurement
• train/y_train.txt  – Training activity labels

Once the above data has been loaded into R, we can row-bind the related testing and training data subsets, leaving us with three data frames: subjects, activities, and feature data (we also create a factor that identifies which obseverations are testing and which are training – while not necessary to procure the desired tidy data set, it could be useful to keep track of this information should the project be continued).

Before combining our data subsets into a single dataset, the script extracts the feature data columns for only mean and standard deviation-related features. These variables are then renamed to improve readability. For further detail on the extracted features, please see  CodeBook.md .

Now that the data subsets have been tidied up, they are column-bound into a single data frame called  dataset .

With all the necessary information cleaned up and stored in one location, it is simply a matter of grouping and summarizing to obtain the average of each variable for each activity and each subject. First, we factorize the subject column, as this data is categorical, not quantitative. Next, we replace the activity ids with the activity labels. Finally, we use  ddply()  to group the dataset by subject and activity while obtaining the averages of every feature in the dataset.

