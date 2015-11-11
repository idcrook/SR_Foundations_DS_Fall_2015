#!/usr/bin/env python

# script to generate R code for making feature bar charts

import string


template = """
# generated with gen_feature_bucket_r.py

# split into ten groups based on age
num_buckets <- %(NUM_BUCKETS)s
bucket <- seq(1, num_buckets)
ar <- rank(cs$%(IND_VAR)s, ties.method = "first")
decile <- cut(ar, quantile(ar, probs=0:10/10), include.lowest=TRUE, labels=FALSE)
deciles_%(IND_VAR)s <- split(cs, decile)
pct_delinquent <- vector("numeric", length(deciles_%(IND_VAR)s))
for (i in seq_along(deciles_%(IND_VAR)s)){
  pct_delinquent[i] <- mean(deciles_%(IND_VAR)s[[i]]$SeriousDlqin2yrs)
}
# results
D%(NUM)d <- data.frame(pct_delinquent, bucket)
# str(D%(NUM)d)
p%(NUM)d <- ggplot(data = D%(NUM)d, aes(x = factor(bucket), y = pct_delinquent)) + 
  geom_bar(stat ="identity")  + 
  geom_hline(aes (yintercept = sample_avg), alpha = 6/10, color = 'red', linetype = 2) +
  ggtitle("%(IND_VAR)s buckets")
p%(NUM)d
"""

def fill_in_template(varname, seq):
    NUM = seq
    IND_VAR = varname
    NUM_BUCKETS = 10
    s = template % vars()
    return s

variables = [
    'age',
    'NumberOfDependents',
    'DebtRatio',
    'MonthlyIncome', 
    'MonthlyExpenses',
    'NetMonthlySurplus', 
    'NumberRealEstateLoansOrLines', 
    'NumberOfOpenCreditLinesAndLoans', 
    'RevolvingUtilizationOfUnsecuredLines',
    'NumberOfTime60.89DaysPastDueNotWorse', 
    'NumberOfTime30.59DaysPastDueNotWorse', 
    'NumberOfTimes90DaysLate', 
    'ConsolidatedNumberOfDaysPastDue'
]

i = 1
for var in variables:
    s = fill_in_template(var, i)
    print '########################################'
    print "# ", var
    print '########################################'
    print s
    i += 1

print '# group charts into one'
print 'png("feature_bucketed_discr.png", width=8, height=12, units="in", res=100)'

a = []
for j in range(1, i):
    a.append('p' + str(j) + ', ')
print 'grid.arrange(', ''.join(a), 'ncol = 3)'

print 'dev.off()'



