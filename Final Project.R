marketing_campaign <- read.delim("~/Desktop/IU/BUS-K 353/Project 1/marketing_campaign.csv")

install.packages("fitdistrplus")
## Load the package
library(fitdistrplus)

# Cleaning Data
val_95 = quantile(marketing_campaign$MntWines, probs = 0.95, na.rm = TRUE)
outlier_ID <- which(marketing_campaign$MntWines > val_95)
marketing_campaign <- marketing_campaign[-outlier_ID, ] 
list_IDs <- which(marketing_campaign$Response == 1)
marketing_campaign <- marketing_campaign[list_IDs, ]
sum(marketing_campaign$Response == 1)

## Fit a distribution to the average amount of wine spent
hist(marketing_campaign$MntWines)   # pretty skewed
descdist(marketing_campaign$MntWines, discrete = FALSE)
fit_W_uni <- fitdist(marketing_campaign$MntWines, "unif")
fit_W_uni$estimate
# min = 1 max = 997
denscomp(fit_W_uni, legendtext = "Uniform")
sim_W <- runif(n = 100, min = 1, max = 997)
hist(sim_W)

## Simulating the total amount spent on wine from the 100 new customers 
## who accept the promotion
WineSpent_vec <- c()
nsim <- 1000

for (i in 1:nsim) {
  sim_W <- runif(n = 100, min = 1, max = 997)
  WineSpent_vec[i]<- sum(sim_W) 
}

hist(WineSpent_vec
     , xlab = 'Total Dollars Spent on Wines'
     , ylab = 'Frequency', main = 'Histogram of simulated 
     total dollars spent on wines')

WineSpent_vec[1:20]

sample_mean <- mean(WineSpent_vec)
sample_mean # 50041.86
## 95% Confidence intervals for the expected amount of spending
mse <- sd(WineSpent_vec) / sqrt(nsim)
CI <- c(sample_mean - 1.96 * mse, sample_mean + 1.96 * mse)
CI
# (49861.01, 50222.71)

## Practice: what is the probability of receiving more than
## $50,000 in total spending from these 100 new customers?
sum(WineSpent_vec > 50000)/nsim
# 49.6%