# Customer Behavior & Wine Purchasing Analysis
The analysis and prediction model of wine purchasing based on customer behavior, using R, concepts of statistical regression modeling (supervised models), and cluster analysis (unsupervised models)

This project is a final project of BUS-K 353: Business Analytics & Modeling class at IU Kelley School of Business 

Group members: Prae Kongchan, Venus Chen, Yuqing Wang, and Yue Li

# Overall Analysis Goal
This analysis aims to help a business to better understand its customers and makes it easier for them to target the right group of customers who are likely to buy wines. It may provide foundation information a firm can use to modify its marketing strategies based on customers’ specific characteristics, which allow the firm to spend the marketing budget most effectively and target specific customers most accurately. This analysis is based on data that contains customers’ background and promotion information of the firm.

# Modeling Approaches

## Supervised Model

1. Linear Regression Model: 

The goal of this model is predicting the amount spent on wines, based on continuous predictors of customers' age and income as both predictors correlate with the amount spent on wine. 

<img width="298" alt="1" src="https://user-images.githubusercontent.com/112535634/212492877-bbc3cc89-53c3-4eb0-a91d-2c6c44a4853d.png">

Figure 1: Linear Prediction Model on amount spent on wines, controlling for age and income

The analysis showed that age is not significant. However, the coefficient of significant variable, income, indicates that additional $1 increase in income is correlated with an increase of 0.009 USD amount of wines spending in the last 2 years. The RMSE for the validation data of the first model is equal to 202.7.

In order to improve the linear model, we added more variables of number of children in the customer's household and the number of purchases made with a discount to the model as we believed that discount leads to higher spending and having kids might decrease the spending. The validation RMSE from the updated linear regression decreased to 178.84.

<img width="300" alt="2" src="https://user-images.githubusercontent.com/112535634/212492911-5f46f4f0-07d5-43e3-8686-a122b45808ff.png">

Figure 2: Linear Prediction Model on amount spent on wines, controlling for age, income, number of children, and number of purchases with promotion

2. Regression Tree: 

The goal of this decision tree is predicting the value of the amount each customer spent on wine, based on the same set of numerical predictors used in linear prediction model.

<img width="302" alt="3" src="https://user-images.githubusercontent.com/112535634/212492950-3394c16a-2b2a-46c0-b7e1-e8efbed6b27d.png">

Figure 3: Regression Tree

From the tree, we will predict that a customer whose income is more than or equal to $52,197 and has no child has spent $415 on wines. On the other hand, we would expect a customer whose income is larger or equal to $42,556 and has more than 3 purchases made with discount has spent $247 on wines. The RMSE for training data is 188.46, and 173.43 for validation data.

From the supervised model using historical data of the business, customers who has higher income, less children in their household, and had more purchases with discounts are more likely to be the target group of wines sector for this particular business. Direct advertising or offering discounts to these customers may potentially lead to a higher sales in wines.

## Unsupervised Model

1. K-means Cluster Analysis: 

The goal of this model is forming groups of similar customers, based on their transactions. The first cluster centered around the amount spent on meat and the amount spent on wine in last 2 years. We performed the K-means analysis with a number of 5 clusters. Red clusters, which contained 121 observations, are customers who spent on a lot of both meat and wine. From the findings, the business can come up with marketing strategies such as bundling meat and wines with discounted price for this particular cluster, which may help increasing their spendings.

<img width="281" alt="4" src="https://user-images.githubusercontent.com/112535634/212493007-ea472b8b-a831-471c-8ca4-b14987096a92.png">

Figure 4: Cluster Analysis 1

2. Ward Method Cluster Analysis

The second cluster analysis performed by Ward method, look at the group of the amount spent on wines and number of in-store purchases. There are two clusters generated. The data is displayed vertically because of the discrete data. We cannot accurately label the group using these two variables because one group rarely shops in the store rarely buy wine, while another group who goes to the store more often, some of them never buy wines, and some of them spend moderate to a high amount of money on wine. Therefore, this model might not provide much useful information for a business.

<img width="280" alt="5" src="https://user-images.githubusercontent.com/112535634/212493049-19dfa174-ee2b-4788-9cc0-aba4982a6789.png">

Figure 5: Cluster Analysis 2






