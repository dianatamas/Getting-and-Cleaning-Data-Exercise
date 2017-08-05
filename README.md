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

### renameVar function
This is a helper function used by run_analysis.
It modifies the name of a feature as described in the CodeBook.

**Parameters** : initial name

**Return** : modified name
