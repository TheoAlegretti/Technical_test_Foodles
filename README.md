# Technical_test_Foodles
Repository for the technical test for Foodles. 

I made a UV environment: 

```bash
pip install uv 
uv venv 
source .venv/bin/activate
```

## Part one: SQL 

Let's download PostgreSQL on bash first! 

We have a first SQL to make the database into PostgreSQL -> data_creation.sql (you can copy paste it after: `psql -d test_foodles -U {user_postgres_name}`)

For the first question, we made a simple script to join the transactions to the subvention table using the id 
and we count the unique id on the joined table (it's inner because we want the common id from both tables)
-> count_transactions_subsidies.sql 

Result: 3 transactions linked to subsidy 

For the second question, we make the exact same join (inner by id) but we use the company name for group by and count the number of common ids 
-> count_per_company.sql 

Result: 

```
 company  | transactions_with_subsidy 
----------+---------------------------
 Bouygues |                         2
 Molitor  |                         1
```

## Part two: Python function 

I'll write it in the file blabla.py

You can run it easily with: 

```bash
python blabla.py 
```

I documented it a bit with explanations to be reused! 

## Part three: Machine learning 

So we want to preprocess a bit the first table to have for one row (= one dish for one new menu) to get the quantities offered 
by Foodles and consumed by the company. Of course we have two goals here: 
- Minimize the waste of food 
- Maximize the different offer options to be attractive 

I guess the first one is the most important one, we can make a KPI per goal and a weighted KPI for the optimization. 

First, we want to forecast from one company, one week, one menu, one dish the consumption using historical data. 

So it's a regression model using features to forecast the quantities to offer for each dish using the prediction of the dishes already consumed. 
As features we can use the seasonality (I guess the behavior of consumption is different in summer from winter), the company itself (SNCF is not eating the same way as Etam), the type of dishes, is it hot or cold... From that we can make a LightGBM model to minimize the forecast error. It's pretty nice working with panel data like that, we just need to make the cross validation robust to have all kinds of segments of demand (company, product, seasonality pattern) in each fold and in the train/test/validation set. I like to use Optuna for the hyperparameters optimization. 

We can study the error of forecast to be sure that it's a noise and not still correlated to omitted features. 

I'll group by dishes and menu, the target will be the consumed quantities and we can use the seasonal features based on the week of year, the dish name can be used to cluster the Asian food, American one, Italian and find some patterns. The company will also be useful to use the historical quantities consumed and some information on the number of employees, size of the company, is it a tech company or not (teleworking = not eating at the office). 

We can forecast 2 things: the quantities consumed or the % of waste (offered / consumed)

For the KPI, I suggest having a forecast KPI based on the model itself (power of forecast) with MAE (more interpretable) / RMSE and MAPE for experiment tracking 

One operational KPI using the % of waste, we can use it after to predict vector of menu in the future which maximizes the offer and minimizes the waste rate (Optuna or PSO algorithm)

Using the cost and the price, we can also make € KPI with the cost of waste, and revenue per company to prioritize the model bias. 

For evaluating the result, we need to make a test dataset with all the companies based on the most recent menu to see if our KPIs are decreasing by using the ML model to minimize our main offer. So stratified and time series split! 

We can use the current waste rate as baseline.

Also an error study is important to see where with some interval of confidence (bootstrapped) we are good or bad. 

An A/B testing can be interesting also if we are allowed to do it.