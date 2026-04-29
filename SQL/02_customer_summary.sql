SELECT
    "AccountID",
    "CustomerAge",
    "CustomerOccupation",
    "Location",
    ROUND(AVG("AccountBalance")::NUMERIC, 2)        AS avg_balance,
    COUNT("TransactionID")                          AS total_transactions,
    ROUND(SUM("TransactionAmount")::NUMERIC, 2)     AS total_spent,
    ROUND(AVG("TransactionAmount")::NUMERIC, 2)     AS avg_transaction,
    CASE
        WHEN AVG("AccountBalance") >= 100000 THEN 'High Value'
        WHEN AVG("AccountBalance") >= 50000  THEN 'Mid Value'
        ELSE 'Standard'
    END AS customer_segment
FROM transactions
GROUP BY 
	"AccountID", 
	"CustomerAge", 
	"CustomerOccupation", 
	"Location"
ORDER BY total_spent DESC;