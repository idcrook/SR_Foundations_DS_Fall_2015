


# What is the problem to solve?

I am choosing a completed kaggle competition: "[Give Me Some Credit](https://www.kaggle.com/c/GiveMeSomeCredit)".

From its project description:

> Improve on the state of the art in credit scoring by predicting the probability that somebody will experience financial distress in the next two years.

# Who is the client and why do they care about this problem?

Banks play a crucial role in market economies. They decide who can get finance and on what terms and can make or break investment decisions.<sup id="afootnote1">[1](#footnote1)</sup> Lenders would prefer to issue loans with low, understandable risk as to whether they will be paid back.

From the contest description<sup id="afootnote2">[2](#footnote2)</sup>:

> Credit scoring algorithms, which make a guess at the probability of default, are the method banks use to determine whether or not a loan should be granted. This competition requires participants to improve on the state of the art in credit scoring, by predicting the probability that somebody will experience financial distress in the next two years.

So they care because they want a more sophisticated predictive model for evaluating loan decisions.

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

# Footnotes

<b id="footnote1">1</b> From https://www.kaggle.com/c/GiveMeSomeCredit description [↩](#afootnote1)

<b id="footnote2">2</b> Again, from https://www.kaggle.com/c/GiveMeSomeCredit description [↩](#afootnote2)

<b id="footnote3">3</b> Taken from [Binary classification](https://en.wikipedia.org/wiki/Binary_classification)  [Wikipedia]  [↩](#afootnote3)


