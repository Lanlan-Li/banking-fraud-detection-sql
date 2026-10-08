-- =====================================================
-- TABLE: vendor
-- =====================================================

-- this file checks null values, text consistency and referential integrity in the vendor table.
-- the table doesn't have any numeric columns, so there is no sanity range to check.

-- STEP 1: checking null values.
SELECT *
FROM vendor
WHERE vendor_category IS NULL
    OR vendor_type IS NULL
    OR country IS NULL
    OR region IS NULL
    OR postal_code IS NULL
    OR acquiring_bank IS NULL;

SELECT *
FROM vendor
WHERE postal_code IS NULL;

    -- the result shows that region and postal_code for vendor_id 17 are NULL.
    -- vendor_type is Online, which at first glance seems consistent with the other online vendors.
    -- but the other online vendors have real values for region and postal_code, so vendor_id 17 is an isolated case.
    -- also, vendor_name, vendor_category, country and acquiring_bank all contain the
    -- placeholder text "Unknown" / "Unclassified" instead of real values. this isn't missing data;
    -- it looks like a catch-all placeholder vendor rather than a real business.

-- STEP 2: checking text consistency in region.
SELECT region, COUNT(*) AS frequency
FROM vendor
GROUP BY region
ORDER BY frequency DESC;
    -- there were no typos and no extra spaces.

-- STEP 3: checking referential integrity.
-- checking if every vendor_id in customer_transactions matches a vendor_id in the vendor table.
-- need to use LEFT JOIN, and only the non-NULL vendor_id values are compared,
-- since vendor_id is nullable in customer_transactions.
SELECT ct.*
FROM customer_transactions ct
LEFT JOIN vendor v
    ON ct.vendor_id = v.vendor_id
WHERE ct.vendor_id IS NOT NULL
    AND v.vendor_id IS NULL;
    -- it's confirmed that every non-NULL vendor_id in customer_transactions has a matching vendor record.

-- STEP 4: checking for duplicate vendors.
-- if two rows are the same vendor, their vendor_name and country should be the same.
SELECT vendor_name, country, COUNT(*)
FROM vendor
GROUP BY vendor_name, country
HAVING COUNT(*) > 1;
    -- it's confirmed that there are no duplicate vendor_name + country combinations.
