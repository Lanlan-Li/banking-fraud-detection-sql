-- =====================================================
-- TABLE: account_balances
-- =====================================================

-- STEP 1: checking the sanity range of balance_date.
-- expecting all dates to fall inside the data period.
SELECT MIN(balance_date), MAX(balance_date)
FROM account_balances;
    -- MIN(balance_date) was 2025-01-05, MAX(balance_date) was 2025-12-01.

-- STEP 2: checking referential integrity of account_id, which references the ACCOUNT table.
-- any row returned would be an orphan (an account_id with no match in account).
SELECT ab.account_id
FROM account_balances ab
LEFT JOIN account a
    ON ab.account_id = a.account_id
WHERE a.account_id IS NULL;
    -- it's confirmed that every account_id in the account_balances table matches an account_id in the account table (0 rows returned).
