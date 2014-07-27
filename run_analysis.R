### change working directory
setwd("/Users/christinabrady/Documents/Coursera courses/Getting and Cleaning Data/Project")

### read data into data tables and explore data
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
  ### data table of 2947 obs. of 561 variables

y_test <- read.table("UCI HAR Dataset/test/Y_test.txt")
  ### data table of 2947 obs of 1 variable with values 1-6

subject_test <- read.table("test/subject_test.txt")
  ### 2947 obs of 1 variable with values 2, 4, 9, 10, 12, 13, 18, 20, 24

x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
  ### data table of 7352 obs of 561 variables

y_train <- read.table("UCI HAR Dataset/train/Y_train.txt")
  ### data table of 7352 obs of 1 variable with values 1-6

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
  ### data table of 7352 obs of 1 variable with values:
  ### 1, 3, 5, 6, 7, 8, 11, 14, 15, 16, 17, 19, 21, 22, 23, 25, 26, 27, 28, 29, 30

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", stringsAsFactors=FALSE, col.names = c("activity_ID", "activity"))
  ### creates a data table with 6 obs of two variables. The first variable is the numeric
  ### identifier for each activity and the second variable is the activity name

### combine test data into one data table
test_all <- cbind(subject_test, y_test, x_test)

### combine train data into one data table
train_all <- cbind(subject_train, y_train, x_train)

### combine everything into one data set
all_data <- rbind(test_all, train_all)

### label the variables
  ### read features.txt into a data table in order to extract the variable names to a vector
  ### and use that vector to create variable names for the data table
features <- read.table("features.txt", stringsAsFactors=FALSE)
names <- features$V2 ###features is a data table in which the first row is a numerical identifier

### modify column names so that they are easy to understand and reproduce
names <- tolower(names)
names <- gsub("-", "", names) ### eliminate the dashes
names <- gsub("\\(", "", names) ### eliminate the opening parentheses
names <- gsub("\\)","", names)  ### eliminate the closing parentheses
colnames(all_data) <- c("subject", "activity_ID", names)

### in order to extract the measurements on mean and sd, first create a list of index numbers
### associated with the mean and sd variables
feat <- grep("*-mean|-std*", features[,2])
meanfreq <- grep("*meanFreq*", features[,2])
er <- match(meanfreq, feat)
x <- feat[-er]
x <- x+2 ### because the first two columns are subject and activity_ID
x <- c(1, 2, x) ### to include the first two columns which are the subject and activity identifiers
meansd <- all_data[, x]

### in order to use descriptive activity names to name the activities in the data set
### I want to merge my complete data table with the data table created by reading the
### activity_labels by the activity_ID. Thus will fill in the corresponding "activity" each time
### activity_ID that it encounters
meansdlabel <- merge(meansd, activity_labels, by = "activity_ID")

### find the average of each variable for each subject and activity
meansdlabel$activity <- as.factor(meansdlabel$activity)
meansdlabel$subject <- as.factor(meansdlabel$subject)
meansdf <- aggregate(meansdlabel, by=list(meansdlabel$subject, meansdlabel$activity), FUN=mean)
meansdf <- meansdf[,-c(3,4,71)]
colnames(meansdf)[1] <- "subject"
colnames(meansdf)[2] <- "activity"
