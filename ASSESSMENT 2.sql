/**ASSESMENT 2**/
WITH CUST_AGG AS (
  SELECT
    OWNER_ID,
    DATE_FORMAT(TRANSACTION_DATE, '%Y-%m') AS txn_month,
    COUNT(*) AS txn_count
  FROM savings_savingsaccount
  GROUP BY OWNER_ID, txn_month
),
TXN_BAND AS (
  SELECT
    OWNER_ID,
    txn_month,
    txn_count,
    CASE
      WHEN txn_count >= 10 THEN 'High Frequency'
      WHEN txn_count BETWEEN 3 AND 9 THEN 'Medium Frequency'
      ELSE 'Low Frequency'
    END AS frequency_category
  FROM CUST_AGG
)
SELECT
  FREQUENCY_CATEGORY,
  COUNT(*) AS CUSTOMER_COUNT,
  ROUND(AVG(TXN_COUNT), 1) AS AVG_TRANSACTIONS_PER_MONTH
FROM TXN_BAND
GROUP BY FREQUENCY_CATEGORY
ORDER BY AVG(TXN_COUNT) DESC

