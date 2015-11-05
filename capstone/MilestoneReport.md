
# What data is going to be used for this?

The data is available from the competition website [Give Me Some Credit - data](https://www.kaggle.com/c/GiveMeSomeCredit/data). It includes:

| File Name       | Available Formats |
|-----------------|-------------------|
| cs-training     | .csv (7.21 mb)    |
| cs-test         | .csv (4.75 mb)    |
| Data Dictionary | .xls (14.50 kb)   |
| sampleEntry     | .csv (1.82 mb)    |


There is a `training` dataset of 150,000 borrowers, and the `test` dataset contains 101,503 observations, for a sum of over 250,000 borrowers gathered from historical data.

# What is the approach to solving this problem

## Binary classification

The problem is going to be approached as a binary classification problem. Some of the methods commonly used for [binary classification](https://en.wikipedia.org/wiki/Binary_classification) are:<sup id="afootnote3">[3](#footnote3)</sup>

 - Decision trees
 - Random forests
 - Bayesian networks
 - Support vector machines
 - Neural networks
 - Logistic regression


The coursework covers **decision trees**, **random forests**, and **logistic regression** on binary classifiers, so I will focus on these methods.

## Other order of operations

There is likely to be some data cleanup required.

Feature selection will be performed during model creation process.

Evaluation of the model using [AUC (Area-Under-Curve)](https://en.wikipedia.org/wiki/Receiver_operating_characteristic#Area_under_curve) will also be performed, allowing discernment among the predictive capabilities between the different models.

# What are the deliverables?

The goal of this competition is to build a model that can be used to help make the best financial decisions.

Specifically for this course, this will be:

1. R Code and its resulting prediction model (created within the execution of the code)
   1. Also included will be instructions on how to execute the code
1. An "Entry" file (.csv) that contains a probability prediction for each observation in the `cs-test` dataset
   1. There will be an associated [AUC](https://www.kaggle.com/wiki/AreaUnderCurve) score as well that evaluates the predictive power of the model(s).
1. A paper/presentation outlining the process and results.



## Introduction to the Problem

For this capstone project, I chose a completed (no-longer-active) Kaggle project: "[Give Me Some Credit](https://www.kaggle.com/c/GiveMeSomeCredit)".  From its project description:

> Improve on the state of the art in credit scoring by predicting the probability that somebody will experience financial distress in the next two years.

Basically, take some available historical borrower data to model predictions on whether a given borrower profile will default within two years.

### More Background

Banks play a crucial role in market economies. They decide who can get finance and on what terms and can make or break investment decisions.<sup id="afootnote1">[1](#footnote1)</sup> Lenders would prefer to issue loans with low, understandable risk as to whether they will be likely be paid back. At the heart of the decision is available financial information to determine credit-worthiness.<sup id="afootnote2">[2](#footnote2)</sup>:

> Credit scoring algorithms, which make a guess at the probability of default, are the method banks use to determine whether or not a loan should be granted. This competition requires participants to improve on the state of the art in credit scoring, by predicting the probability that somebody will experience financial distress in the next two years.

So they care because they want a more sophisticated predictive model for evaluating loan decisions.


# Description of the available data

This problem came with a [bundled data set](https://www.kaggle.com/c/GiveMeSomeCredit/data).

| File Name       | Available Formats |
|-----------------|-------------------|
| cs-training     | .csv (7.21 mb)    |
| cs-test         | .csv (4.75 mb)    |
| Data Dictionary | .xls (14.50 kb)   |
| sampleEntry     | .csv (1.82 mb)    |

There is a training dataset (`cs-training.csv`) which includes historical information on 150,000 borrowers, including the variable that we are going to try to predict.

The observations where the predictions are going to be made are in the test dataset (`cs-test.csv`), which contains 101,503 observations. These do not contain a value for the variable to be predicted, `SeriousDlqin2yrs`.

Counting both the training and test data, there are 250,000 borrowing scenarios gathered from historical data.


## Salient fields and information in the data set



Variable Name                         |  Description                                                                                                                                               |  Type          |
--------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------|
**SeriousDlqin2yrs**                  |  **Person experienced 90 days past due delinquency or worse**                                                                                              |  **`Y/N`**     |
                                      |                                                                                                                                                            |                |
*Demographics*                        |                                                                                                                                                            |                |
age                                   |  Age of borrower in years                                                                                                                                  |  `integer`     |
NumberOfDependents                    |  Number of dependents in family excluding themselves (spouse, children etc.)                                                                               |  `integer`     |
                                      |                                                                                                                                                            |                |
*Finances*                            |                                                                                                                                                            |                |
DebtRatio                             |  Monthly debt payments, alimony,living costs divided by monthy gross income                                                                                |  `percentage`  |
MonthlyIncome                         |  Monthly income                                                                                                                                            |  `real`        |
                                      |                                                                                                                                                            |                |
*Existing Credit Utilization*         |                                                                                                                                                            |                |
NumberOfOpenCreditLinesAndLoans       |  Number of Open loans (installment like car loan or mortgage) and Lines of credit (e.g. credit cards)                                                      |  `integer`     |
NumberRealEstateLoansOrLines          |  Number of mortgage and real estate loans including home equity lines of credit                                                                            |  `integer`     |
RevolvingUtilizationOfUnsecuredLines  |  Total balance on credit cards and personal lines of credit except real estate and no installment debt like car loans divided by the sum of credit limits  |  `percentage`  |
                                      |                                                                                                                                                            |                |
*Deliquencies*                        |                                                                                                                                                            |                |
NumberOfTime30-59DaysPastDueNotWorse  |  Number of times borrower has been 30-59 days past due but no worse in the last 2 years.                                                                   |  `integer`     |
NumberOfTime60-89DaysPastDueNotWorse  |  Number of times borrower has been 60-89 days past due but no worse in the last 2 years.                                                                   |  `integer`     |
NumberOfTimes90DaysLate               |  Number of times borrower has been 90 days or more past due.                                                                                               |  `integer`     |

## Dataset limitations


## Data Washing and Wrangling

# Preliminary EDA and findings

# Recommended final approach


## Footnotes

<b id="footnote1">1</b> From https://www.kaggle.com/c/GiveMeSomeCredit description [↩](#afootnote1)

<b id="footnote2">2</b> Again, from https://www.kaggle.com/c/GiveMeSomeCredit description [↩](#afootnote2)

<b id="footnote3">3</b> Taken from [Binary classification](https://en.wikipedia.org/wiki/Binary_classification)  [Wikipedia]  [↩](#afootnote3)



### Milestone Report - assignment details
Your Capstone project milestone report is an early draft of your final Capstone report. This is a slightly longer (3-5 page) draft that should have the following:

- An introduction to the problem (based on your earlier Capstone submissions).
- A deeper dive into the data set:
  - What important fields and information does the data set have?
  - What are its limitations i.e. what are some questions that you cannot answer with this data set?
  - What kind of cleaning and wrangling did you need to do?

- Any preliminary exploration you’ve performed and your initial findings.

- Based on these findings, what approach are you going to take? How has your approach changed from what you initially proposed, if applicable?

Basically, the milestone is an opportunity for you to practice your data story skills. We encourage you and your mentor to plan multiple milestones if possible.

Add your code and milestone report to the github repository. As before, once your mentor has approved your milestone document, please share the github repository URL on the community and ask the community for feedback.

