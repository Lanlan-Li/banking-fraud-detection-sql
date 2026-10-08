-- =====================================================
-- TABLE: customer
-- =====================================================

-- STEP 1: checking null values in customer_postal_code, gender, street_address,
-- branch_number, id_document_type, immigration_status and account_opening_channel.
SELECT *
FROM customer
WHERE customer_postal_code IS NULL
    OR gender IS NULL
    OR street_address IS NULL
    OR branch_number IS NULL
    OR id_document_type IS NULL
    OR immigration_status IS NULL
    OR account_opening_channel IS NULL;
    -- the result returned 25 rows, all of them where gender is NULL.
    -- this doesn't cause data errors, as gender is not required information for fraud analysis.

-- STEP 2: checking referential integrity.
-- customer_postal_code references postal_data(postal_code).
-- branch_number references branch(branch_number).
-- both columns are nullable, so only the non-NULL values are compared.
-- any row returned would be an orphan.

-- checking customer_postal_code.
SELECT c.customer_id, c.customer_postal_code
FROM customer c
LEFT JOIN postal_data pd
    ON c.customer_postal_code = pd.postal_code
WHERE c.customer_postal_code IS NOT NULL
    AND pd.postal_code IS NULL;
    -- 0 rows returned, no integrity problems.

-- checking branch_number.
SELECT c.customer_id, c.branch_number
FROM customer c
LEFT JOIN branch b
    ON c.branch_number = b.branch_number
WHERE c.branch_number IS NOT NULL
    AND b.branch_number IS NULL;
    -- 0 rows returned, no integrity problems.
