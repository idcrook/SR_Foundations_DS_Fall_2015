# VIDEO 2

# Read in data
baseball = read.csv("baseball.csv")
str(baseball)

# Subset to only include moneyball years
moneyball = subset(baseball, Year < 2002)
str(moneyball)

# Compute Run Difference
moneyball$RD = moneyball$RS - moneyball$RA
str(moneyball)

# Scatterplot to check for linear relationship
plot(moneyball$RD, moneyball$W)

# Regression model to predict wins
WinsReg = lm(W ~ RD, data=moneyball)
summary(WinsReg)

# =====  

# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
# (Intercept) 80.881375   0.131157  616.67   <2e-16 ***
#   RD           0.105766   0.001297   81.55   <2e-16 ***


requiredRD = (95 - 80.881375) / 0.105766
requiredRD

0.105766 * (713 - 614) + 80.881375

# VIDEO 3

str(moneyball)

# Regression model to predict runs scored
RunsReg = lm(RS ~ OBP + SLG + BA, data=moneyball)
summary(RunsReg)

RunsReg = lm(RS ~ OBP + SLG, data=moneyball)
summary(RunsReg)

# =====  


# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
# (Intercept)  -804.63      18.92  -42.53   <2e-16 ***
#   OBP          2737.77      90.68   30.19   <2e-16 ***
#   SLG          1584.91      42.16   37.60   <2e-16 ***
#   ---


(2737.77 * 0.311) + (1584.91 * 0.405) - 804.63

RunsAllowReg = lm(RA ~ OOBP + OSLG, data=moneyball)
summary(RunsAllowReg)

# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
# (Intercept)  -837.38      60.26 -13.897  < 2e-16 ***
#   OOBP         2913.60     291.97   9.979 4.46e-16 ***
#   OSLG         1514.29     175.43   8.632 2.55e-13 ***
#   ---

(2913.60 * 0.297) + (1514.29 * 0.370) -837.38


########

RunsReg = lm(RS ~ OBP + SLG, data=moneyball)
summary(RunsReg)

# Estimate Std. Error t value Pr(>|t|)    
# (Intercept)  -804.63      18.92  -42.53   <2e-16 ***
#   OBP          2737.77      90.68   30.19   <2e-16 ***
#   SLG          1584.91      42.16   37.60   <2e-16 ***

RSpred <- function 
