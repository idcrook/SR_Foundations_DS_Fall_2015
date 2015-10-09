

##################################################
# Run with 
#     R CMD BATCH L3_transform.R
##################################################

# install.packages('ggplot2', repos='http://cran.us.r-project.org')
# install.packages("gridExtra", repos='http://cran.us.r-project.org') #sthash.PKF9Zh50.dpuf
library(ggplot2)
library(gridExtra)

# p1 = ggplot(...)
# grid.arrange(p1, p2, p3, p4, ncol=2)


setwd("~/projects/Classes/FoundationsOfDataScience_sliderule/github/UD651")

pf <- read.csv('pseudo_facebook.tsv', sep = '\t')
names(pf)

# qplot(x = friend_count, data = pf)

summary(pf$friend_count)

summary(log(pf$friend_count + 1))

summary(sqrt(pf$friend_count))

summary(log10(pf$friend_count + 1))

# p1 = qplot(x = friend_count, data = pf)
# p2 = qplot(x = log10(pf$friend_count + 1), data = pf)
# p3 = qplot(x = sqrt(pf$friend_count), data = pf)
# grid.arrange(p1, p2, p3, ncol=1)

p1 = ggplot(aes(x = friend_count), data = pf) + geom_histogram()

p2 = ggplot(aes(x = friend_count), data = pf) + 
  geom_histogram() +
  scale_x_log10()

grid.arrange(p1, p2, ncol=2)


# ggplot(aes(x = friend_count, y = ..count../sum(..count..)), 
#        data = subset(pf, !is.na(gender))) +
#   geom_freqpoly(aes(color = gender), binwidth=10) + 
#   scale_x_continuous(limits = c(0, 1000), breaks = seq(0, 1000, 50)) +
#   xlab('Friend Count') + 
#   ylab('Percentage of users with that friend count')

# # different ranges
# ggplot(aes(x = friend_count, y = ..count../sum(..count..)), 
#        data = subset(pf, !is.na(gender))) +
#   geom_freqpoly(aes(color = gender), binwidth=20) + 
#   scale_x_continuous(limits = c(0, 2000), breaks = seq(0, 2000, 100)) +
#   xlab('Friend Count') + 
#   ylab('Percentage of users with that friend count')
# 
# # 
# ggplot(aes(x = friend_count, y = ..density..), 
#        data = subset(pf, !is.na(gender))) +
#   geom_freqpoly(aes(color = gender), binwidth=20) + 
#   scale_x_continuous(limits = c(0, 2000), breaks = seq(0, 2000, 100)) +
#   xlab('Friend Count') + 
#   ylab('Percentage of users with that friend count')

ggplot(aes(x = www_likes), data = subset(pf, !is.na(gender))) +
  geom_freqpoly(aes(color = gender)) + 
  scale_x_log10()

by(pf$www_likes, pf$gender, sum)

# qplot(x = gender, y = friend_count, data = subset(pf, !is.na(gender)),
#       geom="boxplot")

ggplot(aes(x = gender, y = friend_count), 
       data = subset(pf, (0 <= friend_count) & (friend_count <= 1000) & (!is.na(gender)))) +
  geom_boxplot(outlier.shape=NA)

# qplot(x = gender, y = friend_count, data = subset(pf, !is.na(gender)),
#       geom="boxplot", ylim= c(0,1000))

qplot(x = gender, y = friend_count, data = subset(pf, !is.na(gender)),
      geom="boxplot") +
  coord_cartesian( ylim= c(0,250))

by(pf$friend_count, pf$gender, sum)

by(pf$friendships_initiated, pf$gender, summary)

qplot(x = gender, y = friendships_initiated, data = subset(pf, !is.na(gender)),
      geom="boxplot") +
  coord_cartesian( ylim= c(0,150))

mobile_check_in <- NA
pf$mobile_check_in <- ifelse(pf$mobile_likes > 0, 1, 0)
pf$mobile_check_in <- factor(pf$mobile_check_in)
summary(pf$mobile_check_in)

sum(pf$mobile_check_in == 1)/length(pf$mobile_check_in)


