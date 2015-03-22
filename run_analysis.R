<<<<<<< HEAD
#set the working directory
#this may change depeneding where you put the directory file
directory <- getwd()

#reading in all the feature (x) files 
xTrain <- read.table(paste(directory, "/train/X_train.txt", sep=""))
xTest <- read.table(paste(directory, "/test/X_test.txt", sep=""))
#combine into one dataframe
featureData <- rbind(xTrain, xTest)

# reading the labels from the files 
yTrain <- read.table(paste(directory, "/train/y_train.txt", sep=""))
yTest <- read.table(paste(directory, "/test/y_test.txt", sep=""))
#combine into one data frame 
activityLabels <- rbind(yTrain, yTest)
#giving a proper name to the variable
names(activityLabels) <- "activityid"   

# Reading the subject identifiers from necessary files
sTrain <- read.table(paste(directory, "/train/subject_train.txt", sep=""))
sTest <- read.table(paste(directory, "/test/subject_test.txt", sep=""))
subjectLabels <- rbind(sTrain, sTest)   # combining train and test data into one data frame
names(subjectLabels) <- "subjectid"     # giving a proper name to the variable

# Reading the feature names from necessary files
featureNames <- read.table(paste(directory, "/features.txt", sep=""));
#only interested in the second column 
featureNames <- featureNames[,2] 

# Getting required feature subset from original feature set
# getting only variables with mean() and std() in themq
reqdfeatureIndices <- grep("-mean\\(\\)|-std\\(\\)", featureNames)  
featureData <- featureData[,reqdfeatureIndices]
names(featureData) <- featureNames[reqdfeatureIndices]
# Transforming variable names to follow conventions
#remove the brackets
names(featureData) <- gsub("\\(|\\)", "", names(featureData)) 
#change to lower case
names(featureData) <- tolower(names(featureData))

#Getting the activity names 
activityNames <- read.table(paste(directory, "/activity_labels.txt", sep="")); 
#remove _ and change to lower case
activityNames[, 2] <- gsub("_", "", tolower(as.character(activityNames[, 2])))

# Transforming activity identifiers into names
activityData <- data.frame(activityname=activityNames[activityLabels[,],2])

# Combining all the data frames into one single data frame
cleanData <- cbind(subjectLabels,activityData,featureData)
write.table(cleanData,"clean_data.txt",sep="\t",row.names=FALSE)


# Writing our first tidy dataset into files
write.csv(cleanData,"clean_data.csv",row.names=FALSE)

# loading the `reshape2` package
if (!is.element("reshape2", installed.packages()[,1])){
  install.packages("reshape2")
} else{
  library(reshape2)
}

# Setting the required identifier and measure variables
idVars <- c("subjectid","activityname")
#get all names out except subjectid and activity name
measureVars <- setdiff(colnames(cleanData), idVars)

# Melting the data frame now
meltedData <- melt(cleanData, id=idVars, measure.vars=measureVars)

# Decasting the molten data frame based on required criteria
tidyData <- dcast(meltedData,subjectid+activityname ~ variable,mean)

# Writing our final tidy dataset into files
write.csv(tidyData,"tidy_data.csv",row.names=FALSE)
write.table(tidyData,"tidy_data.txt",sep="\t",row.names=FALSE)

=======
library(data.table)
#set the current working directory
source("run_analysis.R")

#base step
#read in and load test, training sets and the activities
testData <- read.table("./UCI HAR Dataset/test/X_test.txt",header=FALSE)
testData_act <- read.table("./UCI HAR Dataset/test/y_test.txt",header=FALSE)
testData_sub <- read.table("./UCI HAR Dataset/test/subject_test.txt",header=FALSE)
trainData <- read.table("./UCI HAR Dataset/train/X_train.txt",header=FALSE)
trainData_act <- read.table("./UCI HAR Dataset/train/y_train.txt",header=FALSE)
trainData_sub <- read.table("./UCI HAR Dataset/train/subject_train.txt",header=FALSE)

#step 3
#Uses descriptive activity names to name the activities in the data set
activities_labels <- read.table("./UCI HAR Dataset/activity_labels.txt",header=FALSE,colClasses="character")
testData_act$V1 <- factor(testData_act$V1,levels=activities_labels$V1,labels=activities_labels$V2)
trainData_act$V1 <- factor(trainData_act$V1,levels=activities_labels$V1,labels=activities_labels$V2)

#step 4
#Appropriately labels the data set with descriptive activity names. 
features <- read.table("./UCI HAR Dataset/features.txt",header=FALSE,colClasses="character")
colnames(testData)<-features$V2
colnames(trainData)<-features$V2
colnames(testData_act)<-c("Activity")
colnames(trainData_act)<-c("Activity")
colnames(testData_sub)<-c("Subject")
colnames(trainData_sub)<-c("Subject")

#step 1
#Merges the training and the test sets to create one data set.
testData<-cbind(testData,testData_act)
testData<-cbind(testData,testData_sub)
trainData<-cbind(trainData,trainData_act)
trainData<-cbind(trainData,trainData_sub)
finalData<-rbind(testData,trainData)

#step 2
#Extracts only the measurements on the mean and standard deviation for each measurement. 
Data_mean<-sapply(finalData,mean,na.rm=TRUE)
Data_sd<-sapply(finalData,sd,na.rm=TRUE)

#step 5
#Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
DT <- data.table(finalData) #convert back to data.table to apply the code below. Note that finaldata is a data.frame
tidy_data<-DT[,lapply(.SD,mean),by="Activity,Subject"]

write.table(tidy_data,"tidy_data.txt")
>>>>>>> FETCH_HEAD

