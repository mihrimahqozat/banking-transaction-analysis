WITH monthly_stats AS (
    SELECT
        DATE_TRUNC('month', "TransactionDate"::TIMESTAMP)      AS month,
        "TransactionType",
        COUNT("TransactionID")                                 AS transaction_count,
        ROUND(SUM("TransactionAmount")::NUMERIC, 2)            AS total_amount,
        ROUND(AVG("TransactionAmount")::NUMERIC, 2)            AS avg_amount
    FROM transactions
    GROUP BY DATE_TRUNC('month', "TransactionDate"::TIMESTAMP), "TransactionType"
)
SELECT
    month,
    "TransactionType",
    transaction_count,
    total_amount,
    avg_amount
FROM monthly_stats
ORDER BY month, "TransactionType";