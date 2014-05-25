# Download dataset if directory 'UCI Har Dataset' and zip file 'UCI_Har_Dataset.zip is missing. The eetract data to directory 'UCI Har Dataset'.
if (!file.exists("UCI Har Dataset")) {   
        if (!file.exists("UCI_Har_Dataset.zip")){
                download.file("http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "UCI_Har_Dataset.zip")
        }
        
        #unzip the data file
        unzip("UCI_Har_Dataset.zip")
}

activityList <- read.table("UCI Har Dataset/activity_labels.txt", sep=" ", colClasses=c("integer","character")) 
featureNames <- read.table("UCI Har Dataset/features.txt", sep=" ", colClasses=c("integer","character")) 

# Helper function that merges data from subject, y and X subdata located in test or train subfolder.
mergeData <- function(subfolder = "test"){
        subjectData <- read.table(paste0("UCI Har Dataset/", subfolder, "/subject_", subfolder, ".txt"))
        yData <- read.table(paste0("UCI Har Dataset/", subfolder, "/y_", subfolder, ".txt"), colClasses="integer")       
        XData <- read.table(paste0("UCI Har Dataset/", subfolder, "/X_", subfolder, ".txt"))
               
        data <- cbind(subjectData, yData, XData)
        names(data) <- c("subject", "activityId", featureNames[,2])
        return(data)
}

# Merge the training and the test sets to create one data set.
dataFinal <- rbind(mergeData("train"), mergeData("test"))

#  Find measurement/features related that has mean and standard deviation naming.
rowWithMeanStd <- grepl("(*Mean$|*-mean()*|*-std()*)", featureNames[,2])
colNameWithMeanStd <- featureNames[rowWithMeanStd,2]

# Override the dataset to include only tyhe subject, activityId and mean/std mesarurement.
dataFinal <- dataFinal[,c("subject", "activityId",colNameWithMeanStd)]

# Replace the dataset's activityId column with descriptive activity name.
dataFinal$activityName <- activityList[dataFinal$activityId, 2]
dataFinal <- dataFinal[,c("subject", "activityName",colNameWithMeanStd)]

# Replace characters (mean,std,() and - ) from the measrurement's label.
colNameWithMeanStd <- gsub("*mean*", "Mean", colNameWithMeanStd)
colNameWithMeanStd <- gsub("*std*", "Std", colNameWithMeanStd)
colNameWithMeanStd <- gsub("*\\(\\)*", "", colNameWithMeanStd)
colNameWithMeanStd <- gsub("*-*", "", colNameWithMeanStd)
names(dataFinal) <- c("subject", "activityName",colNameWithMeanStd)

# Calculate the average of each measurement for each activity and each subject. Saved the result to tab delimited text file, tidyData.txt.
tidyData <- aggregate(. ~ subject + activityName, data=dataFinal, mean)
write.table(tidyData, "tidyData.txt", sep="\t")
#  End of the Program
