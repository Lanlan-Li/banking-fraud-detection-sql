-- =====================================================
-- TABLE: postal_data
-- =====================================================

-- STEP 1: checking text consistency in city, province and region.
SELECT city, COUNT(*)
FROM postal_data
GROUP BY city
ORDER BY COUNT(*) DESC;
    -- no typos, text is consistent.

SELECT province, COUNT(*)
FROM postal_data
GROUP BY province
ORDER BY COUNT(*) DESC;
    -- no typos, text is consistent.

SELECT region, COUNT(*)
FROM postal_data
GROUP BY region
ORDER BY COUNT(*) DESC;
    -- no typos, text is consistent.
