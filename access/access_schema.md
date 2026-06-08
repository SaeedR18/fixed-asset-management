# Microsoft Access Database Schema

**File:** `FixedAssetManagement.accdb`
**Purpose:** Relational database for managing fixed asset records, depreciation schedules, and inventory audits across five simulated retail locations

---

## Database Overview

The Access database mirrors the SQL schema and serves as the primary data entry and reporting interface. It includes linked tables, pre-built queries, and formatted reports for use by non-technical stakeholders.

---

## Tables

### tbl_Locations
Stores the five simulated retail store locations.

| Field | Data Type | Description |
|---|---|---|
| LocationID | AutoNumber (PK) | Unique location identifier |
| StoreNumber | Short Text | Store code (e.g. STR-001) |
| City | Short Text | City name |
| State | Short Text | State abbreviation |
| Region | Short Text | Regional grouping |
| OpenDate | Date/Time | Store opening date |

---

### tbl_AssetCategories
Defines asset types, useful life, and depreciation method.

| Field | Data Type | Description |
|---|---|---|
| CategoryID | AutoNumber (PK) | Unique category identifier |
| CategoryName | Short Text | Asset category (e.g. Refrigeration Units) |
| UsefulLifeYears | Number | Expected useful life in years |
| DepreciationMethod | Short Text | Straight-Line or Double-Declining |
| SalvagePct | Number | Salvage value as % of purchase cost |

---

### tbl_Assets
Core fixed asset register — one record per asset across all locations.

| Field | Data Type | Description |
|---|---|---|
| AssetID | AutoNumber (PK) | Unique asset identifier |
| AssetTag | Short Text | Physical asset tag number |
| AssetName | Short Text | Descriptive asset name |
| CategoryID | Number (FK) | Links to tbl_AssetCategories |
| LocationID | Number (FK) | Links to tbl_Locations |
| PurchaseDate | Date/Time | Date of acquisition |
| PurchaseCost | Currency | Original cost of acquisition |
| SalvageValue | Currency | Estimated residual value |
| UsefulLifeYears | Number | Asset-level useful life |
| Status | Short Text | Active / Disposed / Under Repair |
| SerialNumber | Short Text | Manufacturer serial number |
| Vendor | Short Text | Supplier/vendor name |
| LastAudited | Date/Time | Date of most recent physical audit |

---

### tbl_Depreciation
Annual depreciation schedule per asset — one record per asset per year.

| Field | Data Type | Description |
|---|---|---|
| DepreciationID | AutoNumber (PK) | Unique record identifier |
| AssetID | Number (FK) | Links to tbl_Assets |
| FiscalYear | Number | Calendar/fiscal year |
| AnnualDepreciation | Currency | Depreciation expense for the year |
| AccumulatedDepreciation | Currency | Total depreciation to date |
| BookValue | Currency | Net book value at year end |

---

### tbl_AuditLog
Records physical inventory audit results by location and date.

| Field | Data Type | Description |
|---|---|---|
| AuditID | AutoNumber (PK) | Unique audit record identifier |
| LocationID | Number (FK) | Links to tbl_Locations |
| AuditDate | Date/Time | Date audit was conducted |
| AuditorName | Short Text | Name of analyst conducting audit |
| AssetsVerified | Number | Count of assets physically confirmed |
| Discrepancies | Number | Count of unresolved discrepancies |
| Notes | Long Text | Audit observations and follow-up items |

---

## Relationships

```
tbl_Locations ──────────────────────────────────────┐
      │                                              │
      │ 1:Many                                       │ 1:Many
      ▼                                              ▼
tbl_Assets ──── CategoryID ──── tbl_AssetCategories   tbl_AuditLog
      │
      │ 1:Many
      ▼
tbl_Depreciation
```

---

## Pre-Built Queries in Access

| Query Name | Purpose |
|---|---|
| qry_ActiveAssetRegister | Full asset register filtered to Active status |
| qry_AssetsByLocation | Asset count and total value grouped by store |
| qry_DepreciationByYear | Annual depreciation expense summary |
| qry_CurrentBookValue | Latest book value per asset |
| qry_ReconciliationCheck | Compares register vs audit log counts |
| qry_TangibleTaxSupport | Location-level asset values for tax filing |
| qry_EndOfLifeAssets | Assets within 2 years of full depreciation |

---

## Pre-Built Reports in Access

| Report Name | Purpose | Audience |
|---|---|---|
| rpt_FixedAssetRegister | Full asset listing with category and location | Senior Analysts |
| rpt_DepreciationSchedule | Year-by-year depreciation per asset | Finance Team |
| rpt_AnnualDepreciationSummary | Total depreciation expense by year | Leadership |
| rpt_InventoryReconciliation | Audit results vs register comparison | Auditors |
| rpt_TangibleTaxReturn | Asset values for county tax filing | Tax/Compliance |

---

## Data Entry Forms in Access

| Form Name | Purpose |
|---|---|
| frm_NewAsset | Add new fixed asset to the register |
| frm_UpdateAssetStatus | Change status (Active/Disposed/Under Repair) |
| frm_RecordAudit | Log results of a physical inventory audit |
| frm_AddDepreciation | Enter annual depreciation for an asset |
