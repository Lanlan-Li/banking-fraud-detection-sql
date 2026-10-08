-- =====================================================
-- TABLE: branch
-- =====================================================

-- checking the null values and referential integrity.

-- STEP 1: checking the null values in these columns:
-- branch_size, branch_description, branch_type and postal_code.
SELECT *
FROM branch
WHERE branch_size IS NULL
    OR branch_description IS NULL
    OR branch_type IS NULL
    OR postal_code IS NULL;
    -- there were no null values in the table.

-- STEP 2: checking referential integrity.
-- checking if postal_code in this table is consistent with postal_code in the postal_data table.
SELECT b.branch_number, b.postal_code
FROM branch b
LEFT JOIN postal_data pd
    ON b.postal_code = pd.postal_code
WHERE pd.postal_code IS NULL;
    -- the query returned 0 orphan foreign keys, so there are no integrity problems.
