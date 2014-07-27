Getting and Cleaning Data 005 Course Project 1.0
- - - 
Christina Brady
- - - 
This is an exercise in obtaining and cleaning raw data and creating a tidy dataset that can be used for further analysis. It is an assignment for the Getting and Cleaning Data 005 course offered by John Hopkins University via Coursera. 

The dataset used for this project is the Human Activity Recognition Using Smartphones Dataset, Version 1.0. 

The dataset and more information about the data collection can be found at: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
- - -

The original dataset includes data collected from a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, the data scientists captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record the following is provided:


- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The tidy dataset is a data frame in which each observation is the average of all of the means or standard deviations of a particular measurement one subject performing one activity. 

To create the tidy dataset, first I loaded all of the documents into data tables and began exploring them. 

I discovered that:
- x_test contains 2947 obs of 561 variables, there are no na values
- y_test contains 2947 obs of 1 variable with values 1-6
- x_train contains 7352 obs of 561 variables, there are no na values
- y_train contains 7352 obs of 1 variable with values 1-6
- subject_test contains 2947 obs of 1 variable with values:
		2, 4, 9, 10, 12, 13, 18, 20, 24
- subject_train contains 7352 obs of 1 variable with values: 
		1, 3, 5, 6, 7, 8, 11, 14, 15, 16, 17, 19, 21, 22, 23, 25, 26, 27, 28, 29, 30
Thus, I came to the conclusion that all of the data could be combined without creating a duplications simply by combining all of the tables together. 

Next, the variable names were modified so that they maintain the original variable name as coded in the features.txt file. However, the variable names are all in lower case letters and all of the dashes have been removed. The data frame was then written to a txt file using one space as the separator and including the column names. 

Then, only the measurements on the mean and standard deviation for each measurement were extracted from the original data set by:
1. reading all of the variable names from the features.txt document and extracting them into a single vector, 
2. extracting all of the variables that include the strings 'mean' or 'std', which the original authors used to abbreviate standard deviation, 
3. eliminating the instances in which variables including the string 'meanFreq' were included by extracting them from the original vector, using the match command to identify the positions in the vector that include the string 'meanFreq' and eliminate them using negative indexing,
4. using the vector containing all of the instances in which the strings 'mean' and 'std' appear minus the instances of 'meanFreq' to extract all of the columns with the same names from the original data frame. 

Then, the data frame including the measures and the data frame including the activity labels were merged. In order to facilitate taking the mean of each column of measurements for each activity and subject, the activity and subject variables were coerced into factor variables. 

Finally, using the aggregate function, the mean of these measurements was taken for each activity and each subject and input into a data frame. The aggregate function creates unecessary columns by duplicating the subject and activity column and trying to find the mean of the activity column, which is a character string. The unnecessary columns were eliminated via negative indexing. 

The final data frame was then written to a text file titled 'tidy_data.txt'. 

All of the manipulation of the data was performed in R version 3.1.0 using RStudio 0.98.501 on a Mac OS 10.7.5. Sourcing the run_analysis.R script in will replicate the data manipulation and write the tidy data frame to a text document titled 'tidy_data.txt'. 

The dataset includes the following files:

- 'README.md'
- 'CodeBook.md'
- 'tidy_data.txt'
- 'run_analysis.R'
- the original dataset

The original dataset includes the following files:

- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.

References:

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

