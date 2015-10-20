
# one way to execute
# $ cd ~/projects/Classes/FoundationsOfDataScience_sliderule/github/part4_data_wrangling/project
# $ R CMD BATCH ./run_analysis.R

# setup
setwd("~/projects/Classes/FoundationsOfDataScience_sliderule/github/part4_data_wrangling/project")

# packages
library(ggplot2)
suppressMessages(library(psych))
library(plyr)
suppressMessages(library(dplyr))

# Import the data from files

# read in features and activity labels
features   <- read.csv ("UCI_HAR_Dataset/features.txt", sep = ' ', header = FALSE)
colnames(features) <- c("feature_column",  "feature_name")
str(features)

act_labels <- read.csv ("UCI_HAR_Dataset/activity_labels.txt", sep = ' ', header = FALSE)
colnames(act_labels) <- c("activity_class_encoding",  "activity_name")
act_labels$activity_class_encoding <- factor(act_labels$activity_class_encoding)
act_labels

# -----------------
# test set
# -----------------
# $ wc -l test/X_test.txt test/subject_test.txt test/y_test.txt
#     2947 test/X_test.txt
#     2947 test/subject_test.txt
#     2947 test/y_test.txt
    
test_act_labels  <- read.csv ("UCI_HAR_Dataset/test/y_test.txt", sep = ' ', header = FALSE)
dim(test_act_labels)

test_subj_labels  <- read.csv ("UCI_HAR_Dataset/test/subject_test.txt", sep = ' ', header = FALSE)
dim(test_subj_labels)

test_feature_measurements <- read.csv ("UCI_HAR_Dataset/test/X_test.txt", sep = '', header = FALSE)
dim(test_feature_measurements)

# describe(test_feature_measurements)

# check that activity levels have same number of observations as measurements
print(ifelse((dim(test_feature_measurements)[1] != dim(test_act_labels)[1]) &
             (dim(test_feature_measurements)[1] != dim(test_subj_labels)[1]),
             "Error: length mismatch in test data",
             "Good: length match in test data"))

# -----------------
# train set
# -----------------
# wc -l train/X_train.txt train/subject_train.txt train/y_train.txt
#     7352 train/X_train.txt
#     7352 train/subject_train.txt
#     7352 train/y_train.txt    
    
train_act_labels  <- read.csv ("UCI_HAR_Dataset/train/y_train.txt", sep = ' ', header = FALSE)
dim(train_act_labels)

train_subj_labels  <- read.csv ("UCI_HAR_Dataset/train/subject_train.txt", sep = ' ', header = FALSE)
dim(train_subj_labels)

train_feature_measurements <- read.csv ("UCI_HAR_Dataset/train/X_train.txt", sep = '', header = FALSE)
dim(train_feature_measurements)
# describe(train_feature_measurements)

# check that activity levels have same number of observations as measurements
print(ifelse((dim(train_feature_measurements)[1] != dim(train_act_labels)[1]) &
             (dim(train_feature_measurements)[1] != dim(train_subj_labels)[1]),
             "Error: length mismatch in train data",
             "Good: length match in train data"))

# update the column names
colnames(test_act_labels) <- c("activity_class_encoding")
colnames(test_subj_labels) <- c("subject_id")
colnames(test_feature_measurements) = features$feature_name

colnames(train_act_labels) <- c("activity_class_encoding")
colnames(train_subj_labels) <- c("subject_id")
colnames(train_feature_measurements) = features$feature_name

# add activity names
test_feature_measurements$activity <- factor(test_act_labels$activity_class_encoding)
levels(test_feature_measurements$activity) <- act_labels$activity_name

train_feature_measurements$activity <- factor(train_act_labels$activity_class_encoding)
levels(train_feature_measurements$activity) <- act_labels$activity_name

# add subject ID (separate train id from test id)
test_feature_measurements$subjectid <- factor(test_subj_labels$subject_id)
train_feature_measurements$subjectid <- factor(train_subj_labels$subject_id)


#### extract only the measurements on the mean and standard deviation

# helper function
getDesiredColumnIndices <- function (df) {
  columns = grep("-(std|mean)", colnames(df), value=FALSE)
  columns = c(columns, grep("activity", colnames(df), value=FALSE))
  columns = c(columns, grep("subjectid", colnames(df), value=FALSE))
  columns
}

columns <- getDesiredColumnIndices(test_feature_measurements)
test_measurements_subset <- test_feature_measurements[,columns]

columns <- getDesiredColumnIndices(train_feature_measurements)
train_measurements_subset <- train_feature_measurements[,columns]

#### Merges the training and the test sets to create one data set.

# now merge the data frames
feature_measurements <- rbind(train_measurements_subset, 
                              test_measurements_subset)
dim(feature_measurements)

#### Create derived data set with the average of each variable for each activity and each subject.

# use dplyr to group and summarize each variable to its average
tidy_feature_measurements <- feature_measurements %>%
  group_by(subjectid, activity) %>%
  summarise_each(funs(mean)) %>%
  ungroup() %>% 
  arrange()

head(tidy_feature_measurements, 6*3)

# save to a file
saveRDS(tidy_feature_measurements, file="tidydata.Rda")
