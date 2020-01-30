## A script to load some test/training dataset
## and to merge them in a tidy dataset


## --------------------------------------------------------------------------
## load the features.txt dataset
## Input: dir = repository folder
## --------------------------------------------------------------------------
loadFeatures <- function(dir) {
    
    # features (561 labels) (only used to set some column names)
    fileName = paste(dir,"/features.txt",sep="")
    colName = c("num","label")
    tbl_features <- read_delim(fileName, delim = " ", col_names = colName)
}

## --------------------------------------------------------------------------
## load the raw dataset
## Input: dir = repository folder
##        type = "test" or "train"
## --------------------------------------------------------------------------
loadDataset <- function(dir, type, featlbl) {
    
    ## subject dataset
    fileName = filePath(dir, "subject", type)
    colName = "subject"
    tbl_subject <- read_delim(fileName, delim = " ", col_names = colName)

    # add new column 'type' (values = [test,train])
    nbRows = nrow(tbl_subject)
    tbl_subject <- add_column(tbl_subject, 'type' = c(rep(type,nbRows)))
    
    # labels (activities)
    fileName = filePath(dir, "y", type)
    colName = "activity"
    tbl_y <- read_delim(fileName, delim = " ", col_names = colName)
    # TODO: should read this following config directly inside activity_labels.txt

    # Step 3. Uses descriptive activity names to name the activities in the data set
    tbl_y <- mutate(tbl_y, activity = recode(activity,
                                        `1` = "WALKING",
                                        `2` = "WALKING_UPSTAIRS",
                                        `3` = "WALKING_DOWNSTAIRS",
                                        `4` = "SITTING",
                                        `5` = "STANDING",
                                        `6` = "LAYING"))

    # Caution! duplicated labels: need to rename some labels (adding suffix -X/-Y/-Z)
    #   - fBodyAcc-bandsEnergy()-<#band> (each family has 14 measurements)
    #     [303 to 316] renamed fBodyAcc-bandsEnergy()-<#band>-X
    #     [317 to 330] renamed fBodyAcc-bandsEnergy()-<#band>-Y
    #     [331 to 344] renamed fBodyAcc-bandsEnergy()-<#band>-Z
    #   - fBodyAccJerk-bandsEnergy()-<#band> (each family has 14 measurements)
    #     [382 to 395] renamed fBodyAccJerk-bandsEnergy()-<#band>-X
    #     [396 to 409] renamed fBodyAccJerk-bandsEnergy()-<#band>-Y
    #     [410 to 423] renamed fBodyAccJerk-bandsEnergy()-<#band>-Z
    #   - fBodyGyro-bandsEnergy()-<#band> (each family has 14 measurements)
    #     [461 to 474] renamed fBodyGyro-bandsEnergy()-<#band>-X
    #     [475 to 488] renamed fBodyGyro-bandsEnergy()-<#band>-Y
    #     [489 to 502] renamed fBodyGyro-bandsEnergy()-<#band>-Z
    #
    ## TODO: rename the duplicated labels...
    ## Here, some unsuccessfull tests...
    #colnames(tbl_features)[317:330] <- paste(colnames(tbl_features)[317:330], "Y", sep = "-")
    #tbl_features <- rename_at(tbl_features, vars(-(1:3)), ~paste0(., "_HELLLLO"))
    #tbl_features <- lapply(tbl_features$label[1:4], paste0, "HELLO!")

    # load X dataset
    fileName = filePath(dir, "X", type)
    colName = featlbl
    tbl_X <- read_delim(fileName, delim = " ", col_names = colName, col_types = cols(.default = "n") )

    nb_signals = 128
    subdirdata = "Inertial Signals"
    # body_acc_x/y/z
    datasetname = "body_acc_x"
    fileName = filePath(dir, paste(subdirdata,datasetname, sep="/"), type)
    colName = paste(rep(datasetname, nb_signals),sprintf("%03d",seq(from = 1, by = 1, length.out = nb_signals)), sep = "_")
    tbl_body_acc_x = read_delim(fileName, delim = " ", col_names = colName, col_types = cols(.default = "n") )
    
    datasetname = "body_acc_y"
    fileName = filePath(dir, paste(subdirdata,datasetname, sep="/"), type)
    colName = paste(rep(datasetname, nb_signals),sprintf("%03d",seq(from = 1, by = 1, length.out = nb_signals)), sep = "_")
    tbl_body_acc_y = read_delim(fileName, delim = " ", col_names = colName, col_types = cols(.default = "n") )
    
    datasetname = "body_acc_z"
    fileName = filePath(dir, paste(subdirdata,datasetname, sep="/"), type)
    colName = paste(rep(datasetname, nb_signals),sprintf("%03d",seq(from = 1, by = 1, length.out = nb_signals)), sep = "_")
    tbl_body_acc_z = read_delim(fileName, delim = " ", col_names = colName, col_types = cols(.default = "n") )
    
    # body_gyro_x/y/z
    datasetname = "body_gyro_x"
    fileName = filePath(dir, paste(subdirdata,datasetname, sep="/"), type)
    colName = paste(rep(datasetname, nb_signals),sprintf("%03d",seq(from = 1, by = 1, length.out = nb_signals)), sep = "_")
    tbl_body_gyro_x = read_delim(fileName, delim = " ", col_names = colName, col_types = cols(.default = "n") )
    
    datasetname = "body_gyro_y"
    fileName = filePath(dir, paste(subdirdata,datasetname, sep="/"), type)
    colName = paste(rep(datasetname, nb_signals),sprintf("%03d",seq(from = 1, by = 1, length.out = nb_signals)), sep = "_")
    tbl_body_gyro_y = read_delim(fileName, delim = " ", col_names = colName, col_types = cols(.default = "n") )
    
    datasetname = "body_gyro_z"
    fileName = filePath(dir, paste(subdirdata,datasetname, sep="/"), type)
    colName = paste(rep(datasetname, nb_signals),sprintf("%03d",seq(from = 1, by = 1, length.out = nb_signals)), sep = "_")
    tbl_body_gyro_z = read_delim(fileName, delim = " ", col_names = colName, col_types = cols(.default = "n") )
    
    # total_acc_x/y/z
    datasetname = "total_acc_x"
    fileName = filePath(dir, paste(subdirdata,datasetname, sep="/"), type)
    colName = paste(rep(datasetname, nb_signals),sprintf("%03d",seq(from = 1, by = 1, length.out = nb_signals)), sep = "_")
    tbl_total_acc_x = read_delim(fileName, delim = " ", col_names = colName, col_types = cols(.default = "n") )
    
    datasetname = "total_acc_y"
    fileName = filePath(dir, paste(subdirdata,datasetname, sep="/"), type)
    colName = paste(rep(datasetname, nb_signals),sprintf("%03d",seq(from = 1, by = 1, length.out = nb_signals)), sep = "_")
    tbl_total_acc_y = read_delim(fileName, delim = " ", col_names = colName, col_types = cols(.default = "n") )
    
    datasetname = "total_acc_z"
    fileName = filePath(dir, paste(subdirdata,datasetname, sep="/"), type)
    colName = paste(rep(datasetname, nb_signals),sprintf("%03d",seq(from = 1, by = 1, length.out = nb_signals)), sep = "_")
    tbl_total_acc_z = read_delim(fileName, delim = " ", col_names = colName, col_types = cols(.default = "n") )
    
    ## merge dataset
    tbl_test <- bind_cols(tbl_subject,
                          tbl_y,
                          tbl_X,
                          tbl_body_acc_x,
                          tbl_body_acc_y,
                          tbl_body_acc_z,
                          tbl_body_gyro_x,
                          tbl_body_gyro_y,
                          tbl_body_gyro_z,
                          tbl_total_acc_x,
                          tbl_total_acc_y,
                          tbl_total_acc_z)
}

## --------------------------------------------------------------------------
## build a full file path
## Input: dir = repository folder
##        filename = short file name (without ext)
##        type = "test" or "train"
## --------------------------------------------------------------------------
filePath <- function(dir, fileName, type) {

    paste(dir,"/",type,"/",paste(fileName,"_",type,sep=""),".txt",sep="")
    
}

## =================================================================
## main
## =================================================================

# use 'readr' library to make directly some tibble
library(readr)
library(tibble)
library(dplyr)

# my local repository of initial dataset
setwd("~/R/03 - Geting and Cleaning Data")

## -----------------------------------------------------------------
## Step 1. Merges the training and the test sets to create one data set.
## -----------------------------------------------------------------

## 1a. Load Test dataset
folderName <- "./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset"

# load features with labels (only once)
ft_lbl<-loadFeatures(folderName)

# dataset TEST
typeOfDataSet <- "test"
dt_test<-loadDataset(folderName, typeOfDataSet, ft_lbl$label)

# dataset TRAINING
typeOfDataSet <- "train"
dt_training<-loadDataset(folderName, typeOfDataSet, ft_lbl$label)

# global merge
dt_total <- bind_rows(dt_test, dt_training)

## -----------------------------------------------------------------
## Step 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## -----------------------------------------------------------------
## Extract:
##    a) subject
##    b) activity label
##    c) all columns with a name containing '-mean' (42 var.) and '-std' (29 var.)
## Result:
##    10299 obs. of 81 variables
dt_extract <- dt_total[grepl("subject|activity|-mean|-std", names(dt_total))]

## -----------------------------------------------------------------
## Step 3. Uses descriptive activity names to name the activities in the data set
## Step 4. Appropriately labels the data set with descriptive variable names.
## -----------------------------------------------------------------
# Already done in loadDataset()

## -----------------------------------------------------------------
## Step 5. From the data set in step 4, creates a second, independent tidy data set
##         with the average of each variable for each activity and each subject
## -----------------------------------------------------------------
gby_subject_activity <- group_by(dt_extract, subject, activity)
dt_stats <- summarise_all(gby_subject_activity, tibble::lst(mean))
# export this dataset as a text file
write.table(dt_stats, file="dt_stats.txt", row.name=FALSE)

## Result:
##    180 obs. of 81 var.
##
## ... something like:
##
## ________________________________________________________________________________________________________________________________________________________________________________________________________
##  subject	activity	        tBodyAcc-mean()-X_mean	tBodyAcc-mean()-Y_mean	tBodyAcc-mean()-Z_mean	tBodyAcc-std()-X_mean	tBodyAcc-std()-Y_mean	tBodyAcc-std()-Z_mean	tGravityAcc-mean()-X   ....
## 1	1	LAYING	            0.2215982	            -0.040513953	        -0.11320355	            -0.92805647	            -0.836827406	        -0.82606140	            -0.2488818 ....
## 2	1	SITTING	            0.2612376	            -0.001308288        	-0.10454418	            -0.97722901	            -0.922618642	        -0.93958629	            0.8315099 ....
## 3	1	STANDING	        0.2789176	            -0.016137590	        -0.11060182	            -0.99575990	            -0.973190056	        -0.97977588	            0.9429520 ....
## 4	1	WALKING	            0.2773308	            -0.017383819	        -0.11114810	            -0.28374026	            0.114461337	            -0.26002790	            0.9352232 ....
## 5	1	WALKING_DOWNSTAIRS	0.2891883	            -0.009918505	        -0.10756619	            0.03003534	            -0.031935943	        -0.23043421	            0.9318744 ....

