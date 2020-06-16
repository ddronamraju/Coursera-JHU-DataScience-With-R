Content Download
1.Downloaded zip file into a local folder and unzipped the contents
2. Created Four data tables x_train, x_test, y_train, y_test using files in the train and test folders

Combining Train and Test data
3. To answer question # 1, combined x_train, x_test to x_dt and y_train, y_test into y_dt using the rbindlist function of data table

Extracting Mean and STD columns from the dataset
4. Extracted the feature names into a data table from the features.txt file.
5. Used grep to find the columns containing the strings mean or std

Filtering out relevant columns
6. Created a new dataframe x_dt_wanted only with the relevant columns
7. Renamed all the columns correctly

Adding Activity labels
8. Combined the y_dt Activity column with x_dt_wanted and updated the Activity IDs with Activity names using gsub

Adding Subject IDs
9. Extracted Subject IDS from Subject_train and Subject_test files
10. Combined along with x_dt_wanted

Grouping and Summarizing to get Tidy Table
11. Used Dplyr's Group by and Summarize functions to determine mean of all columns by Subject and Activity

Writing final output table
12. Downloaded the final output table to FinalData.txt file