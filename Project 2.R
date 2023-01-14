marketing_campaign <- read.delim("~/Desktop/IU/BUS-K 353/Project 1/marketing_campaign.csv")
marketing_campaign <- read.csv(file.choose())

# Cleaning the Data
val_95 = quantile(marketing_campaign$MntWines, probs = 0.95, na.rm = TRUE)
outlier_ID <- which(marketing_campaign$MntWines > val_95)
marketing_campaign <- marketing_campaign[-outlier_ID, ] 
marketing_campaign$LOG.MntWines <- log(marketing_campaign$MntWines+1)

index_NA <- which(is.na(marketing_campaign$Income))
marketing_campaign$Income[index_NA] <- 
  mean(marketing_campaign$Income, na.rm = TRUE) 
outlier_inc = which(marketing_campaign$Income == 666666)
marketing_campaign <- marketing_campaign[-outlier_inc, ] 
marketing_campaign$AGE <- 2021 - marketing_campaign$Year_Birth
AGE_95 = quantile(marketing_campaign$AGE, probs = 0.95, na.rm = TRUE)
outlier_AGE <- which(marketing_campaign$AGE > AGE_95)
marketing_campaign <- marketing_campaign[-outlier_AGE, ] 

# Regression Tree
# Partition the data
ntrain <- round(0.6 * nrow(marketing_campaign),0)
set.seed(500)
index_vec <- 1: nrow(marketing_campaign)
train_index <- sample(index_vec, ntrain , replace = F)
train_set <- marketing_campaign[train_index, ]
valid_set <- marketing_campaign[-train_index, ]
dim(train_set)
dim(valid_set)

# Install the package
install.packages("rpart")
library(rpart)

reg_tree <- rpart(MntWines ~ AGE + Income, data = train_set, method = "anova")


## Display the decision rules
install.packages('rpart.plot')
library(rpart.plot)

rpart.rules(reg_tree)
prp(reg_tree,type = 5, extra = 1, under = TRUE,  varlen = -10, digits= -2)

## Evaluating the Predictive Performance using RMSE

install.packages("forecast")
library(forecast)

Mnt_hat <- predict(reg_tree, valid_set)
accuracy(Mnt_hat , valid_set$MntWines)

# 2nd Regression Tree
reg_tree_2 <- rpart(MntWines ~ AGE + Income + Kidhome, data = train_set, 
                    method = "anova")
rpart.rules(reg_tree_2)
prp(reg_tree_2,type = 5, extra = 1, under = TRUE,  varlen = -10, digits= -2)
Mnt_hat_2 <- predict(reg_tree_2, valid_set)
accuracy(Mnt_hat_2 , valid_set$MntWines)

# 3rd Regression Tree
reg_tree_3 <- rpart(MntWines ~ AGE + Income + Kidhome + NumDealsPurchases, 
                    data = train_set, method = "anova")
rpart.rules(reg_tree_3)
prp(reg_tree_3,type = 5, extra = 1, under = TRUE,  varlen = -10, digits= -2)
Mnt_hat_3 <- predict(reg_tree_3, valid_set)
accuracy(Mnt_hat_3 , valid_set$MntWines)
accuracy(Mnt_hat_3 , train_set$MntWines)

# Comparing with Linear regression model
model3 <- lm(MntWines ~ AGE + Income + Kidhome + NumDealsPurchases, data = train_set)
options(scipen=200)
summary(model3)
Mnt_hat3_linear <- predict(model3, valid_set)
accuracy(Mnt_hat3_linear, valid_set$MntWines)

VALUE_hat3_valid <- predict(model3, valid_set)
accuracy(VALUE_hat3_valid, valid_set$MntWines)
VALUE_hat4_valid <- predict(model3, train_set)
accuracy(VALUE_hat4_valid, train_set$MntWines)

## Unsupervised Model
# Cluster Analysis
dim(marketing_campaign)
names(marketing_campaign)
summary(marketing_campaign)
round(cor(marketing_campaign[c(5, 6, 7, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20,31)]),2)

plot(MntWines ~ MntMeatProducts, data = marketing_campaign)

val_95_2 = quantile(marketing_campaign$MntMeatProducts, probs = 0.95, na.rm = TRUE)
outlier_ID_2 <- which(marketing_campaign$MntMeatProducts > val_95_2)
marketing_campaign <- marketing_campaign[-outlier_ID_2, ] 

plot(MntWines ~ MntMeatProducts, data = marketing_campaign)
# Detect missing values
marketing_campaign_sample <- marketing_campaign[ , c("MntWines","MntMeatProducts")]
index_NAs <- which(rowSums(is.na(marketing_campaign_sample )) > 0)
length(index_NAs)
# Standardize 
market_std <- data.frame(sapply(marketing_campaign_sample, scale))
row.names(market_std) <- row.names(marketing_campaign)
dim(market_std)
mean(market_std$MntWines)
mean(market_std$MntMeatProducts)
sd(market_std$MntWines)
sd(market_std$MntMeatProducts)

plot(MntWines ~ MntMeatProducts, data = market_std)
set.seed(0)
km1 <- kmeans(market_std, centers = 5)

plot(MntWines ~ MntMeatProducts, data = market_std,
     col = km1$cluster, pch = 16)
points(km1$centers[, c(2,1)],
       col=row.names(km1$centers),
       pch= 5 , cex = 2)
## $size: The number of observations in each cluster.
km1$size
## $centers: Returns the variable values for the cluster centroids.
km1$centers

# Second Cluster
plot(MntWines ~ NumStorePurchases, data = marketing_campaign)
boxplot(marketing_campaign$NumStorePurchases)

# Missing Values
marketing_campaign_samp <- marketing_campaign[ , c("MntWines","NumStorePurchases")]
index_NAs_2 <- which(rowSums(is.na(marketing_campaign_samp )) > 0)
length(index_NAs_2)

# Standardize 
market_std_2 <- data.frame(sapply(marketing_campaign_samp, scale))
row.names(market_std_2) <- row.names(marketing_campaign)
dim(market_std_2)
mean(market_std$MntWines)
mean(market_std$NumStorePurchases)
sd(market_std$MntWines)
sd(market_std$NumStorePurchases)

distance <- dist(market_std_2, method = "euclidean")
hc1 <- hclust(distance, method = "ward.D")
plot(hc1, hang = -1, ann = FALSE)
cluster1 <- cutree(hc1, k = 2)
cluster1
centers1 <- aggregate( . ~ cluster1, 
                       data = market_std_2, FUN = mean)
table(cluster1)

plot(MntWines ~ NumStorePurchases, data = market_std_2, 
     col = cluster1, pch = 16)
points(centers1[, c(3,2)], col = row.names(centers1), 
       pch= 4 , cex = 2)






