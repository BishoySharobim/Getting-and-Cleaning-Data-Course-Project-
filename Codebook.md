# Study design

This codebook is a codebook for an independent analysis performed on a set of measurements recorded from an external human activity recognition experiment.  The experiment was carried out with a group of 30 volunteers within an age bracket of 19-48 years. The number of records taken were 102,999 and the date the results were donated was 2012-12-10. Each person performed and was measured on 6 activities: (1) Walking, (2) Walking upstairs, (3) Walking downstairs, (4) Sitting, (5) Standing and (6) Laying. The measurement was undertaken using a smartphone (Samsung Galaxy S II) on the waist. 

## Description of the data 

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix ‘t’ to denote time) were captured at a constant rate of 50 Hz. and the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) – both using a low pass Butterworth filter.

The body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

A Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the ‘f’ to indicate frequency domain signals).

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern: 
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJ
* JerkMag

The set of variables that were estimated from these signals are: 

* mean(): Mean value
* std(): Standard deviation
* mad(): Median absolute deviation 
* max(): Largest value in array
* min(): Smallest value in array
* sma(): Signal magnitude area
* energy(): Energy measure. Sum of the squares divided by the number of values. 
* iqr(): Interquartile range 
* entropy(): Signal entropy
* arCoeff(): Autorregresion coefficients with Burg order equal to 4
* correlation(): correlation coefficient between two signals
* maxInds(): index of the frequency component with largest magnitude
* meanFreq(): Weighted average of the frequency components to obtain a mean frequency
* skewness(): skewness of the frequency domain signal 
* kurtosis(): kurtosis of the frequency domain signal 
* bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
* angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

* gravityMean
* tBodyAccMean
* tBodyAccJerkMean
* tBodyGyroMean
* tBodyGyroJerkMean 

The complete list of variables of each feature vector is available in 'features.txt'

In total, 561 variables were recorded, whether measured directly or indirectly from the smartphone’s signals. Additionally, the obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.  For more detailed information about the variables measured and deduced in the experiment and how they were measured, I refer you to the documentation of the experiment found at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

In this particular analysis of mine, only variables that are a mean and standard deviation were considered. This was done because I did not intend my analysis to be a very thorough project, but rather to focus on a few key characteristics of the results of the experiment. This amounted to considering 68 variables, including the activity (i.e. walking, walking upstairs and the other 4 activities) and subject variables (i.e. 1 – 30). Note, by my own judgement, I chose not to include variables that are a meanFrequency.

# How I got my tidy dataset

1. I read into R using read.table the following data sets.

Description | File name | Dimensions
------------|-----------|-----------
Raw training data|X_train.txt|7352 x 561
Raw test data|X_test.txt|2947 x 561
Activity number corresponding to each record in the train data|y_train.txt|7352 x 1
Activity number corresponding to each record in the test data|y_test.txt|2947 x 1
Subject number corresponding to each record in the raw train data|subject_test.txt|7352 x 1
Subject number corresponding to each record in the raw test data|subject_train.txt|2947 x 1
Variable names|features.txt|561 x 2

2. I added the variable labels as names to both the raw training and the raw test data using a row bind.
3. For the activity and subject information that belongs to the raw training data, I column bound it to the raw training data.  I did the same for the test data.
4. I merged the training and test data sets from step 3 using a row bind matching up their 561 columns. Thus, I produced one large data set which exceeded 25 MB as an object on R.
5. I then replaced the activity number variables i.e. 1, 2, 3, … 6 with their qualitative labels. These labels correspond to the same order of the activities as in the first paragraph in this study design (in red text). 
6. I appropriately labelled the data set variable names with more descriptive terminology. I did this using the gsub function and regular expressions on R. For example…

 *“Acc” = “Acceleration”
 * “Gyro” = “Gyroscope”
 * “Mag” = “Magnitude”
 * “std” = “STD” for emphasis
 * “mean” = “MEAN” for emphasis
 * “f” = “Frequency”
 * “t” = “time”
 * “BodyBody” = “Body”
 * I also removed parentheses.

7. Using the dpply function from the plyr package, I created a second, independent tidy data set with the average of each variable for each activity and each subject. This gave me a data set of dimensions of 180 x 68.

8. I wrote this tidy data set into a text file using write.table.


# Variables
The definitions of some terms in the variables are as follows…
 
* Jerk: sudden movement of the body
* Body: acceleration related to the body
* Gyroscope: angular velocity
* Gravity: acceleration due to gravity
* Magnitude: magnitude of the movement
* Mean: mean value
* Standard deviation: standard deviation of values
* X-axis: movement in the x-direction
* Y-axis: movement in the y-direction
* Z-axis: movement in the z-direction

In relation to the units, the acceleration signals are measured in standard gravity units ‘g’. The body acceleration was taken from subtracting the acceleration due to gravity from the measured acceleration. And angular velocity as measured by the gyroscope is measured in radians/second.

No.|Old variable|Variable in tidy data
--|---|---
1|Subject|subject
2|Activity|activity
3|tBodyAcc-mean()-X|timeBodyAcceleration-MEAN-X
4|tBodyAcc-mean()-Y|timeBodyAcceleration-MEAN-Y
5|tBodyAcc-mean()-Z|timeBodyAcceleration-MEAN-Z
6|tBodyAcc-std()-X|timeBodyAcceleration-STD-X
7|tBodyAcc-std()-Y|timeBodyAcceleration-STD-Y
8|tBodyAcc-std()-Z|timeBodyAcceleration-STD-Z
9|tGravityAcc-mean()-X|timeGravityAcceleration-MEAN-X
10|tGravityAcc-mean()-Y|timeGravityAcceleration-MEAN-Y
11|tGravityAcc-mean()-Z|timeGravityAcceleration-MEAN-Z
12|tGravityAcc-std()-X|timeGravityAcceleration-STD-X
13|tGravityAcc-std()-Y|timeGravityAcceleration-STD-Y
14|tGravityAcc-std()-Z|timeGravityAcceleration-STD-Z
15|tBodyAccJerkmean()-X|timeBodyAccelerationJerk-MEAN-X
16|tBodyAccJerkmean()-Y|timeBodyAccelerationJerk-MEAN-Y
17|tBodyAccJerkmean()-Z|timeBodyAccelerationJerk-MEAN-Z
18|tBodyAccJerkstd()-X|timeBodyAccelerationJerk-STD-X
19|tBodyAccJerkstd()-Y|timeBodyAccelerationJerk-STD-Y
20|tBodyAccJerkstd()-Z|timeBodyAccelerationJerk-STD-Z
21|tBodyGyro-mean()-X|timeBodyGyroscope-MEAN-X
22|tBodyGyro-mean()-Y|timeBodyGyroscope-MEAN-Y
23|tBodyGyro-mean()-Z|timeBodyGyroscope-MEAN-Z
24|tBodyGyro-std()-X|timeBodyGyroscope-STD-X
25|tBodyGyro-std()-Y|timeBodyGyroscope-STD-Y
26|tBodyGyro-std()-Z|timeBodyGyroscope-STD-Z
27|tBodyGyroJerkmean()-X|timeBodyGyroscopeJerk-MEAN-X
28|tBodyGyroJerkmean()-Y|timeBodyGyroscopeJerk-MEAN-Y
29|tBodyGyroJerkmean()-Z|timeBodyGyroscopeJerk-MEAN-Z
30|tBodyGyroJerkstd()-X|timeBodyGyroscopeJerk-STD-X
31|tBodyGyroJerkstd()-Y|timeBodyGyroscopeJerk-STD-Y
32|tBodyGyroJerkstd()-Z|timeBodyGyroscopeJerk-STD-Z
33|tBodyAccMag-mean()|timeBodyAccelerationMagnitude-MEAN
34|tBodyAccMag-std()|timeBodyAccelerationMagnitude-STD
35|tGravityAccMag-mean()|timeGravityAccelerationMagnitude-MEAN
36|tGravityAccMag-std()|timeGravityAccelerationMagnitude-STD
37|tBodyAccJerkMag-mean()|timeBodyAccelerationJerkMagnitude-MEAN
38|tBodyAccJerkMag-std()|timeBodyAccelerationJerkMagnitude-STD
39|tBodyGyroMag-mean()|timeBodyGyroscopeMagnitude-MEAN
40|tBodyGyroMag-std()|timeBodyGyroscopeMagnitude-STD
41|tBodyGyroJerkMag-mean()|timeBodyGyroscopeJerkMagnitude-MEAN
42|tBodyGyroJerkMag-std()|timeBodyGyroscopeJerkMagnitude-STD
43|fBodyAcc-mean()-X|frequencyBodyAcceleration-MEAN-X
44|fBodyAcc-mean()-Y|frequencyBodyAcceleration-MEAN-Y
45|fBodyAcc-mean()-Z|frequencyBodyAcceleration-MEAN-Z
46|fBodyAcc-std()-X|frequencyBodyAcceleration-STD-X
47|fBodyAcc-std()-Y|frequencyBodyAcceleration-STD-Y
48|fBodyAcc-std()-Z|frequencyBodyAcceleration-STD-Z
49|fBodyAcc-meanFreq()-X|frequencyBodyAccelerationJerk-MEAN-X
50|fBodyAcc-meanFreq()-Y|frequencyBodyAccelerationJerk-MEAN-Y
51|fBodyAcc-meanFreq()-Z|frequencyBodyAccelerationJerk-MEAN-Z
52|fBodyAccJerkmean()-X|frequencyBodyAccelerationJerk-STD-X
53|fBodyAccJerkmean()-Y|frequencyBodyAccelerationJerk-STD-Y
54|fBodyAccJerkmean()-Z|frequencyBodyAccelerationJerk-STD-Z
55|fBodyAccJerkstd()-X|frequencyBodyGyroscope-MEAN-X
56|fBodyAccJerkstd()-Y|frequencyBodyGyroscope-MEAN-Y
57|fBodyAccJerkstd()-Z|frequencyBodyGyroscope-MEAN-Z
58|fBodyAccJerkmeanFreq()-X|frequencyBodyGyroscope-STD-X
59|fBodyAccJerkmeanFreq()-Y|frequencyBodyGyroscope-STD-Y
60|fBodyAccJerkmeanFreq()-Z|frequencyBodyGyroscope-STD-Z
61|fBodyGyro-mean()-X|frequencyBodyAccelerationMagnitude-MEAN
62|fBodyGyro-mean()-Y|frequencyBodyAccelerationMagnitude-STD
63|fBodyGyro-mean()-Z|frequencyBodyAccelerationJerkMagnitude-MEAN
64|fBodyGyro-std()-X|frequencyBodyAccelerationJerkMagnitude-STD
65|fBodyGyro-std()-Y|frequencyBodyGyroscopeMagnitude-MEAN
66|fBodyGyro-std()-Z|frequencyBodyGyroscopeMagnitude-STD
67|fBodyGyro-meanFreq()-X|frequencyBodyGyroscopeJerkMagnitude-MEAN
68|fBodyGyro-meanFreq()-Y|frequencyBodyGyroscopeJerkMagnitude-STD

