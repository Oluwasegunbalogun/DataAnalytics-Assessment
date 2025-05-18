SELECT 
    CU.ID AS customer_id, 
    CONCAT(CU.first_name, ' ', CU.last_name) AS name,
    TIMESTAMPDIFF(MONTH, CU.DATE_JOINED, CURDATE()) AS tenure_months,
    COUNT(SA.ID) AS total_transactions,
 COALESCE((
        (SUM(SA.confirmed_amount) * 0.001) / NULLIF(TIMESTAMPDIFF(MONTH, CU.DATE_JOINED, CURDATE()), 0)
    ) * 12, 0) AS estimated_clv 
        /**nullif because of zero divisor and COALESCE to make result 0 instead of null**/
FROM 
    users_customuser CU
LEFT JOIN  
    savings_savingsaccount SA ON CU.ID = SA.OWNER_ID
GROUP BY 
    CU.ID, CU.first_name, CU.last_name, CU.DATE_JOINED
ORDER BY 
    estimated_clv DEsc;
