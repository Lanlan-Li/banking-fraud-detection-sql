-- =====================================================
-- TABLE: account
-- =====================================================

-- STEP 1: checking null values.
-- there is no need to check account_id, account_number, account_category_id, and customer_id,
-- because they are defined as NOT NULL (or as the primary key) in schema.sql.
SELECT *
FROM account
WHERE branch_number IS NULL
    OR date_opened IS NULL
    OR account_status IS NULL;
    -- the query didn't return any rows, so there are no NULL values in the account table.

-- STEP 2: checking text consistency in the column account_status.
SELECT account_status, COUNT(*) AS frequency
FROM account
GROUP BY account_status
ORDER BY frequency DESC;
    -- the text is consistent in the account_status column. there is only one category: all the accounts are active.

-- STEP 3: checking sanity range; only checking the column date_opened,
-- because the other integer columns, for instance branch_number, are foreign keys.
SELECT MIN(date_opened), MAX(date_opened)
FROM account;
    -- MIN(date_opened) was 2015-01-01, MAX(date_opened) was 2025-06-01.

-- STEP 4: checking referential integrity. need to confirm the foreign keys are consistent with the parent tables.
-- there are three foreign keys in this table: account_category_id, customer_id and branch_number.
-- any row returned would be an orphan.

-- checking account_category_id.
SELECT a.account_id, a.account_category_id
FROM account a
LEFT JOIN account_category ac
    ON a.account_category_id = ac.account_category_id
WHERE ac.account_category_id IS NULL;
    -- 0 rows returned, no orphans.

-- checking customer_id.
SELECT a.account_id, a.customer_id
FROM account a
LEFT JOIN customer c
    ON a.customer_id = c.customer_id
WHERE c.customer_id IS NULL;
    -- 0 rows returned, no orphans.

-- checking branch_number. branch_number is nullable, so only the non-NULL values are compared.
SELECT a.account_id, a.branch_number
FROM account a
LEFT JOIN branch b
    ON a.branch_number = b.branch_number
WHERE a.branch_number IS NOT NULL
    AND b.branch_number IS NULL;
    -- 0 rows returned, no orphans.
