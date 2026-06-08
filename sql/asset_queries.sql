-- ============================================================
-- Fixed Asset Management System
-- Asset Query Scripts
-- Author: Saeed Rahman
-- ============================================================


-- ------------------------------------------------------------
-- Query 1: Full Fixed Asset Register
-- Returns all active assets with location and category details
-- ------------------------------------------------------------
SELECT
    a.asset_tag,
    a.asset_name,
    ac.category_name,
    l.store_number,
    l.city,
    l.state,
    a.purchase_date,
    a.purchase_cost,
    a.salvage_value,
    a.useful_life_yrs,
    a.status,
    a.vendor,
    a.last_audited
FROM assets a
JOIN asset_categories ac ON a.category_id = ac.category_id
JOIN locations l          ON a.location_id = l.location_id
WHERE a.status = 'Active'
ORDER BY l.store_number, ac.category_name, a.asset_tag;


-- ------------------------------------------------------------
-- Query 2: Asset Count and Total Value by Location
-- Used for monthly financial reporting summary
-- ------------------------------------------------------------
SELECT
    l.store_number,
    l.city,
    l.state,
    COUNT(a.asset_id)          AS total_assets,
    SUM(a.purchase_cost)       AS total_cost,
    SUM(a.salvage_value)       AS total_salvage_value,
    SUM(a.purchase_cost - a.salvage_value) AS total_depreciable_cost
FROM assets a
JOIN locations l ON a.location_id = l.location_id
WHERE a.status = 'Active'
GROUP BY l.store_number, l.city, l.state
ORDER BY l.store_number;


-- ------------------------------------------------------------
-- Query 3: Asset Count and Total Value by Category
-- Used for category-level financial reporting
-- ------------------------------------------------------------
SELECT
    ac.category_name,
    ac.depreciation_method,
    ac.useful_life_yrs,
    COUNT(a.asset_id)          AS total_assets,
    SUM(a.purchase_cost)       AS total_cost,
    ROUND(AVG(a.purchase_cost),2) AS avg_cost_per_asset
FROM assets a
JOIN asset_categories ac ON a.category_id = ac.category_id
WHERE a.status = 'Active'
GROUP BY ac.category_name, ac.depreciation_method, ac.useful_life_yrs
ORDER BY total_cost DESC;


-- ------------------------------------------------------------
-- Query 4: Assets Approaching End of Useful Life
-- Flags assets within 2 years of full depreciation
-- Used to support capital expenditure planning
-- ------------------------------------------------------------
SELECT
    a.asset_tag,
    a.asset_name,
    ac.category_name,
    l.store_number,
    l.city,
    a.purchase_date,
    a.purchase_cost,
    a.useful_life_yrs,
    YEAR(a.purchase_date) + a.useful_life_yrs AS retirement_year,
    (YEAR(a.purchase_date) + a.useful_life_yrs) - 2025 AS years_remaining
FROM assets a
JOIN asset_categories ac ON a.category_id = ac.category_id
JOIN locations l          ON a.location_id = l.location_id
WHERE a.status = 'Active'
  AND (YEAR(a.purchase_date) + a.useful_life_yrs) <= 2027
ORDER BY retirement_year ASC;


-- ------------------------------------------------------------
-- Query 5: Assets Never Audited or Overdue for Audit
-- Flags assets where last_audited is NULL or > 12 months ago
-- ------------------------------------------------------------
SELECT
    a.asset_tag,
    a.asset_name,
    ac.category_name,
    l.store_number,
    l.city,
    a.last_audited,
    CASE
        WHEN a.last_audited IS NULL THEN 'Never Audited'
        ELSE 'Overdue'
    END AS audit_status
FROM assets a
JOIN asset_categories ac ON a.category_id = ac.category_id
JOIN locations l          ON a.location_id = l.location_id
WHERE a.status = 'Active'
  AND (a.last_audited IS NULL OR a.last_audited < DATEADD(MONTH, -12, GETDATE()))
ORDER BY a.last_audited ASC;


-- ------------------------------------------------------------
-- Query 6: Reconciliation Check
-- Compares asset register count vs audit log verified count
-- Used to identify discrepancies by location
-- ------------------------------------------------------------
SELECT
    l.store_number,
    l.city,
    COUNT(a.asset_id)        AS register_count,
    al.assets_verified       AS audit_verified_count,
    al.discrepancies,
    al.audit_date,
    CASE
        WHEN COUNT(a.asset_id) = al.assets_verified
             AND al.discrepancies = 0 THEN 'Reconciled'
        ELSE 'Discrepancy — Requires Review'
    END AS reconciliation_status
FROM assets a
JOIN locations l  ON a.location_id = l.location_id
JOIN audit_log al ON al.location_id = l.location_id
WHERE a.status = 'Active'
GROUP BY l.store_number, l.city, al.assets_verified,
         al.discrepancies, al.audit_date
ORDER BY l.store_number;
