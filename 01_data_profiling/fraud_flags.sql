-- =====================================================
-- TABLE: fraud_flags
-- =====================================================

-- STEP 1: checking sanity range of risk_score and flag_date.
SELECT MIN(risk_score), MAX(risk_score)
FROM fraud_flags;
    -- MIN(risk_score) was 20, MAX(risk_score) was 99.

SELECT MIN(flag_date), MAX(flag_date)
FROM fraud_flags;
    -- MIN(flag_date) was 2024-01-01, MAX(flag_date) was 2026-01-05.

-- STEP 2: checking referential integrity.
-- transaction_id references transaction_id in the customer_transactions table.
-- any row returned would be an orphan.
SELECT ff.flag_id, ff.transaction_id
FROM fraud_flags ff
LEFT JOIN customer_transactions ct
    ON ff.transaction_id = ct.transaction_id
WHERE ct.transaction_id IS NULL;
    -- it's confirmed that every transaction_id in fraud_flags matches a transaction_id in customer_transactions (0 rows returned).
