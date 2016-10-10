run_analysis <- function(featuresfile = "features.txt", activitylabelfile = "activity_labels.txt", 
                         traindatafile = "./train/X_train.txt", trainlabelfile = "./train/y_train.txt", 
                         testdatafile = "./test/X_test.txt", testlabelfile = "./test/y_test.txt" ){
  ## Run script by providing the filepath for featuresfile, activitylablesfile, 
  ##    traindatafile, trainlabelfile, testdatafile, and testlabelfile to be loaded to R
  ##    default file path assumes that the run_analysis script will be saved in the same folder
  ##    as features and activity_lables text file
  ## 1. Merges the training and the test sets to create one data set.
  ## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
  ## 3. Uses descriptive activity names to name the activities in the data set
  ## 4. 4.Appropriately labels the data set with descriptive variable names. 
  ## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  
  features <- read.table(featuresfile)
  activitylabel <- read.table(activitylabelfile)
  traindata <-read.table(traindatafile)
  trainlabel <- read.table(trainlabelfile)
  testdata <- read.table(testdatafile)
  testlabel <- read.table(testlabelfile)
  
  ## add subject train to train dataset and merge labels to dataset
  trainlabel <- cbind("subject" = "train", trainlabel)
  traindata <- cbind.data.frame(trainlabel, traindata)
  
  ## add subject test to test dataset and merge labels to dataset
  testlabel <- cbind("subject" = "test", testlabel)
  testdata <- cbind.data.frame(testlabel, testdata)
  
  ##combine train and test data together
  allsubjectdata <- rbind.data.frame(traindata, testdata)

  ##rename column to descriptive values provided in the features file
  featureslabel <- as.vector(features$V2)
  names(allsubjectdata) <- c("subject", "activityid", featureslabel)
  
  ##merge the activitylable to allsujbectdata
  names(activitylabel) <- c("activityid", "activity")
  allsubjectdata <- merge(activitylabel, allsubjectdata)
  
  ##subset data based on mean and SD
  subsetdata <- allsubjectdata[, grepl("subject|activity$|mean\\(\\)|std\\(\\)", names(allsubjectdata))]
  names(subsetdata) <- gsub("\\(\\)","",names(subsetdata))
  
  
  #average of each variable for each activity and each subject
  averagedata <- aggregate(subsetdata[, 3:68], list("subject" = subsetdata$subject, "activity" = subsetdata$activity), mean)
  
  write.table(averagedata, file="./tidy_data.txt", row.names = FALSE)

}