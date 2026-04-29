WITH fraud_indicators AS (
    SELECT
        "Channel",
        "CustomerOccupation",
        COUNT("TransactionID")                         AS total_transactions,
        ROUND(AVG("LoginAttempts")::NUMERIC, 2)        AS avg_login_attempts,
        COUNT(CASE WHEN "LoginAttempts" > 1
              THEN 1 END)                              AS suspicious_transactions,
        ROUND(AVG("TransactionAmount")::NUMERIC, 2)    AS avg_transaction_amount,
        ROUND(AVG("TransactionDuration")::NUMERIC, 2)  AS avg_duration_seconds
    FROM transactions
    GROUP BY "Channel", "CustomerOccupation"
),
ranked AS (
    SELECT *,
        ROUND(suspicious_transactions * 100.0 /
              NULLIF(total_transactions, 0), 2)             AS suspicious_rate_pct,
        RANK() OVER (ORDER BY suspicious_transactions DESC) AS risk_rank
    FROM fraud_indicators
)
SELECT *
FROM ranked
ORDER BY suspicious_rate_pct DESC;