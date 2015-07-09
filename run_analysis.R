## Read 'subject_train.txt' into R
subject_train <- read.table("subject_train.txt", header=FALSE, col.names="Subject")

## Read 'y_train.txt' into R. This is a data frame with activities,
## 1 WALKING, 2 WALKING_UPSTAIRS, 3 WALKING_DOWNSTAIRS, 4 SITTING,
## 5 STANDING, 6 LAYING.
y_train <- read.table("y_train.txt", header=FALSE, col.names="Activity")

## Read 'x_train.txt' into R.
x_train <- read.table("x_train.txt", header=FALSE)

## Merge all "train" tables into one data frame.
train_data <- cbind(subject_train,y_train,x_train)

## Read 'subject_test.txt' into R.
subject_test <- read.table("subject_test.txt", header=FALSE, col.names="Subject")

## Read 'y_test.txt' into R. This is a data frame with activities,
## 1 WALKING, 2 WALKING_UPSTAIRS, 3 WALKING_DOWNSTAIRS, 4 SITTING,
## 5 STANDING, 6 LAYING.
y_test <- read.table("y_test.txt", header=FALSE, col.names="Activity")

## Read 'x_test.txt' into R.
x_test <- read.table("x_test.txt", header=FALSE)

## Merge all "test" tables into one data frame.
test_data <- cbind(subject_test,y_test,x_test)

## Merge 'test_data' and 'train_data' with rbind.
all_data <- rbind(train_data, test_data)

## Read 'features.txt', i.e. feature names into R.
feature_names <- read.table("features.txt", header=FALSE, colClasses="character")

## Give names to columns 3 to 563 in 'all_data' based on 
## 'feature_names' data frame.
names(all_data) [3:563] <- c(feature_names$V2)

## Extract only the measurements on the mean and standard deviation 
## for each measurement, i.e. search for 'mean()' or 'std()' in the 
## names of all columns (plus keep columns Subject and Activity). 
mean_std <- all_data[,grep("(Subject|Activity|mean[(][)]|std[(][)])",names(all_data))]

## Use descriptive activity names to name the activities:
## First read 'activity_labels.txt' into R. 
activity_labels <- read.table("activity_labels.txt", header=FALSE, colClasses="character")

## Second use a for loop to change the numbers of activities in 'mean_std'
## to descriptive names as indicated in 'activity_labels' data frame.
for (i in 1:6) {
        mean_std$Activity[mean_std$Activity == i] <- activity_labels[i,2]
        ## This works too:
        ## mean_std[mean_std$Activity == i, 2] <- activity_labels[i, 2]      
}

## Create an independent tidy data set with the average of each variable 
## for each activity and each subject using dplyr package.
library(dplyr)
tidy <- group_by(mean_std, Subject, Activity) %>% summarise_each(funs(mean))

## Create a new txt file 'TidyDataSet.txt' with the tidy data.
write.table(tidy, file="TidyDataSet.txt", row.names=FALSE)
