


# What is the problem to solve?

I am choosing a completed kaggle competition: "[Give Me Some Credit](https://www.kaggle.com/c/GiveMeSomeCredit)".

From its project description:

> Improve on the state of the art in credit scoring by predicting the probability that somebody will experience financial distress in the next two years.

# Who is the client and why do they care about this problem?

Banks play a crucial role in market economies. They decide who can get finance and on what terms and can make or break investment decisions<sup id="afootnote1">[1](#footnote1)</sup>. Banks only want to issue loans with understandable risks on whether they will be paid back.

Credit scoring algorithms, which make a guess at the probability of default, are the method banks use to determine whether or not a loan should be granted. This competition requires participants to improve on the state of the art in credit scoring, by predicting the probability that somebody will experience financial distress in the next two years.

# What data is going to be used for this?

The data is available from the competition website [Give Me Some Credit - data](https://www.kaggle.com/c/GiveMeSomeCredit/data). It includes:


| File Name       | Available Formats |
|-----------------|-------------------|
| cs-training     | .csv (7.21 mb)    |
| cs-test         | .csv (4.75 mb)    |
| Data Dictionary | .xls (14.50 kb)   |
| sampleEntry     | .csv (1.82 mb)    |



# What is the approach to solving this problem

The problem is going to be approached as a binary classification problem. Some of the methods commonly used for [binary classification](https://en.wikipedia.org/wiki/Binary_classification) [Wikipedia] are:

 - Decision trees
 - Random forests
 - Bayesian networks
 - Support vector machines
 - Neural networks
 - Logistic regression

The coursework covers **decision trees**, **random forests**, and **logistic regression** on binary classifiers, so I will focus on those methods.

There will be some data cleanup, as there are outliers and NAs in the provided datasets.

Feature selection will be performed during model creation.

Evaluation of the model using [AUC (Area-Under-Curve)](https://en.wikipedia.org/wiki/Receiver_operating_characteristic#Area_under_curve) will also be performed.

# What are the deliverables?

The goal of this competition is to build a model that can be used to help make the best financial decisions.  Specifically, this will be:

1. R Code and its resulting prediction model (created within the execution of the code)
1. An "Entry" file that contains a probability prediction for each observation in the cs-test dataset
   1. There will be an associated [AUC](https://www.kaggle.com/wiki/AreaUnderCurve) score as well that evaluates the predictive power of the model.




## Submit your Capstone project proposal

 1. What is the problem you want to solve?
 1. Who is your client and why do they care about this problem? In other words, what will your client DO or DECIDE based on your analysis that they wouldn’t have otherwise?
 1. What data are you going to use for this? How will you acquire this data?
 1. In brief, outline your approach to solving this problem (knowing that this might change later).
 1. What are your deliverables? Typically, this would include code, along with a paper and/or a slide deck.


<b id="footnote1">1</b> From https://www.kaggle.com/c/GiveMeSomeCredit description [↩](#afootnote1)
