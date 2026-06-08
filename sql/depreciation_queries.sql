-- ============================================================
-- Fixed Asset Management System
-- Depreciation Query Scripts
-- Author: Saeed Rahman
-- ============================================================


-- ------------------------------------------------------------
-- Query 1: Current Book Value for All Active Assets
-- Joins assets with latest depreciation record
-- ------------------------------------------------------------
SELECT
    a.asset_tag,
    a.asset_name,
    ac.category_name,
    l.store_number,
    l.city,
    a.purchase_cost,
    a.salvage_value,
    ac.depreciation_method,
    d.fiscal_year                  AS last_depreciation_year,
    d.annual_depreciation,
    d.accumulated_depreciation,
    d.book_value
FROM assets a
JOIN asset_categories ac ON a.category_id = ac.category_id
JOIN locations l          ON a.location_id = l.location_id
JOIN depreciation d       ON d.asset_id = a.asset_id
WHERE d.fiscal_year = (
    SELECT MAX(d2.fiscal_year)
    FROM depreciation d2
    WHERE d2.asset_id = a.asset_id
)
AND a.status = 'Active'
ORDER BY l.store_number, ac.category_name;


-- ------------------------------------------------------------
-- Query 2: Total Annual Depreciation Expense by Year
-- Used for financial reporting and budget planning
-- ------------------------------------------------------------
SELECT
    d.fiscal_year,
    COUNT(DISTINCT d.asset_id)    AS assets_depreciated,
    SUM(d.annual_depreciation)    AS total_depreciation_expense
FROM depreciation d
JOIN assets a ON d.asset_id = a.asset_id
WHERE a.status = 'Active'
GROUP BY d.fiscal_year
ORDER BY d.fiscal_year DESC;


-- ------------------------------------------------------------
-- Query 3: Depreciation Expense by Location and Year
-- Used for location-level financial performance reporting
-- ------------------------------------------------------------
SELECT
    l.store_number,
    l.city,
    d.fiscal_year,
    SUM(d.annual_depreciation)    AS location_depreciation_expense,
    SUM(d.accumulated_depreciation) AS total_accumulated,
    SUM(d.book_value)             AS total_net_book_value
FROM depreciation d
JOIN assets a  ON d.asset_id = a.asset_id
JOIN locations l ON a.location_id = l.location_id
WHERE a.status = 'Active'
GROUP BY l.store_number, l.city, d.fiscal_year
ORDER BY l.store_number, d.fiscal_year DESC;


-- ------------------------------------------------------------
-- Query 4: Depreciation Expense by Category and Year
-- Used for category-level cost reporting
-- ------------------------------------------------------------
SELECT
    ac.category_name,
    ac.depreciation_method,
    d.fiscal_year,
    COUNT(DISTINCT d.asset_id)    AS assets_depreciated,
    SUM(d.annual_depreciation)    AS category_depreciation_expense
FROM depreciation d
JOIN assets a          ON d.asset_id = a.asset_id
JOIN asset_categories ac ON a.category_id = ac.category_id
WHERE a.status = 'Active'
GROUP BY ac.category_name, ac.depreciation_method, d.fiscal_year
ORDER BY d.fiscal_year DESC, category_depreciation_expense DESC;


-- ------------------------------------------------------------
-- Query 5: Fully Depreciated Assets Still in Service
-- Identifies assets at or near salvage value
-- Important for tangible tax return accuracy
-- ------------------------------------------------------------
SELECT
    a.asset_tag,
    a.asset_name,
    ac.category_name,
    l.store_number,
    l.city,
    a.purchase_cost,
    a.salvage_value,
    d.book_value,
    d.accumulated_depreciation,
    d.fiscal_year AS as_of_year,
    CASE
        WHEN d.book_value <= a.salvage_value THEN 'Fully Depreciated'
        ELSE 'Active Depreciation'
    END AS depreciation_status
FROM assets a
JOIN asset_categories ac ON a.category_id = ac.category_id
JOIN locations l          ON a.location_id = l.location_id
JOIN depreciation d       ON d.asset_id = a.asset_id
WHERE d.fiscal_year = (
    SELECT MAX(d2.fiscal_year)
    FROM depreciation d2
    WHERE d2.asset_id = a.asset_id
)
AND a.status = 'Active'
AND d.book_value <= a.salvage_value + 100  -- within $100 of salvage
ORDER BY d.book_value ASC;


-- ------------------------------------------------------------
-- Query 6: Tangible Tax Return Support
-- Summarizes taxable asset values by location for annual filing
-- ------------------------------------------------------------
SELECT
    l.store_number,
    l.city,
    l.state,
    d.fiscal_year                    AS tax_year,
    COUNT(a.asset_id)                AS total_assets,
    SUM(a.purchase_cost)             AS total_original_cost,
    SUM(d.accumulated_depreciation)  AS total_accumulated_depreciation,
    SUM(d.book_value)                AS total_net_book_value,
    SUM(d.annual_depreciation)       AS current_year_depreciation_expense
FROM assets a
JOIN locations l          ON a.location_id = l.location_id
JOIN depreciation d       ON d.asset_id = a.asset_id
WHERE a.status = 'Active'
  AND d.fiscal_year = 2024
GROUP BY l.store_number, l.city, l.state, d.fiscal_year
ORDER BY l.store_number;
