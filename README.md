DATA ANALYTICS SQL ASSESSMENT

This repository includes solutions to an SQL assessment consisting of Four analytical business problems. Each problem demonstrates the use of SQL in real-world scenarios involving customer behavior, product usage, and transactional analytics.
The queries are written for a MySQL database and make extensive use of joins, subqueries, aggregations, conditional logic, and null handling techniques._
________________________________________
Question 1:Identify Customers with Both Savings and Investment Plans

Goals: 
Find customers who own at least one savings plan (is_regular_savings = 1) and at least one investment plan (is_a_fund = 1), along with their total deposits._

Solution:

To identify customers who have engaged with both savings and investment products, I analyzed the plans_plan table, grouping records by owner_id. Using conditional aggregation with SUM(CASE WHEN ...), I counted how many savings (is_regular_savings = 1) and investment (is_a_fund = 1) plans each customer holds.

To calculate total deposits without duplicating rows, I used a subquery on the savings_savingsaccount table. A HAVING clause filtered results to include only customers with at least one savings and one investment plan.

Recognizing that flags may not always be reliable, I created an alternative version that classifies plans using the description field offering flexibility in how the business defines product types.

Highlights:

•	COALESCE was used to prevent null values for total deposits.

•	Classification logic was clearly separated.

•	Query was optimized to avoid row duplication.

Challenges:
A direct join on owner_id from savings_savingsaccount led to server timeout issues, so I used a subquery instead. Additionally, some accounts were neither savings nor investment accounts , prompting the use of plan descriptions as a fallback classification method to give the business an alternative if such accounts(neither savings or investments) are data quality issues.
________________________________________
Question 2: Transaction Frequency Analysis

Goal:
Categorize customers by their monthly transaction frequency to analyze engagement levels.

Solution:
This query segments customers based on how frequently they transact. First, I grouped transactions by owner_id and month using DATE_FORMAT(transaction_date, '%Y-%m'), then counted the number of transactions per customer per month.

I assigned each record to a frequency band—High, Medium, or Low—using a CASE statement. Finally, I aggregated the results to show how many customers fall into each frequency category, along with their average monthly transaction volume.

The use of CTEs (WITH clauses) ensured the logic remained modular and easy to interpret.

Highlights:
•	Used WITH clauses (CUST_AGG and TXN_BAND) for clarity and modularity.

•	CASE logic enabled intuitive frequency grouping.

•	ROUND(AVG(...), 1) was used for concise reporting.

Challenges:
•	None significant. Query was clean and efficient using CTEs and standard aggregation functions.

________________________________________
Question 3: Account Inactivity Alert

Goal:
Identify savings and investment plans that have had no transactions in the last 365 days or have never been used.

Solution:
To flag inactive plans, I joined the plans_plan and savings_savingsaccount tables by plan_id and computed the most recent transaction date using MAX(transaction_date).

I then calculated the number of days since the last activity with DATEDIFF(CURDATE(), MAX(...)). Plans with no transactions or no activity in over 365 days were considered inactive.

Plans were categorized as Savings, Investment, or Others using either product flags or descriptions. The result is a clear and actionable list of stale accounts needing operational review.

Highlights:
•	Handles both inactive and never-used plans.

•	Provides full output with plan_id, owner_id, type, last transaction date, and inactivity in days.

Challenges:
To ensure completeness, I used a LEFT JOIN so that plans with no transactions were still included in the results,also i applied both flag and description classification for flexibility.
________________________________________
Question 4: Customer Lifetime Value (CLV) Estimation

Goal:
Estimate each customer’s lifetime value based on transaction behavior.

Formula:
_CLV = ((SUM(confirmed_amount) * 0.001) / tenure_months) * 12_

Solution:
This query estimates the long-term value of each customer based on tenure and total confirmed deposits. I calculated tenure in months using TIMESTAMPDIFF(MONTH, date_joined, CURDATE()), then computed profit as 0.1% of total confirmed_amount.

To avoid division errors, I wrapped the tenure calculation with NULLIF and used COALESCE to default empty values to zero. The final CLV formula multiplies average monthly profit by 12 for an annualized estimate.

Sorting by estimated_clv highlights the platform’s most valuable users, providing insight for marketing and retention strategies.

Highlights:
•	Accurate rounding for monetary results.

•	Well-handled edge cases (no transactions or recent joiners).

•	Sorted by estimated_clv to surface top-value customers.

Challenges:
•	Needed to guard against division by zero using NULLIF

•	Ensured readability and performance even with full-table joins.

________________________________________
Summary

This assessment highlights the application of SQL for solving common analytics problems, including:
•	Customer segmentation

•	Inactivity tracking

•	Value estimation

•	Transactional behavior analysis

Key SQL techniques used:
•	Conditional aggregation

•	CASE classification

•	CTEs 

•	Subqueries

•	Null handling with COALESCE and NULLIF

These solutions are ready to be adapted for production use in reporting dashboards, data pipelines, or analytical decision support.




