## Reading in data

##################################################
# Run with 
#     R CMD BATCH L3_script.R
##################################################

# install.packages('ggplot2', repos='http://cran.us.r-project.org')
library(ggplot2)

setwd("~/projects/Classes/FoundationsOfDataScience_sliderule/github/UD651")
# print(getwd())
# print(list.files())

pf <- read.csv('pseudo_facebook.tsv', sep = '\t')
names(pf)

# qplot(x = dob_day, data = pf) + 
#   scale_x_discrete(breaks = 1:31) 

qplot(x = dob_day, data = pf) + 
  scale_x_discrete(breaks = 1:31) + 
  facet_wrap(~dob_month, ncol = 4)

# qplot(x = friend_count, data = pf, geom = "histogram", xlim=c(0,1000)) 

# qplot(x = friend_count, data = pf) + 
#   scale_x_continuous(limits = c(0, 1000))

# qplot(x = friend_count, data = pf, binwidth=25) + 
#   scale_x_continuous(limits = c(0, 1000), breaks = seq(0,1000,50)) +
#   facet_wrap(~gender, ncol = 3)

# qplot(x = friend_count, data = subset(pf, !is.na(gender)), binwidth=25) + 
#   scale_x_continuous(limits = c(0, 1000), breaks = seq(0,1000,50)) +
#   facet_wrap(~gender, ncol = 3)

qplot(x = friend_count, data = subset(pf, !is.na(gender)), binwidth=25) + 
  scale_x_continuous(limits = c(0, 1000), breaks = seq(0,1000,50)) +
  facet_wrap(~gender, ncol = 3)

# qplot(x = tenure, data = pf, 
#   color = I('black'), fill = I('#099DD9'))

# qplot(x = tenure, data = pf, binwidth=365,
#       color = I('black'), fill = I('#099DD9')) +
#   scale_x_continuous(limits = c(0, 3650), breaks = seq(0,3650,365*2)) 

qplot(x = tenure/365, data = pf, binwidth=0.25, 
      xlab = "Number of years using Facebook",
      ylab = "Number of users in sample",
      color = I('black'), fill = I('#F79420')) +
  scale_x_continuous(limits = c(0, 7), breaks = seq(0,7,1)) 


qplot(x = age, data = pf, binwidth=1,
      xlab = "Age",
      ylab = "Number of users in sample",
      color = I('black'), fill = I('#5760AB')) +
  scale_x_discrete(limits = c(0, 113, 5))

# qplot(x = age, data = pf, binwidth=2, 
#       xlab = "Age",
#       ylab = "Number of users in sample",
#       color = I('black'), fill = I('#F79420')) + 
#   scale_x_continuous(limits = c(12, 110))



