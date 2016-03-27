library(plyr)
library(dplyr)

if (!file.exists("UCI HAR Dataset/")) {
  fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  temp = tempfile()
  download.file(fileUrl, temp)
  unzip(temp)
  unlink(temp)
}

activity_labels    = read.table("UCI HAR Dataset/activity_labels.txt")[,2]
features           = read.table("UCI HAR Dataset/features.txt")[,2]
subject_test       = read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "Subject")
feature_data_test  = read.table("UCI HAR Dataset/test/X_test.txt", col.names = features)
activity_test      = read.table("UCI HAR Dataset/test/y_test.txt", col.names = "Activity")
subject_train      = read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "Subject")
feature_data_train = read.table("UCI HAR Dataset/train/X_train.txt", col.names = features)
activity_train     = read.table("UCI HAR Dataset/train/y_train.txt", col.names = "Activity")

subject = rbind(subject_train, subject_test)
activity = rbind(activity_train, activity_test)
observationType = factor(c(rep("TRAIN", nrow(feature_data_train)), rep("TEST", nrow(feature_data_test))))
feature_data = rbind(feature_data_train, feature_data_test)

mean_and_std_features = which(grepl("(mean\\(\\)|std\\(\\))", features))
feature_data = feature_data[,mean_and_std_features]
colnames(feature_data)  = gsub("\\.\\.","",names(feature_data))

dataset = cbind(subject, activity, observationType, feature_data)

dataset$Subject = factor(dataset$Subject)
dataset$Activity = activity_labels[dataset$Activity]

result_summary = ddply(dataset, .(Subject, Activity), numcolwise(mean))

write.table(result_summary, "result_summary.txt", row.names = FALSE)
