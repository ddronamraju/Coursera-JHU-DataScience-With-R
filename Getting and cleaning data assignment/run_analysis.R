library(data.table)
library(dplyr)

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", temp)
unzip(temp)

x_test<-fread("UCI HAR Dataset//test//X_test.txt")
y_test<-fread("UCI HAR Dataset//test//y_test.txt")
x_train<-fread("UCI HAR Dataset//train//X_train.txt")
y_train<-fread("UCI HAR Dataset//train//y_train.txt")
#phone_data <- fread(unzip(temp),lis)
rm(temp)

#1.Merges the training and the test sets to create one data set.
x_dt<-rbindlist(list(x_train,x_test))
y_dt<-rbindlist(list(y_train,y_test))

#2.Extracts only the measurements on the mean and standard deviation for each measurement.

#Read features
feat_dt<-fread("UCI HAR Dataset//features.txt")

#Find columns of interest only
feature_names<-feat_dt[,V2]
feature_names<-tolower(feature_names)
feat_wanted<-grep("mean|std",feature_names)
x_dt_wanted<-x_dt[,feat_wanted,with=FALSE]

#4. Appropriately labels the data set with descriptive variable names.

setnames(x_dt_wanted, feat_dt[feat_wanted,V2])

#3.Uses descriptive activity names to name the activities in the data set

#Add activity to the x_dt
x_dt_wanted<-x_dt_wanted[,Activity:=y_dt$V1]
x_dt_wanted$Activity<-gsub(1,"WALKING",x_dt_wanted$Activity)
x_dt_wanted$Activity<-gsub(2,"WALKING_UPSTAIRS",x_dt_wanted$Activity)
x_dt_wanted$Activity<-gsub(3,"WALKING_DOWNSTAIRS",x_dt_wanted$Activity)
x_dt_wanted$Activity<-gsub(4,"SITTING",x_dt_wanted$Activity)
x_dt_wanted$Activity<-gsub(5,"STANDING",x_dt_wanted$Activity)
x_dt_wanted$Activity<-gsub(6,"LAYING",x_dt_wanted$Activity)


#5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for 
#each activity and each subject.

#Get subject's ids
sub_train<-fread("UCI HAR Dataset//train//subject_train.txt")
sub_test<-fread("UCI HAR Dataset//test//subject_test.txt")
sub_all<-rbindlist(list(sub_train,sub_test))

#Add subject IDs to the dataset
x_dt_wanted<-x_dt_wanted[,subject_id:=sub_all$V1]


#Create Tidy Table by summarizing all measurements by Subject and activity
tidy_tbl<-x_dt_wanted%>%
  group_by(subject_id,Activity)%>%
  summarise_all(mean)

write.table(tidy_tbl, "FinalData.txt", row.name=FALSE)


