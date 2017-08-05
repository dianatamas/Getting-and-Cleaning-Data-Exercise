# CodeBook for the Getting and Cleaning Data project

The project aims to create a tidy dataset based on the Human Activity Recognition Using Smartphones Dataset, built from the recordings of 30 subjects performing activities of daily living while carrying a waist-mounted smartphone with embedded inertial sensors.

3-axial linear acceleration and 3-axial angular velocity were captured at a constant rate of 50Hz. The obtained dataset has been randomly partitioned into two sets, the training data and the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed and then sampled in fixed-width sliding windows. The sensor acceleration signal, which has gravitational and body motion components, was separated into body acceleration and gravity.

From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

## The dataset includes the following files:

- 'features_info.txt': Shows information about the variables used on the feature vector
- 'features.txt': List of all features
- 'activity_labels.txt': Links the class labels with their activity name
- 'train/X_train.txt': Training set containing the measurements for each feature
- 'train/y_train.txt': Training labels containing the activity id
- 'train/subject_train.txt': Each row identifies the subject who performed the activity. Its range is from 1 to 30. 
- 'test/X_test.txt': Test set containing the measurements for each feature
- 'test/y_test.txt': Test labels containing the activity id
- 'test/subject_test.txt': Each row identifies the subject who performed the activity. Its range is from 1 to 30. 

Features are normalized and bounded within [-1,1].

Each feature vector is a row on the text file.

## Resulting tidy dataset

The initial data has been cleaned and reshaped in order to construct a tidy dataset. 
Below you can find a snippet of the resulting dataset.

| Subject  | Activity | TimeBodyAccMeanX | TimeBodyAccMeanY | TimeBodyAccMeanZ |
| ------------- | ------------- | ------------- | ------------- | ------------- |
| 1  | WALKING  | 0.2773308 | -0.017383819 | -0.11114810 |
| 1  | WALKING_UPSTAIRS | 0.2554617 | -0.023953149 | -0.09730200 |

The actual dataset contains 180 rows and 81 columns.

### Variables
- **Subject**: Numeric, ranged from 1 to 30, contains the ID of the subject performing the activity
- **Activity**: Factor with WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING and LAYING levels, contains the labels for each activity being performed
- **Feature variables**: Numeric, contains the average value of that feature for each subject and each activity

## Performed transformations

This section contains all transformations performed on the initial dataset.

### Merger of the train and test datasets

1. Import the X_train.txt, y_train.txt, subject_train.txt files
2. Bind them together in order to have the Subject and Activity columns in the X_train set
3. Repeat steps 1 & 2 for the test dataset
4. Merge the 2 resulting datasets together

### Select only the features which contain mean or std in their name
1. Import the features.txt file
2. Filter so that only the features which contain mean or std remain - there are 79 corresponding features
3. Select only those features from the merged dataset 

### Modify the Activity column so that it contains the activity labels
1. Import the activity_labels.txt file which contains the mapping between the activity ID and its label
2. Change the Activity column of the merged dataset

### Modify the name of the feature columns
1. Import the features.txt file which contains the initial feature names
2. If the feature name starts with t, replace it with "Time" and if it starts with "f", replace it with "Freq"
3. Split the name by the "-" character
4. Capitalize the first letter of the newly split vector
5. Concatenante the vector back, with no space in between words
6. Delete all () characters

tBodyAcc-mean()-X becomes TimeBodyAccMeanX

### Summarize data by subject and activity
1. Group the resulting dataset by Subject and then Activity
2. Summarize it so as to have the mean of each feature, for each subject and each activity

