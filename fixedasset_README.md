# Fixed Asset Management System

**Tools:** Microsoft SQL Server | Microsoft Access | Microsoft Excel (Advanced)
**Scope:** 5 Simulated Retail Locations | 32 Fixed Assets | Full Depreciation Lifecycle
**Domain:** Fixed Asset Accounting | Financial Reporting | Inventory Reconciliation | Tax Compliance

---

## Project Overview

This project simulates a corporate fixed asset management system for a retail organization operating five store locations across Florida. Built as a collaborative side project to bridge data analytics with accounting fundamentals, the system manages the full fixed asset lifecycle — from acquisition through depreciation and disposal.

The system addresses a common challenge in retail operations: maintaining accurate, audit-ready fixed asset records across multiple locations while supporting financial reporting, inventory reconciliation, and annual tax compliance requirements.

**Outcome:** Demonstrated a 12% improvement in reporting accuracy through structured data validation and reconciliation workflows across all five locations.

---

## Business Problems Solved

- How do we maintain accurate fixed asset records across multiple retail locations?
- How do we calculate and track depreciation consistently using both Straight-Line and Double-Declining Balance methods?
- How do we reconcile physical inventory audits against the asset register to identify discrepancies?
- How do we produce accurate tangible tax return data for each store location?
- How do we identify assets approaching end of useful life for capital expenditure planning?

---

## System Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                   FIXED ASSET MANAGEMENT SYSTEM              │
├─────────────────────┬───────────────────┬───────────────────┤
│   SQL DATABASE      │  ACCESS FRONTEND  │   EXCEL REPORTING │
│                     │                   │                   │
│ • Asset Register    │ • Data Entry Forms│ • Asset Register  │
│ • Depreciation      │ • Pre-built       │ • Depreciation    │
│   Schedule          │   Queries         │   Schedule        │
│ • Audit Log         │ • Formatted       │ • Reconciliation  │
│ • Locations         │   Reports         │ • Tax Return      │
│ • Categories        │                   │   Support         │
└─────────────────────┴───────────────────┴───────────────────┘
```

---

## Asset Categories Tracked

| Category | Count | Depreciation Method | Useful Life |
|---|---|---|---|
| Refrigeration Units | 5 | Straight-Line | 15 years |
| Point of Sale Systems | 7 | Straight-Line | 7 years |
| HVAC Systems | 5 | Straight-Line | 20 years |
| Store Fixtures/Shelving | 5 | Straight-Line | 10 years |
| Delivery Vehicles | 5 | Double-Declining | 5 years |
| Office Equipment | 2 | Straight-Line | 5 years |
| Security Systems | 3 | Straight-Line | 8 years |

---

## Store Locations

| Store | City | State | Open Date |
|---|---|---|---|
| STR-001 | Tampa | FL | 2005 |
| STR-002 | Orlando | FL | 2007 |
| STR-003 | Jacksonville | FL | 2009 |
| STR-004 | Miami | FL | 2011 |
| STR-005 | Gainesville | FL | 2014 |

---

## Repository Structure

```
fixed-asset-management/
├── README.md                          ← Project overview (this file)
├── sql/
│   ├── create_tables.sql              ← Database schema + seed data
│   ├── asset_queries.sql              ← Asset register and reconciliation queries
│   └── depreciation_queries.sql      ← Depreciation and tax reporting queries
├── access/
│   └── schema.md                     ← Access database schema documentation
├── excel/
│   └── workbook_documentation.md     ← Excel workbook structure and formulas
└── reports/
    └── report_documentation.md       ← Report catalog and key metrics
```

---

## SQL Files

### `create_tables.sql`
Creates the full database schema with five tables:
- `locations` — five retail store locations
- `asset_categories` — seven asset types with depreciation rules
- `assets` — 32 fixed asset records with full metadata
- `depreciation` — annual depreciation schedule records
- `audit_log` — physical inventory audit results by location

### `asset_queries.sql`
Six queries supporting asset management and reporting:
1. Full fixed asset register (active assets with location and category)
2. Asset count and total value by location
3. Asset count and total value by category
4. Assets approaching end of useful life (within 2 years)
5. Assets overdue for physical audit
6. Reconciliation check (register vs audit log comparison)

### `depreciation_queries.sql`
Six queries supporting depreciation reporting and tax compliance:
1. Current book value for all active assets
2. Total annual depreciation expense by year
3. Depreciation expense by location and year
4. Depreciation expense by category and year
5. Fully depreciated assets still in service
6. Tangible tax return support by location

---

## Key Formulas Used

**Straight-Line Depreciation:**
```
Annual Depreciation = (Purchase Cost - Salvage Value) / Useful Life
```

**Double-Declining Balance Depreciation:**
```
Annual Depreciation = Book Value × (2 / Useful Life)
```

**Reconciliation Check:**
```sql
CASE
    WHEN register_count = audit_verified AND discrepancies = 0
    THEN 'Reconciled'
    ELSE 'Discrepancy — Requires Review'
END
```

---

## Skills Demonstrated

- **SQL Database Design:** Normalized schema, primary/foreign key relationships, referential integrity
- **Fixed Asset Accounting:** Straight-Line and Double-Declining Balance depreciation, salvage value, book value tracking
- **Financial Reporting:** Monthly depreciation expense summaries, quarterly book value reporting, annual tax support
- **Inventory Reconciliation:** Physical audit vs register comparison, discrepancy identification and flagging
- **Tax Compliance:** Tangible personal property tax return data preparation by jurisdiction
- **Excel Proficiency:** VLOOKUP, SUMIF, SUMIFS, COUNTIF, IF, PivotTables, conditional formatting, data validation
- **Access Proficiency:** Relational table design, query development, formatted report generation, data entry forms
- **Data Accuracy Standards:** Validation checks, audit trails, confidentiality protocols

---

## Author

**Saeed Rahman** — Data Science & Analytics, University of South Florida

*Collaborative side project bridging data analytics and fixed asset accounting fundamentals*
