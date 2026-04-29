-- Drop existing table
DROP TABLE IF EXISTS transactions;

-- Recreate with correct column names matching the Kaggle CSV
CREATE TABLE transactions (
    TransactionID               VARCHAR(50) PRIMARY KEY,
    AccountID                   VARCHAR(50),
    TransactionAmount           NUMERIC(15, 2),
    TransactionDate             TIMESTAMP,
    TransactionType             VARCHAR(20),
    Location                    VARCHAR(100),
    DeviceID                    VARCHAR(50),
    IPAddress                   VARCHAR(50),
    MerchantID                  VARCHAR(50),
    AccountBalance              NUMERIC(15, 2),
    PreviousTransactionDate     TIMESTAMP,
    Channel                     VARCHAR(50),
    CustomerAge                 INTEGER,
    CustomerOccupation          VARCHAR(50),
    TransactionDuration         INTEGER,
    LoginAttempts               INTEGER
);