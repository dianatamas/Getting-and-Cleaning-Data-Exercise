## Main method returning the 2 data sets
run_analysis <- function() {
  ## Load the data sets
  x_train <- read.table("./UCI HAR Dataset/train/X_train.txt",header = FALSE);
  y_train <- read.table("./UCI HAR Dataset/train/y_train.txt",header = FALSE);
  train_subjects <- read.table("./UCI HAR Dataset/train/subject_train.txt",header = FALSE);
  x_test <- read.table("./UCI HAR Dataset/test/X_test.txt",header = FALSE);
  y_test <- read.table("./UCI HAR Dataset/test/y_test.txt",header = FALSE);
  test_subjects <- read.table("./UCI HAR Dataset/test/subject_test.txt",header = FALSE);
  activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE);
  features <- read.table("./UCI HAR Dataset/features.txt", header = FALSE);
  
  
  ## Prepare the train dataset
  train_set <- cbind(y_train,x_train);
  train_set <- cbind(train_subjects,train_set);
  
  ## Prepare the test dataset
  test_set <- cbind(y_test,x_test);
  test_set <- cbind(test_subjects,test_set);
  
  ## Merge the 2 sets
  total_set <- rbind(train_set,test_set);
  names(total_set) [[1]] = "Subject";
  names(total_set) [[2]] = "Activity";
  
  ## Select only variables which contain mean or std in the feature name
  features <- features %>%
    filter(grepl("*mean*",V2) | grepl("*std*",V2)) %>%
    mutate(V1 = V1 + 2);
  total_set <- select(total_set, subject, activity, features$V1);
  
  ## Put the activity labels
  total_set$activity <- as.factor(total_set$activity);
  levels(total_set$activity) <- activity_labels$V2;
  
  ## Rename variables
  features <- mutate(features, name = sapply(V2,renameVar));
  names(total_set) <- c("Subject","Activity",features$name);
  
  ## Summarize data grouped by subject and by activity
  tidy_set <- total_set %>% group_by(Subject,Activity) %>% summarise_all(mean);
  
  ## Return a list containing the 2 data sets
  resultList <- list("MergedDataSet" = total_set, "TidyDataSet" = tidy_set);
  return(resultList);
}

## Method to change the name of a variable
renameVar <- function(origin) {
  ## Replace first character by Time or Freq
  newName <- "";
  firstChar <- substr(origin,1,1);
  if(firstChar == "t") {newName <- "Time";}
  else if (firstChar == "f") {newName <- "Freq";}
  else {newName <- firstChar;}
  
  ## Replace "-" by "" and capitalize first letters
  splitOrigin <- strsplit(substring(origin,2),"-");
  capFirstLetter <- function(x) {
    paste0(toupper(substring(x,1,1)),substring(x,2),collapse="");
  }
  splitOrigin <- sapply(splitOrigin,capFirstLetter);
  newName <- paste0(newName,splitOrigin,collapse = '');
  
  ## Delete ()
  newName <- gsub("\\(\\)","",newName);
  return (newName);
}
