

install.packages("data.table")
library(data.table)

#preparing all datasets & labels

featuresLabels<-t(read.table("./features.txt",sep=""))[2,]
activityLabels<-read.table("./activity_labels.txt",sep="")

subjTrain<-read.table("./train/subject_train.txt",sep="")
subjTest<-read.table("./test/subject_test.txt",sep="")
subject<-rbind(subjTrain,subjTest)
names(subject)<-"subject"

dataTrain<-read.table("./train/X_train.txt",sep="")
dataTest<-read.table("./test/X_test.txt",sep="")
data<-rbind(dataTrain,dataTest)
names(data)<-featuresLabels

actTrain<-read.table("./train/Y_train.txt",sep="")
actTest<-read.table("./test/Y_test.txt",sep="")
activity<-rbind(actTrain,actTest)
names(activity)<-"activity"

#Extracts only the measurements on the mean and standard deviation for each measurement. 
mea<- grep("mean()|std()", names(data)) 
data<-data[,mea]

#merging datsets
allData<-cbind(data,subject,activity)

#Uses descriptive activity names to name the activities in the data set
allData$activity<-factor(allData$activity,levels=1:6,labels=c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING"))

#From the data set in step 4, creates a second, independent tidy data set with the average of 
#each variable for each activity and each subject.
allData2<-aggregate(.~activity+subject, allData,mean)





