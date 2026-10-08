-- =====================================================
-- TABLE: credit_card
-- =====================================================

-- STEP 1: checking text consistency in the column card_status.
SELECT card_status
FROM credit_card
GROUP BY card_status;
    -- it returned three categories and no inconsistencies.

-- STEP 2: checking sanity range of credit_limit, issue_date and expiration_date.
SELECT MIN(credit_limit), MAX(credit_limit)
FROM credit_card;
    -- credit_limit is between 1000 and 25000.

SELECT MIN(issue_date), MAX(issue_date)
FROM credit_card;
    -- issue_date is between 2018-01-01 and 2025-01-01.

SELECT MIN(expiration_date), MAX(expiration_date)
FROM credit_card;
    -- expiration_date is between 2022-01-01 and 2029-01-01.

-- STEP 3: checking referential integrity.
-- customer_id references customer(customer_id).
-- account_id references account(account_id).
-- in the schema, account_id can be NULL, so only the non-NULL values are compared.
-- any row returned would be an orphan.

-- checking customer_id.
SELECT cc.card_id, cc.customer_id
FROM credit_card cc
LEFT JOIN customer c
    ON cc.customer_id = c.customer_id
WHERE c.customer_id IS NULL;
    -- 0 rows returned, no integrity issues.

-- checking account_id.
SELECT cc.card_id, cc.account_id
FROM credit_card cc
LEFT JOIN account a
    ON cc.account_id = a.account_id
WHERE cc.account_id IS NOT NULL
    AND a.account_id IS NULL;
    -- 0 rows returned, no integrity issues.
