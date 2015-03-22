### Getting & Cleaning Data Course Project
-------------------------------------------

#### <ins>Brief Introduction</ins>

This project is based on one of the most exciting areas in all of data science right now, which is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website and also in the link given below, represent data collected from the accelerometers from the Samsung Galaxy S smartphone and we have to use this data for our project and perform some computations and processing on it.


#### <ins>Main Objective</ins>

The main objective of this project is to demonstrate our ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. The main deliverables for this project are as follows.

	1) a tidy data set as described below
	2) a link to a Github repository with your script for performing the analysis
	3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md
	4) a readme file namely README.md explaining how to run the script, what it does and how it works

###Step1

Read in all data sets from test set and training set. there are a total of 3 files each
Bind all the data together. This is relatively straight forward

###step 2

Extract the mean and standard deviation as required by using sapply, with na.rm=TRUE. this allows us to ignore any missing entries in the data. 


###Step3

First read the activity labels from the data downloaded
After which map each number to the corresponding labels. for example 2 will be walking etc. 

###step4

Load in the data from the features file
For the main file from the test and training set, change the column names to the column names found in the feature file.
Similarly change the column name of the activity files to activity and subject file to subject

###step 5

Tidy up the data together. 
The last code tidy_data<-DT[,lapply(.SD,mean),by="Activity,Subject"] may be relatively new. 
Means for each possible data subset by "Activity, Subject", calculate the mean passing through lapply of each single element. More information can be found at 

http://cran.r-project.org/web/packages/data.table/data.table.pdf



The script will create the tidy data unto your working directory.
-Do not run the last line if you do not wish to have a new file. 

#### <ins>Script Execution Instructions</ins>

The following are the main steps to be reproduced to execute the scripts and get the required tidy datasets.

 - Download the `UCI HAR Dataset` if you haven't done so already by clicking this link: [Download dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
 - Extract the downloaded zip file to a location of your choice in your system 
 - Download the `run_analysis.R` file from this repository and copy and paste it inside the `UCI HAR Dataset` folder
 
 - Now you should execute the `run_analysis.R` script. It can be done in two ways, please use the one you find most convenient.
 	- __Using RStudio:__
 	 	* Open up RStudio IDE first and open the `run_analysis.R` script file if you want to see the code.

		* Now execute the script using the following command in the R console.
      * Finally go to the `UCI HAR Dataset` from your file explorer to see the output datasets.

 - After running the script, go to the `UCI HAR Dataset` folder as told and you can see some new files, namely, `clean_data.csv` and `tidy_data.csv` which are the two tidy datasets as we were directed to create in the project. The detailed contents of the datasets are explained in the `CodeBook.md` file. The `clean_data.txt` and `tidy_data.txt` are just tab-separated text file versions which contain the same data as the CSV files. If needed, open up the files using appropriate applications to examine their contents.   
           
#### <ins>Script Working Details</ins>

The following points highlight the key working of the `run_analysis.R` script in detail and focus is mainly on the working. For more details about data frames, variables and datasets have been discussed in the `CodeBook.md` file. Please refer to it as and when needed.

 - First it reads in the required feature data from the files `X_train.txt` and `X_test.txt` and combines them to form the `featureData` data frame with dimensions of `10299 x 561`
 - Next, it reads in the respective activity identifiers from the files `y_train.txt` and `y_test.txt` and combines them to form the  `activityLabels` data frame with dimensions of `10299 x 1`
 - Next, it reads in the respective subject identifiers ( people ) from the files `subject_train.txt` and `subject_test.txt` and combines them to form the  `subjectLabels` data frame with dimensions of `10299 x 1`
 - Next, it reads in the feature names from the files `features.txt` and stores it in the `featureNames` vector with dimensions of `561 x 1`. From this, we get the required feature indices using the `grep` command for features having mean and std and store the indices in the `reqdfeatureIndices` vector of size `66 x 1`
 - Then, we get the required subset of features from `featureData` using the `reqdfeatureIndices` vector and get our final feature set with dimensions of `10299 x 66`
 - Now, we read the different activity names corresponding to the activity identifiers from the `activity_labels.txt` file and transform the activity ids in the `activityLabels` data frame to form a new data frame `activityData` of size `10299 x 1`
 - Finally we combine the three dataframes, `subjectLabels`, `activityData` and `featureData` to form the data frame `cleanData` with dimensions `10299 x 68`. This is the first required tidy data set and we write it to the files `clean_data.csv` and `clean_data.txt` both having the same content.
 - Now, we load the `reshape2` package which will be required for creating the next tidy data set.
 - Next, we set our identifier and measure variables as `idVars` and `measureVars` respectively and then we convert our `cleanData` data frame into a molten data frame `meltedData` with dimensions of `679734 x 4` using the `melt` function.
 - Now, we decast our molten data frame into the required aggregated data frame where each feature is averaged per person ( `subjectid` ) per activity ( `activityname` ) using the `dcast` function, and we get our second required tidy data set `tidyData` which is a data frame having dimensions `180 x 68`
 - We write this tidy data set to the files `tidy_data.csv` and `tidy_data.txt` both having the same content.
