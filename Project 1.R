getwd()
marketing_campaign <- read.delim("~/Desktop/USA/IU/BUS-K 353/Project 1/marketing_campaign.csv")

## Question 1
marketing_campaign[1:6,]

## Question 2 Part C
hist(marketing_campaign$MntWines, main = "Histogram for Amount Spent on Wine",
     xlab = "Amount spent on wine in last 2 years", col = "darkred")

boxplot(marketing_campaign$MntWines, main = "Boxplot for Amount Spent on Wine",
        xlab = "Amount spent on wine in last 2 years", col = "darkred")

 ## Summary Statistics
dim(marketing_campaign) # report the number of rows and number of columns
summary(marketing_campaign) #summary statistics of each column
names(marketing_campaign) # print out column names
head(marketing_campaign, 10) # displays the first 10 rows
View(marketing_campaign) # display the data frame in a new tab
summary(marketing_campaign) #summary statistics of each column
## there are two NA's in the income column
str(marketing_campaign) # list the variables and their types

## examine the minimum and maximum of amount spent on wines
max(marketing_campaign$MntWines)
min(marketing_campaign$MntWines)
plot(marketing_campaign$MntWines)

## drop the extreme values 
val_95 = quantile(marketing_campaign$MntWines, probs = 0.95, na.rm = TRUE)
outlier_ID <- which(marketing_campaign$MntWines > val_95)
marketing_campaign <- marketing_campaign[-outlier_ID, ] 

boxplot(marketing_campaign$MntWines, col = "darkred") 
# substabtial right skewed
hist(marketing_campaign$MntWines, col = "darkred")

## Creating a new column with transformed MntWines in the dataframe
## with a valid 0s, we need to +1
marketing_campaign$LOG.MntWines <- log(marketing_campaign$MntWines+1)
hist(marketing_campaign$LOG.MntWines,  
     xlab = "Log of Amount spent on wine in last 2 years", col = "darkred")
boxplot(marketing_campaign$LOG.MntWines, col = "darkred")

## We will impute, substitute NA with means for income
index_NA <- which(is.na(marketing_campaign$Income))
marketing_campaign$Income[index_NA] <- 
  mean(marketing_campaign$Income, na.rm = TRUE) 
summary(marketing_campaign)

## drop the incorrect value (outlier in income)
outlier_inc = which(marketing_campaign$Income == 666666)
marketing_campaign <- marketing_campaign[-outlier_inc, ] 
summary(marketing_campaign)

## Create a column of Age
marketing_campaign$AGE <- 2021 - marketing_campaign$Year_Birth
summary(marketing_campaign)
boxplot(marketing_campaign$AGE, col = "darkred")
AGE_95 = quantile(marketing_campaign$AGE, probs = 0.95, na.rm = TRUE)
outlier_AGE <- which(marketing_campaign$AGE > AGE_95)
marketing_campaign <- marketing_campaign[-outlier_AGE, ] 
summary(marketing_campaign)

## Summary Statistics
summary(marketing_campaign)
sd(marketing_campaign$MntWines)
sd(marketing_campaign$Income)
sd(marketing_campaign$AGE)

## Correlation
cor(marketing_campaign[,c("MntWines", "Income", "AGE")])

##Distribution for main variables
plot(marketing_campaign$Income)
hist(marketing_campaign$Income)
plot(marketing_campaign$Age)
hist(marketing_campaign$Age)

## Linear Model
index_vec <- 1:nrow(marketing_campaign)
ntrain <- round(0.6 * nrow(marketing_campaign),0)
set.seed(500)
train_index <- sample(index_vec, size = ntrain, replace = F)
train_set <- marketing_campaign[train_index, ]
valid_set <- marketing_campaign[-train_index, ]          
dim(train_set)
dim(valid_set)

model0 <- lm(LOG.MntWines ~ AGE + Income, data = marketing_campaign)
summary(model0)

install.packages("forecast")
library(forecast)
VALUE_hat0_valid <- predict(model0, valid_set)
accuracy(VALUE_hat0_valid, valid_set$LOG.MntWines)
VALUE_hat1_valid <- predict(model0, train_set)
accuracy(VALUE_hat1_valid, train_set$LOG.MntWines)

model3 <- lm(MntWines ~ AGE + Income, data = marketing_campaign)
summary(model3)

VALUE_hat3_valid <- predict(model3, valid_set)
accuracy(VALUE_hat3_valid, valid_set$MntWines)
VALUE_hat4_valid <- predict(model3, train_set)
accuracy(VALUE_hat4_valid, train_set$MntWines)

summary(model3)

options(scipen=200)
summary(model3)








