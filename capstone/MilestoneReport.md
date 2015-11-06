

## Introduction to the Problem

A completed Kaggle project, "[Give Me Some Credit](https://www.kaggle.com/c/GiveMeSomeCredit)", was chosen for this capstone project. From its project description:

> Improve on the state of the art in credit scoring by predicting the probability that somebody will experience financial distress in the next two years.

Basically, use available historical borrower data to model predictions on whether a set of given borrower profiles will encounter a loan default situation within two years.  This is a classification problem, and is well-defined: make a probability-of-financial-distress prediction for a provided test set.

### More Background

Banks play a crucial role in market economies. They decide who can get finance and on what terms and can make or break investment decisions.<sup id="afootnote1">[1](#footnote1)</sup> Lenders would prefer to issue loans with low, understandable risk and have an estimation upon whether or not they will be paid back.

At the heart of the decision process is applying available financial information to determine credit-worthiness:

> Credit scoring algorithms, which make a guess at the probability of default, are the method banks use to determine whether or not a loan should be granted. This competition requires participants to improve on the state of the art in credit scoring, by predicting the probability that somebody will experience financial distress in the next two years.<sup id="afootnote2">[2](#footnote2)</sup>

Banks would like to predict ahead of time (i.e., before they issue a loan) the chances of a likely default event ("financial distress") occurring. This problem will explore producing such a model to increase the probability of predicting correctly.


## Description of the available data

This problem came with a [bundled data set](https://www.kaggle.com/c/GiveMeSomeCredit/data).

| File Name       | Available Formats |
|-----------------|-------------------|
| cs-training     | .csv (7.21 mb)    |
| cs-test         | .csv (4.75 mb)    |
| Data Dictionary | .xls (14.50 kb)   |
| sampleEntry     | .csv (1.82 mb)    |

There is a training dataset (`cs-training.csv`) which includes historical information on 150,000 borrowers. The training set includes a value for the variable to predict, named `SeriousDlqin2yrs`. This is a binary variable of whether "*Person experienced 90 days past due delinquency or worse*".

The observations where the predictions are going to be graded for accuracy are found in the test dataset (`cs-test.csv`). The test dataset contains 101,503 observations. These observations **do not** contain a value for the variable to be predicted, `SeriousDlqin2yrs`, and the task is to provide a predicted value, a probability.

Counting both the training and test data, there are over 250,000 observations gathered from historical borrowing data.


### Important fields and information in the data set

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

### Data Cleaning

Like any other real-world data set, the data contains outliers, missing values, and other suspect details.

I've gathered more extensive notes in [EDA.Rmd](GiveMeSomeCredit/EDA.Rmd), and will provide a summary here, specifically on the `cs-training` dataset.

#### General

The first columns is simply the observation number, and the variable can be dropped. Otherwise the data is tidy, with each row a complete observation, and each column a variable.

#### Demographics variables

**age** - One of the age values is 0. impute? or drop?  Many are over age 90 and even over age 100. Are these accurate?
**NumberOfDependents** - There are a couple of suspect outliers (>10), but otherwise seems reasonable. Contains **NA**s. perhaps convert to mean or median value?

#### Finances variables

**DebtRatio** - Large spread with some very high values in this. For example, *median* of `0.4` and *mean* of `353`
**MonthlyIncome** - Also many outliers in this.  Contains  **NA**s. Perhaps convert to median value? `log(cs$MonthlyIncome + 1)` produces a boxplot with a visible IQR and contains outliers above and below.

#### Existing Credit Utilization variables

**NumberOfOpenCreditLinesAndLoans**, **NumberRealEstateLoansOrLines** - A few of these seem unrealistically high. Are they accurate?
**RevolvingUtilizationOfUnsecuredLines** - some extremely large outliers in this variable; perhaps drop outliers from model data?

#### Deliquencies variables

**NumberOfTime30-59DaysPastDueNotWorse**, **NumberOfTime60-89DaysPastDueNotWorse**, **NumberOfTimes90DaysLate**
There are `5` occurrences of `96` and `264` occurrences of `98` in each of these variables. These are nonsensical values, and should be converted to **NA**.


## Preliminary Exploration and Findings

### Feature Discovery

It is likely that combining variables in a smart way or deriving additional variables from the existing variables will lead to better models.  This is what is meant by *feature engineering*.  This aspect still needs additional exploration, but a couple features were created that seem to have significance.

**MonthlyExpenses** - `DebtRatio` multipled by `MonthlyIncome`
**NetMonthlySurplus** - `MonthlyIncome` minus `MonthlyExpenses`


## Recommended Final Approach

The plan is to still evaluate among the **decision tree**, **random forest**, and **logistic regression** binary classifiers covered in the coursework. Once models are built and iterated, it will be determined which approaches have the best predictive results.

Additional feature identification and engineering is needed during the building and evaluation of models.

Evaluation of the model using [AUC (Area-Under-Curve)](https://en.wikipedia.org/wiki/Receiver_operating_characteristic#Area_under_curve) will be performed, allowing discernment among the predictive capabilities between the different models.  Kaggle website will provide grading AUC based on `cs-test` dataset predictions.

### Boosting and Other Binary Classifiers

The following binary classifiers<sup id="afootnote3">[3](#footnote3)</sup> were not covered in the course, but may be explored if time permits:

- Bayesian networks
- Support vector machines
- Neural networks
- Genetic algorithms

Possibly boosting could additionally be used to improve upon the simpler model result. This method was not covered in course materials, but can often lead to better predictive models.

Like Random Forests, boosting is an ensemble method in that the overall fit is produced from many trees. In Boosting<sup id="afootnote4">[4](#footnote4)</sup>:

1. Fit the data with a single tree.
1. Crush the fit so that it does not work very well.
1. Look at the part of y not captured by the crushed tree and fit a new tree to what is “left over”.
1. Crush the new tree. Your new fit is the sum of the two trees.
1. Repeat the above steps iteratively. At each iteration you fit “what is left over” with a tree, crush the tree, and then add the new crushed tree into the fit.
1. Your final fit is the sum of many trees.




## Footnotes

<b id="footnote1">1</b> From https://www.kaggle.com/c/GiveMeSomeCredit description [↩](#afootnote1)

<b id="footnote2">2</b> Again, from https://www.kaggle.com/c/GiveMeSomeCredit description [↩](#afootnote2)

<b id="footnote3">3</b> Taken from [Binary classification](https://en.wikipedia.org/wiki/Binary_classification)  [Wikipedia]  [↩](#afootnote3)

<b id="footnote4">4</b> http://chicagoboothml.github.io/MachineLearning_Fall2015/Syllabus/03_trees_bag_boost.pdf  [↩](#afootnote4)

