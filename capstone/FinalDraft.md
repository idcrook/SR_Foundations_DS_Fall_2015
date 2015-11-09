"GiveMeSomeCredit" Capstone project
---
Author: David Crook <david.crook@gmail.com>


# Introduction to the Problem

A completed Kaggle project, "[Give Me Some Credit](https://www.kaggle.com/c/GiveMeSomeCredit)", was chosen for this capstone project. From its project description:

> Improve on the state of the art in credit scoring by predicting the probability that somebody will experience financial distress in the next two years.

Basically, the competition task was this: use historical borrower data to model predictions for a set of given borrower profiles.  The prediction to be made was whether, or not, the borrower will encounter a loan default situation within two years.

The competition was a well-defined **binary classification** problem: make a prediction for provided test dataset on whether a given borrower will be likely to default within two years.

## More Background

Banks play a crucial role in market economies. They decide who can get finance and on what terms and can make or break investment decisions.<sup id="afootnote1">[1](#footnote1)</sup> Lenders would prefer to issue loans with low, understandable risk and have an estimation upon whether or not they will be paid back.

At the heart of the loan decision process is applying available financial information to determine credit-worthiness:

> Credit scoring algorithms, which make a guess at the probability of default, are the method banks use to determine whether or not a loan should be granted. This competition requires participants to improve on the state of the art in credit scoring, by predicting the probability that somebody will experience financial distress in the next two years.<sup id="afootnote2">[2](#footnote2)</sup>

In finance, *default* is failure to meet the legal obligations (or conditions) of a loan, such as when a home buyer fails to make a mortgage payment. Lenders like banks want to predict ahead of time (i.e., before they issue a loan) the chances of a likely "default" ("financial distress") event  occurring. 

This project explored creating various models to increase the accuracy of predicting correctly.

# Description of the available data

This problem came with a [bundled data set](https://www.kaggle.com/c/GiveMeSomeCredit/data).

| File Name       | Available Formats |
|-----------------|-------------------|
| cs-training     | .csv (7.21 mb)    |
| cs-test         | .csv (4.75 mb)    |
| Data Dictionary | .xls (14.50 kb)   |
| sampleEntry     | .csv (1.82 mb)    |

There is a training dataset (`cs-training.csv`) which includes historical borrowing information on `150,000` borrowers. The training set include a value for the variable to be predicted: `SeriousDlqin2yrs`. This is a binary variable of whether "*Person experienced 90 days past due delinquency or worse*".

The observations where the predictions were going to be graded in the competition were found in the test dataset (`cs-test.csv`). The test dataset contains `101,503` observations. These observations **do not** contain a value for the variable to be predicted, `SeriousDlqin2yrs`. The goal in the Kaggle competition was to provide a predicted value, a probability, for this variable in each observation in the test dataset.

*For **extra credit**, the author submitted a prediction dataset entry on the Kaggle website, receiving an "offical" [AUC (Area-Under-Curve)](https://en.wikipedia.org/wiki/Receiver_operating_characteristic#Area_under_the_curve) score and relative placement among the other competition entries.*

Counting both the training and test data, there are over `250,000` observations gathered from historical borrowing data.

### Important fields and information in the data set

From the `Data Dictionary.xls` file in the data bundle, there was a description of all the variables in the dataset. `SeriousDlqin2yrs`, a binary variable, is the dependent variable that was to be predicted.

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

# Data Cleaning Details

Like any other real-world data set, the data contained outliers, missing values, and other suspect details.

The author has included more extensive notes, comments, and the `R` code in [EDA.Rmd](GiveMeSomeCredit/EDA.Rmd). Following, a summary is provided on the `cs-training` dataset.

### General

The first column in the imported data set is simply the observation number, and the variable was deleted from data table. Otherwise the data is *tidy*, with each row a complete observation, and each column a variable.

#### Demographics variables

**age** - One of the `age` values is `0`. The author chose to **impute** a value for it.
Many values in the `age` variable over age 90 and even over age 100. These seemed possibly invalid, but no changes were made to these values.

**NumberOfDependents** - There are a couple of suspect outliers (>10), but otherwise values seems reasonable. Contained **NA**s. It was chosen to impute values for the  **NA** `NumberOfDependents` to provide valid values required by some of the modeling techniques. The values could also have been set the the sample *median* or sample *mean*.

#### Finances variables

**DebtRatio** - The `DebtRatio` variable contained a large spread with some very high values. For example, the training dataset had a *median* of `0.4` and *mean* of `353`.
During additional investigation, it was found that `DebtRatio` was computed by substituting `1` to `MonthlyIncome`, where `MonthlyIncome` was not available.<sup id="afootnote3">[3](#footnote3)</sup> This knowledge was leveraged when creating the feature `MonthlyExpenses` (refer below).

**MonthlyIncome** - There were a large number of outliers in `MonthlyIncome`, and it contained **NA**s. Rather than converting to its *median* value, the **NA** values were imputed.

**MonthlyExpenses**  [**Constructed**] - `DebtRatio` multipled by `MonthlyIncome`. Where `MonthlyIncome` was **NA**, `1` was substituted for `MonthlyIncome` to reflect what was done in original dataset. This feature is a way to get a value for monthly expenses, instead of the included ratio.

**NetMonthlySurplus**  [**Constructed**] - `MonthlyIncome` minus the constructed feature `MonthlyExpenses`. This feature is intended to represent net income, and if negative it reflects that expenses are higher than reported income.


#### Existing Credit Utilization variables

**NumberOfOpenCreditLinesAndLoans**, **NumberRealEstateLoansOrLines** - A few of these seem unrealistically high, but were assumed to be valid.
**RevolvingUtilizationOfUnsecuredLines** - There was some extremely large outliers in this variable. Perhaps the extreme outliers should have been clipped for better results when constructing the model?

#### Deliquencies variables

**NumberOfTime30-59DaysPastDueNotWorse**, **NumberOfTime60-89DaysPastDueNotWorse**, **NumberOfTimes90DaysLate**
There are `5` occurrences of `96` and `264` occurrences of `98` in each of these variables. It was established that these are nonsensical values, and were converted to **NA**.  The values were then set to their sample *median*. Otherwise the values in these variables were assumed to be reasonable and valid.

**ConsolidatedNumberOfDaysPastDue** [**Constructed**] - Since the three Delinquencies variables are related, it was decided to create a feature `ConsolidatedNumberOfDaysPastDue` that contained the total number of days late.  Using the assumed thresholds `[30, 60, 90]`, respectively, the feature `ConsolidatedNumberOfDaysPastDue` was created. The thinking was that, for model fitting, it could be useful to use the total number of days to represent the three variables.

## Data cleaning techniques

The `mice` [R package](https://cran.r-project.org/web/packages/mice/index.html) (`mice`: "Multivariate Imputation by Chained Equations") was chosen to impute the **NA** values.  Refer to the code in [EDA.Rmd](GiveMeSomeCredit/EDA.Rmd) at `imputed = complete(mice(simplified))`. Since the imputation process can take a lot of time, and can be slightly different each time as a result of the randomization inherent in the technique, the resulting imputed values were stored in a file (`imputed_simplified.Rda`) for reuse.

In the training dataset, the variables `age`, `MonthlyIncome`, `NumberOfDependents` contained **NA** values. For these variables with **NA**s, the values were imputed using `mice`. Also, the variables  `NumberOfTime30-59DaysPastDueNotWorse`, `NumberOfTime60-89DaysPastDueNotWorse`, `NumberOfTimes90DaysLate` effectively contained **NA** values . The **NA**s in these variables were set to the *median* values.

The resulting cleaned data was saved to a file `cs-training-cleaned.csv`, to be used as-is as input in [Modeling.Rmd](GiveMeSomeCredit/Modeling.Rmd).


## Feature Discovery

A summary of constructed features follows:

Feature                              | Dscription
-------------------------------------|------------
**MonthlyExpenses**                  | `DebtRatio` multipled by `MonthlyIncome`
**NetMonthlySurplus**                | `MonthlyIncome` minus the constructed feature `MonthlyExpenses`
**ConsolidatedNumberOfDaysPastDue**  | Calculated as "total" number of days past due in each observation, scaling `NumberOfTime30-59DaysPastDueNotWorse`, `NumberOfTime60-89DaysPastDueNotWorse`, `NumberOfTimes90DaysLate` by `30`, `60`, and `90` respectively, and summing the values.

FIXME: report on the significance of the features in the dataset

### Additional data

FIXME: what other data could be good to have?

# Modeling 

Models were built and used to evaluate among the **decision tree** (CART), **random forest**, and **logistic regression** binary classifiers.  These approaches were used since they were covered in the coursework.  Full R code with comments and many other details can be found in [Modeling.Rmd](GiveMeSomeCredit/Modeling.Rmd). 

## Data selection and model building

Since the `cs-test.csv` dataset did not include values for the dependent variable, it was not usuable for validating the models built as to over- or under-fitting. Instead, the training data was split up to use for that purpose. The **`createDataPartition`** function from the **`caret`** [R package](https://cran.r-project.org/web/packages/caret/index.html) (`caret`: "Classification and Regression Training") was use to split samples representationally so that each sample would reflect the source sample on the proportion of the dependent variable being expressed.

The `caret` package is very versatile; it contained wrappers and consistent parameterizations for each of the three types of classification models being explored.  See the [Modeling.Rmd](GiveMeSomeCredit/Modeling.Rmd) for full details.

### First Iteration

For the first iteration of the modeling, no features were de-selected and all original variables were used. Similarly, no constructed features were included in the modeling. The ROC (Receiver Operating Characteristic) curve comparing the three first-iteration models:

![First Iteration ROC](GiveMeSomeCredit/ROC1a.png "First Iteration ROC curve")

The Random Forest model performs best in the first iteration, but the Logit (logistic regression) model keeps up, finally stalling around a *sensitivity* of `0.6` or so.

### Second Iteration - feature selection

For the second iteration model builds, the non-linear `DebtRatio` variable was removed, while `MonthlyExpenses` and `NetMonthlySurplus` were added.
Also, the three "PastDue" variables were replaced with `ConsolidatedNumberOfDaysPastDue` that is supposed to reflect their linear sum.
When the models were rebuilt with the changed features, the resulting ROC curve looked like:

![Second Iteration ROC](GiveMeSomeCredit/ROC2a.png "Second Iteration ROC curve")

In the second iteration, all three models performed at least slightly better on the ROC curve. The Random Forest model improving significantly, and the CART model showed the greatest performance improvement. The Random Forest performed the best overall again.

# Extra Credit - Submit on Kaggle

FIXME:

[ExtraCredit.Rmd](GiveMeSomeCredit/ExtraCredit.Rmd)

# Feedback to data providers

- Try to be consistent on provided variables in a data source.  Numeric variables should be linear and defined consistently at least in the same variable. For example, `DebtRatio` was sometimes a placeholder, and other times it was used to represent monthly expense values.

# Ideas for future research

- The Random Forest generation took a large amount of wall clock time to build its model, especially when using most of the training set. During iteration, the author was forced to greatly reduce to training set size in order to iterate experiments in a reasonable amount of time. Investigations into parallel computation for speedup would help on this aspect.

- Come up with a better strategy to clip or cull outliers in the provided training and test data, or otherwise normalize them.  Some of the variables in the training data set had outliers of many orders of magnitude beyond the inter-quartile range.

### Boosting and Other Binary Classifiers

The following binary classifiers<sup id="afootnote4">[4](#footnote4)</sup> were not covered in the course, but could be tried to observe if any of them would create higher-performaing models:

- Bayesian networks
- Support vector machines
- Neural networks

Another technique, boosting, could additionally be used to improve upon the model result. This method was not covered in course materials, but can often lead to better predictive models.

Like Random Forests, boosting is an ensemble method in that the overall fit is produced from many trees. In Boosting<sup id="afootnote5">[5](#footnote5)</sup>:

1. Fit the data with a single tree.
1. Crush the fit so that it does not work very well.
1. Look at the part of `y` (dependent variable) not captured by the crushed tree and fit a new tree to what is “left over”.
1. Crush the new tree. The new fit is the sum of the two trees.
1. Repeat the above steps iteratively. At each iteration, a fit is made on “what is left over” with a tree, the tree is crushed, and then the new crushed tree is added into the fit.
1. The final fit is the sum of many trees.



## Footnotes

<b id="footnote1">1</b> From https://www.kaggle.com/c/GiveMeSomeCredit description [↩](#afootnote1)

<b id="footnote2">2</b> Again, from https://www.kaggle.com/c/GiveMeSomeCredit description [↩](#afootnote2)

<b id="footnote3">3</b> https://www.kaggle.com/c/GiveMeSomeCredit/forums/t/1166/congratulations-to-the-winners/7231#post7231 [↩](#afootnote3)

<b id="footnote4">4</b> Taken from [Binary classification](https://en.wikipedia.org/wiki/Binary_classification)  [Wikipedia]  [↩](#afootnote4)

<b id="footnote5">5</b> http://chicagoboothml.github.io/MachineLearning_Fall2015/Syllabus/03_trees_bag_boost.pdf  [↩](#afootnote5)


