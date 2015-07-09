# Getting-and-cleaning-data---Course-project

About the script 'run_analysis.R'
----------------

The goal of the script 'run_analysis.R' is to prepare tidy data that can be used for later analysis. The script 'run_analysis.R' does the following:
* Merges the training and the test sets to create one data set. 
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set 
* Appropriately labels the data set with descriptive variable names.  
* From the data set in previous step, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Each step is described in more detail below.


The tidy data contents produced by the script are described in the attached CodeBook.md.


Source data
-----------

The data used in the script 'run_analysis.R' represents data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The source data is available here: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 


The script 'run_analysis.R' uses the following files from the source data:
* 'y_train.txt'
* 'y_test.txt'
* 'x_train.txt' 
* 'x_test.txt'
* 'subject_train.txt' 
* 'subject_test.txt'
* 'features.txt'
* 'activity_labels.txt'


How the script works
---------------------

The script 'run_analysis.R' merges all “train” tables ('y_train.txt', 'x_train.txt', etc.) and all “test” tables ('y_test.txt', 'x_test.txt', etc.) with cbind function and the resulting two data frames called 'test_data' and 'train_data' are merged into 'all_data' data frame with rbind function. 

The names are assigned to columns 3 to 563 of 'all_data' data frame based on 'features.txt' file. The code doesn't change the names of columns because those found in 'features.txt' are already quite descriptive.

After this only the measurements on the mean and standard deviation in 'all_data' are extracted with grep function to create a new data frame called 'mean_std'. It should be noted that the code searches for 'mean()' or 'std()' in the names of 'all_data' columns and that the "angle means" and "meanFreq" are not included into the search since they are not considered true means of the measurements.

Later the descriptive activity names from 'activity_labels.txt' are used to name the activities. For this purpose a for loop is used to change the numbers of activities in 'mean_std' to descriptive names as indicated in 'activity_labels' data frame.

Finally, 'group_by' and 'summarise_each()' functions of dplyr package do the job of counting the means for each column while excluding grouping variables from modification. Thus a new tidy data frame (called simply 'tidy') is generated by the code.

One can also create a new txt file from the 'tidy' data frame with this piece of code:

write.table(tidy, file="TidyDataSet.txt", row.names=FALSE)

The resulting tidy data file meets all the tidy data principles: 
* The tidy data set has headings so it is easy to tell which columns are which. 
* All the variables are in different columns.  
* There are no duplicate columns.
* Each different observation forms a different row.
* The file stores data about one “kind” of observation.

The wide form of data was chosen for this tidy data set.


Citation request
----------------

As the use of the Samsung dataset in publications must be acknowledged, a reference to the following publication is included:

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012.


Further reading
---------------

Leek JT (2013), How to share data with a statistician, https://github.com/jtleek/datasharing.

Wickham Hadley (2014), Tidy data, The Journal of Statistical Software, vol. 59, 2014. http://www.jstatsoft.org/v59/i10/paper.
