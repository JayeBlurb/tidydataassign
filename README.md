#Getting and Cleaning Data - tidy_data.txt
The run_analysis.R script generates the output tidy_data.txt file based on HCI HAR Dataset.

The script has only one function which is the run_analysis function which takes the file path of the follow files:
- activity_labels.txt
- features.txt
- X_test.txt
- y_test.txt
- X_train.txt
- y_train.txt

If no filepaths are provided the run_analsysi function will assumpt the script is saved in side the UCI HAR Dataset folder by default.

The following are steps performed in run_analysis function:
1. Load activity_labels.txt, features.txt, X_test.txt, y_test.txt, X_train.txt, and y_train.txt.
2. Combine the X_train.txt and y_train.txt to traindata dataframe
3. Combine the X_test.txt and y_test.txt to testdata dataframe
4. Merge the traindata and testdata dataframe to allsubjectdata dataframe
5. Rename the allsubjectdata dataframe using the vector names in features.txt
6. Merge the allsubjectdata with activity_data.txt
7. Extract any measures contain mean() or std() in the names to subsetdata dataframe
8. create the averagedata that takes the average of each variable for each activity and subject
9. write the averagedata to tidy_data.txt as output




