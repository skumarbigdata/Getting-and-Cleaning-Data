CodeBook for Getting and Cleaning Data project
This codebook briefly describes the project dataset and the transformations steps performed by run_analysis.R script.

Dataset

The dataset represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained from this website.

The dataset is divided into training and testing set, with total of 561 features/measurement.

Transformation/Clean-Up Steps - run_analysis.R

1. Check directory and dataset existence

Download dataset if directory UCI Har Dataset and zipfile UCI_Har_Dataset.zip is missing. Once the download succeed, data is extracted to directory UCI Har Dataset.

if (!file.exists("UCI Har Dataset")) {   
        if (!file.exists("UCI_Har_Dataset.zip")){
                download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "UCI_Har_Dataset.zip")
        }

        #unzip the dxata file
        unzip("UCI_Har_Dataset.zip")
}
2. Merge train and test dataset into one dataset

Use function, mergeData to help in merging data from subject, y and X data for a particular subfolder (test/train).

mergeData <- function(subfolder = "test"){
        subjectData <- read.table(paste0("UCI Har Dataset/", subfolder, "/subject_", subfolder, ".txt"))
        yData <- read.table(paste0("UCI Har Dataset/", subfolder, "/y_", subfolder, ".txt"), colClasses="integer")       
        XData <- read.table(paste0("UCI Har Dataset/", subfolder, "/X_", subfolder, ".txt"))

        data <- cbind(subjectData, yData, XData)
        names(data) <- c("subject", "activityId", featureNames[,2])
        return(data)
}
