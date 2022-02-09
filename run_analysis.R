library(data.table)
library(dplyr)
##Read in the features & activity files and label the columns.
features <- fread("UCI HAR Dataset/features.txt", col.names = c("index", "name"))
activity <- fread("UCI HAR Dataset/activity_labels.txt", col.names = c("activitycode","activity"))

##Read in the train data files and name the columns.
Xtrain <- fread("UCI HAR Dataset/train/X_train.txt", header = FALSE)
names(Xtrain) <- features$name
subtrain <- fread("UCI HAR Dataset/train/subject_train.txt", col.names = "subjectid")
ytrain <- fread("UCI HAR Dataset/train/y_train.txt", col.names = "activitycode")
ytrain <- left_join(ytrain, activity, by = "activitycode")

##Combine the train data into one table.
train <- cbind(subtrain, ytrain, Xtrain )

##Read in the test data files and name the columns.
Xtest <- fread("UCI HAR Dataset/test/X_test.txt", header = FALSE)
names(Xtest) <- features$name
subtest <- fread("UCI HAR Dataset/test/subject_test.txt", col.names = "subjectid")
ytest <- fread("UCI HAR Dataset/test/y_test.txt", col.names = "activitycode")
ytest <- left_join(ytest, activity, by = "activitycode")

##Combine the test data into one table.
test <- cbind(subtest, ytest, Xtest)

##Combine the training and test data
merged <- rbind(train, test)

##Get all the column index numbers that have mean or std in there names 
##along with the first 2 columns subjectid and activity
x <- c(1, 3,grep("mean|std", names(merged)))

##Extract only the above columns from the merged data.table
meansandstd <- merged[,x, with = FALSE, by = .(subjectid, activity)]

##Group by subjectid and activity then calculated the average of each measurement
tidy <- meansandstd[, lapply(.SD, mean), keyby = .(subjectid, activity) ]

##Rename the columns in tidy to denote that they are averages
avg <- c(names(tidy[,1:2]), paste0("Average",names(tidy[,3:length(names(tidy))])))
names(tidy) <- avg

##Write the summary tidy file
fwrite(tidy, file = "tidy.txt")
