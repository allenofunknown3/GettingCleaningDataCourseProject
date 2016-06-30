#Week 4 Course Project

###############
setwd('C:/Users/Allen/Google Drive/Coursera/Data Cleaning/Week 4')

##Get Feature and Activity Names
features<-read.table('./UCI HAR Dataset/features.txt')
activity<-read.table('./UCI HAR Dataset/activity_labels.txt')

##Get Features From test
dat_test_x<-read.table('./UCI HAR Dataset/test/X_test.txt')
colnames(dat_test_x)<-features$V2
dat_test_x2<-dat_test_x[,grep('[Mm][Ee][Aa][Nn]|[Ss][Tt][Dd]',colnames(dat_test_x))]
##Get activity col
dat_test_y<-read.table('./UCI HAR Dataset/test/y_test.txt')
dat_test_y2<-merge(dat_test_y,activity, by.x="V1",by.y="V1")
colnames(dat_test_y2)<-c("act_code","act_name")
##Get subject col
dat_test_sub<-read.table('./UCI HAR Dataset/test/subject_test.txt')
colnames(dat_test_sub)<-"subject"
##Combine all test
dat_test<-cbind(dat_test_sub,dat_test_y2,dat_test_x2)

##Get Features From train
dat_train_x<-read.table('./UCI HAR Dataset/train/X_train.txt')
colnames(dat_train_x)<-features$V2
dat_train_x2<-dat_train_x[,grep('[Mm][Ee][Aa][Nn]|[Ss][Tt][Dd]',colnames(dat_train_x))]
##Rename Col to Features
dat_train_y<-read.table('./UCI HAR Dataset/train/y_train.txt')
dat_train_y2<-merge(dat_train_y,activity, by.x="V1",by.y="V1")
colnames(dat_train_y2)<-c("act_code","act_name")
##Get subject col
dat_train_sub<-read.table('./UCI HAR Dataset/train/subject_train.txt')
colnames(dat_train_sub)<-"subject"
##Combine all train
dat_train<-cbind(dat_train_sub,dat_train_y2,dat_train_x2)

##Combine test and train
dat_all<-rbind(dat_train,dat_test)
dat_all$subject<-as.factor(dat_all$subject)
dat_all$act_code<-as.factor(dat_all$act_code)

##From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidy_data<-aggregate(dat_all,by=list(dat_all$subject,dat_all$act_name),FUN="mean",na.rm=TRUE)
tidy_data<-within(tidy_data, rm(subject, act_code, act_name))
tidy_data<-tidy_data[order(tidy_data$Group.1),] 

##Write Table
write.table(tidy_data,file = "tidy_data.txt", row.name=FALSE)