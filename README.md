# Getting-and-Cleaning-Data-W4
Contains script, CodeBook and initial files for the Getting and Cleaning Data Course Project

## run_analysis.R script

This script does all the transformations needed to construct the demanded tidy dataset.

For it to work, ensure the following:

1. Download the UCI HAR Dataset folder
2. In RStudio, set the working directory in the parent folder of UCI HAR Dataset
3. Ensure you have installed and imported the dplyr library

### run_analysis function
This is the main function to call in order to perform the transformations.

**Parameters** : no parameters

**Return** : returns a list containing both required datasets

After setting the script as a source, type the following in order to retrieve the 2 datasets:

```
resultList <- run_analysis()
View(resultList$MergedDataSet)
View(resultList$TidyDataSet)
```
The script does the following:
- Loads the required datasets and creates the corresponding dataframes
- Adds columns SUbject and Activity to the train et test sets
- Merges the 2 sets in the total_set variable
- From the features dataframe, it extracts only the features which contain either mean or std in the name with a regex pattern
- The Activity column is trasnformed to Factor and the levels are changed to match the correct activity labels
- The variables are renamed by applying the renameVar function
- The final tidy dataset is contructed with the summarise_all() function
- A list containing both datasets is returned: the resulting dataset in step 4 is called MergedDataSet and the dataset from step 5 is called TidyDataSet

### renameVar function
This is a helper function used by run_analysis.
It modifies the name of a feature as described in the CodeBook.
- According to the first character of the initial name, we replace it with "Time" if it's "t", or "Freq" if it's "f"
- We split the initial name by the "-" character and capialize the first letter of each resulting substring
- We join the strings back together with no space
- Finally, we delete the ()

**Parameters** : initial name

**Return** : modified name
