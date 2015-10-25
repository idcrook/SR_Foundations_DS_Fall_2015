# Unit 4 - "Keeping an Eye on Healthcare Costs" Lecture


# VIDEO 6

setwd("~/projects/Classes/FoundationsOfDataScience_sliderule/github/part5_analytics/15.071x_The_Analytics_Edge/Unit04_Trees")

# Read in the data
Claims = read.csv("ClaimsData.csv")

str(Claims)

# Percentage of patients in each cost bucket
table(Claims$bucket2009)/nrow(Claims)

# Split the data
library(caTools)

set.seed(88)

spl = sample.split(Claims$bucket2009, SplitRatio = 0.6)

ClaimsTrain = subset(Claims, spl==TRUE)

ClaimsTest = subset(Claims, spl==FALSE)

########

mean(ClaimsTrain$age)
table(ClaimsTrain$diabetes)

# VIDEO 7

# Baseline method
table(ClaimsTest$bucket2009, ClaimsTest$bucket2008)

(110138 + 10721 + 2774 + 1539 + 104)/nrow(ClaimsTest)
110138/nrow(ClaimsTest)

# Penalty Matrix
PenaltyMatrix = matrix(c(0,1,2,3,4,2,0,1,2,3,4,2,0,1,2,6,4,2,0,1,8,6,4,2,0), byrow=TRUE, nrow=5)

PenaltyMatrix

# Penalty Error of Baseline Method
as.matrix(table(ClaimsTest$bucket2009, ClaimsTest$bucket2008))*PenaltyMatrix

sum(as.matrix(table(ClaimsTest$bucket2009, ClaimsTest$bucket2008))*PenaltyMatrix)/nrow(ClaimsTest)


####

table(ClaimsTrain$bucket2008) / sum(as.matrix(table(ClaimsTrain$bucket2008)))

table(ClaimsTest$bucket2008) / sum(as.matrix(table(ClaimsTest$bucket2008)))

PenaltyRowMatrix = matrix(c(0,2,4,6,8), byrow=TRUE, nrow=5)
PenaltyRowMatrix

sum(as.matrix(table(ClaimsTest$bucket2008))*PenaltyRowMatrix)/nrow(ClaimsTest)

###
110138/nrow(ClaimsTest)

as.matrix(table(ClaimsTest$bucket2009, ClaimsTest$bucket2008)[,])

PenaltyRowMatrix

###

table(ClaimsTest$bucket2009)
122978/nrow(ClaimsTest) 
# > 0.67127
(0*122978 + 2*34840 + 4*16390 + 6*7937 + 8*1057)/nrow(ClaimsTest) 
# > 1.044301

### 
table(ClaimsTest$bucket2009) / sum(as.matrix(table(ClaimsTest$bucket2009)))

PenaltyRowMatrix = matrix(c(0,2,4,6,8), byrow=TRUE, nrow=5)
sum(as.matrix(table(ClaimsTest$bucket2009))*PenaltyRowMatrix)/nrow(ClaimsTest)
# > 1.044301


# VIDEO 8

# Load necessary libraries
library(rpart)
library(rpart.plot)

# CART model
ClaimsTree = rpart(bucket2009 ~ age + arthritis + alzheimers + cancer + copd + depression + diabetes + heart.failure + ihd + kidney + osteoporosis + stroke + bucket2008 + reimbursement2008, data=ClaimsTrain, method="class", cp=0.00005)

prp(ClaimsTree)


# Make predictions
PredictTest = predict(ClaimsTree, newdata = ClaimsTest, type = "class")

table(ClaimsTest$bucket2009, PredictTest)

(114141 + 16102 + 118 + 201 + 0)/nrow(ClaimsTest)

# Penalty Error
as.matrix(table(ClaimsTest$bucket2009, PredictTest))*PenaltyMatrix

sum(as.matrix(table(ClaimsTest$bucket2009, PredictTest))*PenaltyMatrix)/nrow(ClaimsTest)

# New CART model with loss matrix
ClaimsTree = rpart(bucket2009 ~ age + alzheimers + arthritis + cancer + copd + depression + diabetes + heart.failure + ihd + kidney + osteoporosis + stroke + bucket2008 + reimbursement2008, data=ClaimsTrain, method="class", cp=0.00005, parms=list(loss=PenaltyMatrix))

# Redo predictions and penalty error
PredictTest = predict(ClaimsTree, newdata = ClaimsTest, type = "class")

table(ClaimsTest$bucket2009, PredictTest)

(94310 + 18942 + 4692 + 636 + 2)/nrow(ClaimsTest)

sum(as.matrix(table(ClaimsTest$bucket2009, PredictTest))*PenaltyMatrix)/nrow(ClaimsTest)

####

nrow(ClaimsTest)
table(ClaimsTest$bucket2009, PredictTest)[,1]
sum(table(ClaimsTest$bucket2009, PredictTest)[,1])
106515 / 183202



