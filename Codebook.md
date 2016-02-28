This codebook describes the data, the variables and data processing steps for this analysis.
•	Data obtained from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
•	For the purpose of this project, the data used is https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
The main steps of the analysis are:
•	Reading the test , train, test variables, train variables, subjects,  stored into train_df, test_df, names_train_df,  names_test_df, trained and tested respectively.
•	Merge all these data frames into one tidy data frame for the subsequent analysis steps
o	joined_df  = train_df and test_df,
o	joined_label =  names_train_df and names_test_df
o	Joined_subj = trained and tested
•	Mean and standard deviation variables are extracted into meanstd
•	The dataset is saved into the ‘performance.txt’
•	The data is collapsed by subject and activity and saved into ‘average_tidy.txt’
