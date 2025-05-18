/**USING FLAG**/
SELECT plan_id ,SA.owner_id,
CASE  WHEN PL.is_regular_savings = 1 THEN 'SAVINGS'
 WHEN PL.is_a_fund = 1 THEN 'INVESTMENT' ELSE 'OTHERS' END TYPE 
,DATE(MAX(TRANSACTION_DATE)) AS last_transaction_date,
DATEDIFF(CURDATE(), MAX(TRANSACTION_DATE)) inactivity_days ,PL.description
FROM  
    savings_savingsaccount SA
    left  JOIN  plans_plan PL
     ON SA.plan_id = PL.id
WHERE 
    SA.TRANSACTION_DATE < DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
GROUP BY 
    SA.plan_id, SA.owner_id, TYPE
ORDER BY 
    inactivity_days DESC;


/**USING DESCRIPTION**/
SELECT plan_id ,SA.owner_id,
CASE  WHEN PL.description IN (
            'Save As You Earn',
            'Regular Savings Plan',
            'Periodic Plan',
            'Periodic',
            'Periodic (Interest-Free)',
            'Interest Free Plan',
            'Instant Open Savings Plan',
            'Emergency',
            'Retirement',
            'Vacation',
            'Home',
            'Business',
            'Education',
            'Goal',
            'Family',
            'Group',
            'Stash',
            'Join other Chelsea fans to save money for every goal your team scores.',
            'Join other Liverpool fans to save money for every goal your team scores.',
            'Join other Sporting Lagos fans to save money for every goal your team scores',
            'Join other Barcelona fans to save money for every goal your team scores.',
            'Join other Real Madrid fans to save money for every goal your team scores.',
            'Join other Manchester City fans to save money for every goal your team scores.',
            'Join other Manchester United fans to save money for every goal your team scores.',
            'Join other Arsenal fans to save money for every goal your team scores.',
            'Join other PSG fans to save money for every goal your team scores.',
            'Regular Savings',
            'Save As You Earn (Interest-Free)',
            'Periodic Savings',
            '32 is_interest_free is_interest_free is_interest_free is_interest_free is_interest_free'
        ) THEN 'SAVINGS'
   WHEN PL.description IN (
            'Mutual Fund',
            'Managed Portfolio',
             'entrepreneurship' /** Assuming this is an investment scheme**/,
            'Fixed Investment',
            'USD Index','Emergency'
        ) THEN 'INVESTMENT' ELSE 'OTHERS'  END AS TYPE,
 DATE(MAX(TRANSACTION_DATE)) AS last_transaction_date,
DATEDIFF(CURDATE(), MAX(TRANSACTION_DATE)) inactivity_days 
FROM  
    savings_savingsaccount SA
    left  JOIN  plans_plan PL
     ON SA.plan_id = PL.id
WHERE 
    SA.TRANSACTION_DATE < DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
GROUP BY 
    SA.plan_id, SA.owner_id, TYPE
ORDER BY 
    inactivity_days DESC;




