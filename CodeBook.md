DATA COLLECTION DESCRIPTION

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation

See 'features_info.txt' for more details.

DATA MANIPULATION:

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

CODEBOOK FOR tidy_data.txt

subject: numerical value from 1 to 30, identifies each subject for whom data was collected. 

activity: factor variable that identifies the activity being performed at the time of data collection (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
tbodyaccmeanx: mean of all tbodyaccmeanx values           
tbodyaccmeany: mean of all tbodyaccmeany values           
tbodyaccmeanz: mean of all tbodyaccmeanz values            
tbodyaccstdx: mean of all tbodyaccmeanx values   
tbodyaccstdy: mean of all tbodyaccstdy values             
tbodyaccstdz: mean of all tbodyaccstdz values            
tgravityaccmeanx: mean of all tgravityaccmeanx values         
tgravityaccmeany: mean of all tgravityaccmean values        
tgravityaccmeanz: mean of all tgravityaccmeanz values         
tgravityaccstdx: mean of all tgravityaccstdx values         
tgravityaccstdy: mean of all tgravityaccstdy values          
tgravityaccstdz: mean of all tgravityaccstdz values         
tbodyaccjerkmeanx: mean of all tbodyaccjerkmeanx values        
tbodyaccjerkmeany: mean of all tbodyaccjerkmeany values       
tbodyaccjerkmeanz: mean of all tbodyaccjerkmeanz values        
tbodyaccjerkstdx: mean of all tbodyaccjerkstdx values        
tbodyaccjerkstdy: mean of all tbodyaccjerkstdy values         
tbodyaccjerkstdz: mean of all tbodyaccjerkstdx values        
tbodygyromeanx: mean of all tbodygyromeanx values           
tbodygyromeany: mean of all tbodygyromeany values          
tbodygyromeanz: mean of all tbodygyromeanz values           
tbodygyrostdx: mean of all tbodygyrostdx values           
tbodygyrostdy: mean of all tbodygyrostdy values            
tbodygyrostdz: mean of all tbodygyrostdz values           
tbodygyrojerkmeanx: mean of all tbodygyrojerkmeanx values       
tbodygyrojerkmeany: mean of all tbodygyrojerkmeany values      
tbodygyrojerkmeanz: mean of all tbodygyrojerkmeanz values       
tbodygyrojerkstdx: mean of all tbodygyrojerkstdx values       
tbodygyrojerkstdy: mean of all tbodygyrojerkstdy values        
tbodygyrojerkstdz: mean of all tbodygyrojerkmstdz values       
tbodyaccmagmean: mean of all tbodyaccmagmean values          
tbodyaccmagstd: mean of all tbodyaccmagstd values          
tgravityaccmagmean: mean of all tgravityaccmagmean values       
tgravityaccmagstd: mean of all tgravityaccmagstd values       
tbodyaccjerkmagmean: mean of all tbodyaccjerkmagmean values      
tbodyaccjerkmagstd: mean of all tbodyaccjerkmagstd values      
tbodygyromagmean: mean of all tbodygyromagmean values         
tbodygyromagstd: mean of all tbodygyromagstd values         
tbodygyrojerkmagmean: mean of all tbodygyrojerkmagmean values     
tbodygyrojerkmagstd: mean of all tbodygyrojerkmagstd values     
fbodyaccmeanx: mean of all fbodyaccmeanx values            
fbodyaccmeany: mean of all fbodyaccmeany values           
fbodyaccmeanz: mean of all fbodyaccmeanz values            
fbodyaccstdx: mean of all fbodyaccstdx values            
fbodyaccstdy: mean of all fbodyaccstdy values             
fbodyaccstdz: mean of all fbodyaccstdz values            
fbodyaccjerkmeanx: mean of all fbodyaccjerkmeanx values        
fbodyaccjerkmeany: mean of all fbodyaccjerkmeany values       
fbodyaccjerkmeanz: mean of all fbodyaccjerkmeanz values        
fbodyaccjerkstdx: mean of all fbodyaccjerkstdx values        
fbodyaccjerkstdy: mean of all fbodyaccjerkstdy values         
fbodyaccjerkstdz: mean of all fbodyaccjerkstdz values        
fbodygyromeanx: mean of all fbodygyromeanx values           
fbodygyromeany: mean of all fbodygyromeany values          
fbodygyromeanz: mean of all fbodygyromeanz values           
fbodygyrostdx: mean of all fbodygyrostdx values           
fbodygyrostdy: mean of all fbodygyrostdy values            
fbodygyrostdz: mean of all fbodygyrostdz values          
fbodyaccmagmean: mean of all fbodyaccmagmean values          
fbodyaccmagstd: mean of all fbodyaccmagstd values          
fbodybodyaccjerkmagmean: mean of all fbodybodyaccjerkmagmean values  
fbodybodyaccjerkmagstd: mean of all fbodybodyaccjerkmagstd values  
fbodybodygyromagmean: mean of all fbodybodygyromagmean values     
fbodybodygyromagstd: mean of all fbodybodygyromagstd values 
fbodybodygyrojerkmagmean: mean of all fbodybodygyrojerkmagmean values 
fbodybodygyrojerkmagstd: mean of all fbodybodygyrojerkmagstd values 