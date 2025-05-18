  /** USING THE IS_REGULAR_SAVINGS AND IS_INVESTMENT FLAG**/
  SELECT 
    PL.owner_id, 
    CONCAT(CU.first_name, ' ', CU.last_name) AS name,
     (select sum(sa.confirmed_amount) from savings_savingsaccount SA where 
    PL.owner_id = SA.owner_id) total_deposits,
    SUM(CASE WHEN PL.is_regular_savings = 1 THEN 1 ELSE 0 END) AS savings_count,
    SUM(CASE WHEN PL.is_a_fund = 1 THEN 1 ELSE 0 END) AS investment_count
FROM 
    plans_plan PL
JOIN 
    users_customuser CU ON PL.owner_id = CU.id
GROUP BY 
    PL.owner_id, CU.first_name, CU.last_name
HAVING 
    SUM(CASE WHEN PL.is_regular_savings = 1 THEN 1 ELSE 0 END) > 0
    AND 
    SUM(CASE WHEN PL.is_a_fund = 1 THEN 1 ELSE 0 END) > 0
ORDER BY owner_id DESC;
 
  
  
  /** USING DESCRIPTION TO GROUP SAVINGS AND INVESTMENT**/
  SELECT 
    PL.owner_id, 
    CONCAT(CU.first_name, ' ', CU.last_name) AS name,
    (select sum(sa.confirmed_amount) from savings_savingsaccount SA where 
    PL.owner_id = SA.owner_id) total_deposits,
   COUNT(CASE 
        WHEN PL.description IN (
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
            'Join other PSG fans to save money for every goal your team scores.'
        ) THEN PL.id 
    END) AS savings_count,
COUNT(CASE 
        WHEN PL.description IN (
            'Mutual Fund',
            'Managed Portfolio',
            'Fixed Investment',
            'USD Index'
        ) THEN PL.id 
    END) AS investment_count
FROM plans_plan PL
join  users_customuser CU ON PL.owner_id = CU.id
GROUP BY PL.owner_id, CONCAT(CU.first_name, ' ', CU.last_name)
HAVING 
    COUNT(CASE 
        WHEN PL.description IN (
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
            'Join other PSG fans to save money for every goal your team scores.'
        ) THEN PL.id 
    END) > 0
AND 
    COUNT(CASE 
        WHEN PL.description IN (
            'Mutual Fund',
            'Managed Portfolio',
            'Fixed Investment',
            'USD Index'
        ) THEN PL.id 
    END) > 0;

/** tHIS TAKES MORE TIME TO RUN
SELECT 
    PL.owner_id, 
    CONCAT(CU.first_name, ' ', CU.last_name) AS name,
   COUNT(CASE 
        WHEN PL.description IN (
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
            'Join other PSG fans to save money for every goal your team scores.'
        ) THEN PL.id 
    END) AS savings_count,
COUNT(CASE 
        WHEN PL.description IN (
            'Mutual Fund',
            'Managed Portfolio',
            'Fixed Investment',
            'USD Index'
        ) THEN PL.id 
    END) AS investment_count,
SUM(SA.amount) AS total_deposits
FROM plans_plan PL
JOIN users_customuser CU ON PL.owner_id = CU.id
JOIN savings_savingsaccount SA ON PL.owner_id = SA.owner_id
GROUP BY PL.owner_id, CONCAT(CU.first_name, ' ', CU.last_name)
HAVING 
    COUNT(CASE 
        WHEN PL.description IN (
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
            'Join other PSG fans to save money for every goal your team scores.'
        ) THEN PL.id 
    END) > 0
AND 
    COUNT(CASE 
        WHEN PL.description IN (
            'Mutual Fund',
            'Managed Portfolio',
            'Fixed Investment',
            'USD Index'
        ) THEN PL.id 
    END) > 0; **/

    
    
 
    
    
    



