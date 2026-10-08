-- =====================================================
-- TABLE: customer_transactions
-- =====================================================

-- STEP 1: checking null values.
-- the schema shows that vendor_id, branch_number, transaction_region and balance_after can be NULL.
SELECT *
FROM customer_transactions
WHERE vendor_id IS NULL;

SELECT *
FROM customer_transactions
WHERE branch_number IS NULL;

SELECT *
FROM customer_transactions
WHERE transaction_region IS NULL;

SELECT *
FROM customer_transactions
WHERE balance_after IS NULL;

    -- the result shows that vendor_id and branch_number have NULL values, which is expected.
    -- online transactions don't have a branch_number.
    -- there are 55594 transactions that don't have a vendor_id, which is also understandable,
    -- since vendor_id is NULL for internal transfers and branch transactions according to the schema.

-- STEP 2: checking text consistency of transaction_country and transaction_region.
SELECT transaction_country, COUNT(*)
FROM customer_transactions
GROUP BY transaction_country;
    -- there are 6156 transactions with 'Unknown' as the country. all the other country names are consistent.

SELECT transaction_region, COUNT(*)
FROM customer_transactions
GROUP BY transaction_region;
    -- some Canadian provinces use acronyms, which need to be replaced with
    -- the full spelling to be consistent with the other region names.
    -- AB = Alberta; BC = British Columbia; MB = Manitoba; NS = Nova Scotia; ON = Ontario;
    -- QC = Quebec; SK = Saskatchewan

-- STEP 3: checking sanity range of transaction_date, transaction_time, amount and balance_after.
SELECT MIN(transaction_date), MAX(transaction_date)
FROM customer_transactions;
    -- MIN(transaction_date) was 2024-01-01, MAX(transaction_date) was 2025-12-31.

SELECT MIN(transaction_time), MAX(transaction_time)
FROM customer_transactions;
    -- MIN(transaction_time) was 00:00:00, MAX(transaction_time) was 23:59:57.

SELECT MIN(amount), MAX(amount)
FROM customer_transactions;
    -- MIN(amount) was -3498.61, MAX(amount) was 4999.79.

SELECT MIN(balance_after), MAX(balance_after)
FROM customer_transactions;
    -- MIN(balance_after) was 1200.01, MAX(balance_after) was 47999.45. nothing unusual.

-- STEP 4: checking referential integrity.
-- the foreign keys are account_id, customer_id, vendor_id, transaction_category_id and branch_number.
-- only transaction_category_id needs to be checked here, since all the other foreign keys
-- were tested in their corresponding tables.
-- any row returned would be an orphan.
SELECT ct.transaction_id, ct.transaction_category_id
FROM customer_transactions ct
LEFT JOIN transaction_category tc
    ON ct.transaction_category_id = tc.transaction_category_id
WHERE tc.transaction_category_id IS NULL;
    -- it's confirmed that every transaction_category_id in customer_transactions matches a record in transaction_category (0 rows returned).
