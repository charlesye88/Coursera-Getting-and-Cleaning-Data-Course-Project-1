#Q1
datapath <- file.path(getwd(),"Data","UCI HAR Dataset")
datapath_train <- file.path(datapath,"train")
datapath_test <- file.path(datapath,"test")

xtrain <- read.table(file.path(datapath_train,"X_train.txt"),header = FALSE)
ytrain <- read.table(file.path(datapath_train,"y_train.txt"),header = FALSE)
subject_train <- read.table(file.path(datapath_train,"subject_train.txt"),header = FALSE)

xtest <- read.table(file.path(datapath_test,"X_test.txt"),header = FALSE)
ytest <- read.table(file.path(datapath_test,"y_test.txt"),header = FALSE)
subject_test <- read.table(file.path(datapath_test,"subject_test.txt"),header = FALSE)

features <- read.table(file.path(datapath,"features.txt"),header = FALSE)
activityLabels <- read.table(file.path(datapath,"activity_labels.txt"),header = FALSE)

#Q2
colnames(xtrain) <- features[,2]
colnames(ytrain)<-"activityId"
colnames(subject_train) = "subjectId"

colnames(xtest) <- features[,2]
colnames(ytest)<-"activityId"
colnames(subject_test) = "subjectId"

colnames(activityLabels) <- c('activityId','activityType')

merge_train <- cbind(ytrain,subject_train,xtrain)
merge_test <- cbind(ytest,subject_test,xtest)

combined <- union(merge_train,merge_test)

#Q3
colNames <- colnames(combined)
mean_and_std <- grepl("activityId|subjectId|mean.|std.",colNames)

subsetMeanStd <- combined[,mean_and_std]

#Q4
subsetWithNames <- merge(subsetMeanStd,activityLabels,by="activityId",all.x = T)


#Q5
tidyData <- aggregate(subsetWithNames[,-c(1,ncol(subsetWithNames))],
                      by=list(subsetWithNames$activityType, 
                      subsetWithNames$subjectId),
                      FUN = mean,na.rm =T)


write.table(tidyData,"tidydata.txt",row.names = FALSE)
