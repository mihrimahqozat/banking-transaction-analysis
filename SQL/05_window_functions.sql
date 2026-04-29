WITH customer_totals AS (
    SELECT
        "AccountID",
        "CustomerOccupation",
        "Location",
        ROUND(SUM("TransactionAmount")::NUMERIC, 2)    AS total_spent,
        COUNT("TransactionID")                         AS total_transactions,
        ROUND(AVG("AccountBalance")::NUMERIC, 2)       AS avg_balance
    FROM transactions
    GROUP BY "AccountID", "CustomerOccupation", "Location"
),
ranked_customers AS (
    SELECT *,
        RANK() OVER (ORDER BY total_spent DESC)
            AS spending_rank,
        RANK() OVER (PARTITION BY "CustomerOccupation" ORDER BY total_spent DESC)
            AS spending_rank_within_occupation,
        ROUND(SUM(total_spent) OVER (ORDER BY total_spent DESC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)::NUMERIC, 2)
            AS running_total_spent,
        ROUND(total_spent * 100.0 /
            SUM(total_spent) OVER (), 4) AS pct_of_total_spend
    FROM customer_totals
)
SELECT *
FROM ranked_customers
ORDER BY spending_rank
LIMIT 50;