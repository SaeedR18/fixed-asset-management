# Excel Workbook Documentation

**File:** `FixedAssetManagement.xlsx`
**Purpose:** Fixed asset register, depreciation schedules, reconciliation reports, and tangible tax return support across five simulated retail locations

---

## Workbook Structure

The Excel workbook contains seven worksheets organized for monthly reporting, annual depreciation tracking, inventory reconciliation, and tax compliance.

---

## Sheet 1: Asset Register

**Purpose:** Master list of all fixed assets across all five locations

**Columns:**

| Column | Description |
|---|---|
| Asset Tag | Physical tag number (e.g. TAG-1001) |
| Asset Name | Descriptive name of the asset |
| Category | Asset category (Refrigeration, POS, HVAC, etc.) |
| Store Number | Location identifier (STR-001 through STR-005) |
| City | Store city |
| Purchase Date | Date of acquisition |
| Purchase Cost | Original cost ($) |
| Salvage Value | Estimated residual value ($) |
| Depreciable Cost | Purchase Cost minus Salvage Value |
| Useful Life (Yrs) | Expected service life |
| Status | Active / Disposed / Under Repair |
| Vendor | Supplier name |
| Last Audited | Most recent physical audit date |

**Key Excel Features Used:**
- Data validation dropdowns for Status and Category fields
- Conditional formatting: red highlight for assets not audited in 12+ months
- VLOOKUP to pull category details from the Categories sheet
- Filters enabled for all columns

---

## Sheet 2: Depreciation Schedule

**Purpose:** Year-by-year depreciation calculation for each asset

**Columns:**

| Column | Description |
|---|---|
| Asset Tag | Links to Asset Register |
| Asset Name | Asset description |
| Category | Asset category |
| Depreciation Method | Straight-Line or Double-Declining |
| Purchase Cost | Original cost ($) |
| Salvage Value | Residual value ($) |
| Useful Life (Yrs) | Service life in years |
| Year 1 – Year 20 | Annual depreciation, accumulated depreciation, and book value per year |

**Key Excel Features Used:**
- Formula: `=(Purchase Cost - Salvage Value) / Useful Life` for Straight-Line depreciation
- Formula: `=Book Value * (2 / Useful Life)` for Double-Declining Balance
- Conditional formatting: green highlight when Book Value reaches Salvage Value (fully depreciated)
- Freeze panes on asset columns for horizontal scrolling

---

## Sheet 3: Monthly Reporting Summary

**Purpose:** Monthly financial performance snapshot for senior analyst review

**Contents:**
- Total asset count by location
- Total purchase cost by location
- Total net book value by location
- Current year depreciation expense by location
- Month-over-month change tracking

**Key Excel Features Used:**
- SUMIF formulas aggregating by location
- PivotTable summarizing by category and location
- Bar chart: Net Book Value by Location
- Line chart: Depreciation Expense trend over time

---

## Sheet 4: Inventory Reconciliation

**Purpose:** Compares physical audit counts against register records to identify discrepancies

**Columns:**

| Column | Description |
|---|---|
| Store Number | Location identifier |
| City | Store city |
| Register Count | Assets listed in the register |
| Audit Verified | Assets physically confirmed during audit |
| Discrepancies | Count of unresolved items |
| Audit Date | Most recent audit date |
| Auditor | Name of analyst |
| Status | Reconciled / Discrepancy — Requires Review |

**Key Excel Features Used:**
- IF formula: `=IF(Register Count=Audit Verified,"Reconciled","Discrepancy — Requires Review")`
- Conditional formatting: red highlight for any discrepancy row
- COUNTIF to summarize total discrepancies across all locations

---

## Sheet 5: Tangible Tax Return Support

**Purpose:** Summarizes asset values by location for annual tangible personal property tax filings

**Columns:**

| Column | Description |
|---|---|
| Store Number | Location identifier |
| City / State | Filing jurisdiction |
| Tax Year | Calendar year of filing |
| Total Assets | Count of taxable assets |
| Total Original Cost | Sum of purchase costs |
| Accumulated Depreciation | Total depreciation to date |
| Net Book Value | Taxable assessed value |
| Current Year Depreciation | Expense for the filing year |

**Key Excel Features Used:**
- SUMIFS formulas filtering by location and tax year
- Protected cells to prevent accidental edits to tax figures
- Print area set for clean single-page output per location

---

## Sheet 6: Categories Reference

**Purpose:** Lookup table for asset categories, useful life, and depreciation methods

| Column | Description |
|---|---|
| Category ID | Numeric identifier |
| Category Name | Asset type description |
| Useful Life (Yrs) | Standard service life |
| Depreciation Method | Straight-Line or Double-Declining |
| Salvage % | Salvage value as % of cost |

---

## Sheet 7: Audit Log

**Purpose:** Running log of all physical inventory audits conducted

| Column | Description |
|---|---|
| Audit ID | Sequential identifier |
| Store Number | Location audited |
| Audit Date | Date conducted |
| Auditor | Analyst name |
| Assets Verified | Count confirmed |
| Discrepancies | Unresolved items |
| Notes | Observations and follow-up |
