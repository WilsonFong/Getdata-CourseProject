runAnalysis <- function() {
        ##Read in test files
        subject <- read.table("UCI HAR Dataset/test/subject_test.txt")
        activity <- read.table("UCI HAR Dataset/test/y_test.txt")
        data <- read.table("UCI HAR Dataset/test/X_test.txt")
        
        ##Combine test files
        testdata <- cbind(subject,activity,data)
        
        ##Read in test files
        subject <- read.table("UCI HAR Dataset/train/subject_train.txt")
        activity <- read.table("UCI HAR Dataset/train/y_train.txt")
        data <- read.table("UCI HAR Dataset/train/X_train.txt")
        
        ##Combine test files
        traindata <- cbind(subject,activity,data)
        
        ##Combine test and train data
        alldata <- rbind(testdata,traindata)
        
        ##Assign activity names
        alldata[alldata[,2]==1,2] = "walking"
        alldata[alldata[,2]==2,2] = "walkingupstairs"
        alldata[alldata[,2]==3,2] = "walkingdownstairs"
        alldata[alldata[,2]==4,2] = "sitting"
        alldata[alldata[,2]==5,2] = "standing"
        alldata[alldata[,2]==6,2] = "laying"
        
        ##Assign column names
        colnames(alldata)[1] <- "subject"
        colnames(alldata)[2] <- "activity"
        #Dealing with feature colmns
        features <- read.table("UCI HAR Dataset//features.txt",stringsAsFactors=FALSE)
        for (i in 1:nrow(features)) {
                colnames(alldata)[i+2] <- features[i,2] ##i+2:i vs i:i because subject and activity are first 2 columns
        }
        
        ##Extract only mean() and std() values
        newdata <- alldata[,grep("subject|activity|mean\\(\\)|std",names(alldata))]
        
        ##Create better variable names
        colnames(newdata) <- gsub("\\(\\)","",names(newdata))
        colnames(newdata) <- gsub("-","",names(newdata))
        colnames(newdata) <- gsub("^t","time",names(newdata))
        colnames(newdata) <- gsub("^f","frequency",names(newdata))
        colnames(newdata) <- gsub("mean","Mean",names(newdata))
        colnames(newdata) <- gsub("std","StandardDeviation",names(newdata))
        colnames(newdata) <- gsub("Acc","Accelerometer",names(newdata))
        colnames(newdata) <- gsub("Gyro","Gyroscope",names(newdata))
        colnames(newdata) <- gsub("Mag","Magnitude",names(newdata))
        
        ##Melt data frame
        library(reshape2)
        id <- c("subject", "activity")
        measure.vars <- names(newdata)[names(newdata)!="subject"&names(newdata)!="activity"]
        dataMelt <- melt(newdata, id=id, measure.vars=measure.vars)
        
        ##Mean data frame
        meanData <- dcast(dataMelt, subject+activity ~ variable, mean)
        
        ##Write final data file
        write.table(meanData, file="./finaldatatable.txt",row.name=FALSE)
}