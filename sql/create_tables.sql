-- ============================================================
-- Fixed Asset Management System
-- Table Creation Script
-- Simulated Retail Organization (5 Locations)
-- Tools: Microsoft SQL Server / Access-compatible SQL
-- Author: Saeed Rahman
-- ============================================================


-- ------------------------------------------------------------
-- Table 1: Locations
-- Stores the five simulated retail locations
-- ------------------------------------------------------------
CREATE TABLE locations (
    location_id     INT PRIMARY KEY,
    store_number    VARCHAR(10)  NOT NULL,
    city            VARCHAR(50)  NOT NULL,
    state           CHAR(2)      NOT NULL,
    region          VARCHAR(20)  NOT NULL,
    open_date       DATE         NOT NULL
);

INSERT INTO locations VALUES (1, 'STR-001', 'Tampa',       'FL', 'Southeast', '2005-03-15');
INSERT INTO locations VALUES (2, 'STR-002', 'Orlando',     'FL', 'Southeast', '2007-06-01');
INSERT INTO locations VALUES (3, 'STR-003', 'Jacksonville','FL', 'Southeast', '2009-11-20');
INSERT INTO locations VALUES (4, 'STR-004', 'Miami',       'FL', 'Southeast', '2011-04-10');
INSERT INTO locations VALUES (5, 'STR-005', 'Gainesville', 'FL', 'Southeast', '2014-08-05');


-- ------------------------------------------------------------
-- Table 2: Asset Categories
-- Defines asset types, useful life, and depreciation method
-- ------------------------------------------------------------
CREATE TABLE asset_categories (
    category_id     INT PRIMARY KEY,
    category_name   VARCHAR(50)  NOT NULL,
    useful_life_yrs INT          NOT NULL,
    depreciation_method VARCHAR(20) NOT NULL,  -- Straight-Line or Double-Declining
    salvage_pct     DECIMAL(5,2) NOT NULL       -- Salvage value as % of cost
);

INSERT INTO asset_categories VALUES (1, 'Refrigeration Units',   15, 'Straight-Line',    0.05);
INSERT INTO asset_categories VALUES (2, 'Point of Sale Systems',  7, 'Straight-Line',    0.00);
INSERT INTO asset_categories VALUES (3, 'HVAC Systems',          20, 'Straight-Line',    0.10);
INSERT INTO asset_categories VALUES (4, 'Store Fixtures/Shelving',10, 'Straight-Line',   0.00);
INSERT INTO asset_categories VALUES (5, 'Delivery Vehicles',      5, 'Double-Declining', 0.10);
INSERT INTO asset_categories VALUES (6, 'Office Equipment',       5, 'Straight-Line',    0.00);
INSERT INTO asset_categories VALUES (7, 'Security Systems',       8, 'Straight-Line',    0.00);


-- ------------------------------------------------------------
-- Table 3: Assets (Fixed Asset Register)
-- Core table — one row per fixed asset across all locations
-- ------------------------------------------------------------
CREATE TABLE assets (
    asset_id        INT PRIMARY KEY,
    asset_tag       VARCHAR(20)  NOT NULL UNIQUE,
    asset_name      VARCHAR(100) NOT NULL,
    category_id     INT          NOT NULL REFERENCES asset_categories(category_id),
    location_id     INT          NOT NULL REFERENCES locations(location_id),
    purchase_date   DATE         NOT NULL,
    purchase_cost   DECIMAL(12,2) NOT NULL,
    salvage_value   DECIMAL(12,2) NOT NULL,
    useful_life_yrs INT          NOT NULL,
    status          VARCHAR(20)  NOT NULL,  -- Active, Disposed, Under Repair
    serial_number   VARCHAR(50),
    vendor          VARCHAR(100),
    last_audited    DATE
);

-- Tampa (STR-001)
INSERT INTO assets VALUES (1001,'TAG-1001','Walk-In Refrigeration Unit A',1,1,'2010-06-01',45000.00,2250.00,15,'Active','RF-2010-001','Arctic Cold Systems','2025-01-15');
INSERT INTO assets VALUES (1002,'TAG-1002','Walk-In Refrigeration Unit B',1,1,'2010-06-01',45000.00,2250.00,15,'Active','RF-2010-002','Arctic Cold Systems','2025-01-15');
INSERT INTO assets VALUES (1003,'TAG-1003','POS Terminal - Register 1',   2,1,'2018-03-10', 3200.00,   0.00, 7,'Active','POS-2018-001','TechPOS Inc','2025-01-15');
INSERT INTO assets VALUES (1004,'TAG-1004','POS Terminal - Register 2',   2,1,'2018-03-10', 3200.00,   0.00, 7,'Active','POS-2018-002','TechPOS Inc','2025-01-15');
INSERT INTO assets VALUES (1005,'TAG-1005','HVAC Unit - Main Floor',      3,1,'2008-09-20',28000.00,2800.00,20,'Active','HVAC-2008-001','CoolAir Co','2025-01-15');
INSERT INTO assets VALUES (1006,'TAG-1006','Store Shelving - Aisle A',    4,1,'2015-01-05', 8500.00,   0.00,10,'Active','SHF-2015-001','RetailFit Inc','2025-01-15');
INSERT INTO assets VALUES (1007,'TAG-1007','Store Shelving - Aisle B',    4,1,'2015-01-05', 8500.00,   0.00,10,'Active','SHF-2015-002','RetailFit Inc','2025-01-15');
INSERT INTO assets VALUES (1008,'TAG-1008','Delivery Van - Unit 1',       5,1,'2021-07-15',35000.00,3500.00, 5,'Active','VAN-2021-001','Fleet Motors','2025-01-15');
INSERT INTO assets VALUES (1009,'TAG-1009','Security Camera System',      7,1,'2019-04-22',12000.00,   0.00, 8,'Active','SEC-2019-001','SafeGuard Tech','2025-01-15');
INSERT INTO assets VALUES (1010,'TAG-1010','Office Computer - Manager',   6,1,'2022-08-01', 1800.00,   0.00, 5,'Active','OFC-2022-001','Dell Inc','2025-01-15');

-- Orlando (STR-002)
INSERT INTO assets VALUES (2001,'TAG-2001','Walk-In Refrigeration Unit A',1,2,'2012-04-15',47000.00,2350.00,15,'Active','RF-2012-001','Arctic Cold Systems','2025-01-20');
INSERT INTO assets VALUES (2002,'TAG-2002','POS Terminal - Register 1',   2,2,'2019-02-10', 3400.00,   0.00, 7,'Active','POS-2019-001','TechPOS Inc','2025-01-20');
INSERT INTO assets VALUES (2003,'TAG-2003','POS Terminal - Register 2',   2,2,'2019-02-10', 3400.00,   0.00, 7,'Active','POS-2019-002','TechPOS Inc','2025-01-20');
INSERT INTO assets VALUES (2004,'TAG-2004','HVAC Unit - Main Floor',      3,2,'2010-11-30',30000.00,3000.00,20,'Active','HVAC-2010-001','CoolAir Co','2025-01-20');
INSERT INTO assets VALUES (2005,'TAG-2005','Store Shelving - Full Set',   4,2,'2016-06-01',18000.00,   0.00,10,'Active','SHF-2016-001','RetailFit Inc','2025-01-20');
INSERT INTO assets VALUES (2006,'TAG-2006','Delivery Van - Unit 1',       5,2,'2020-03-10',33000.00,3300.00, 5,'Active','VAN-2020-001','Fleet Motors','2025-01-20');
INSERT INTO assets VALUES (2007,'TAG-2007','Security Camera System',      7,2,'2020-08-15',13500.00,   0.00, 8,'Active','SEC-2020-001','SafeGuard Tech','2025-01-20');

-- Jacksonville (STR-003)
INSERT INTO assets VALUES (3001,'TAG-3001','Walk-In Refrigeration Unit A',1,3,'2014-02-20',48000.00,2400.00,15,'Active','RF-2014-001','Arctic Cold Systems','2025-02-01');
INSERT INTO assets VALUES (3002,'TAG-3002','POS Terminal - Register 1',   2,3,'2020-05-15', 3500.00,   0.00, 7,'Active','POS-2020-001','TechPOS Inc','2025-02-01');
INSERT INTO assets VALUES (3003,'TAG-3003','HVAC Unit - Main Floor',      3,3,'2012-07-10',29000.00,2900.00,20,'Active','HVAC-2012-001','CoolAir Co','2025-02-01');
INSERT INTO assets VALUES (3004,'TAG-3004','Store Shelving - Full Set',   4,3,'2017-09-05',17500.00,   0.00,10,'Active','SHF-2017-001','RetailFit Inc','2025-02-01');
INSERT INTO assets VALUES (3005,'TAG-3005','Delivery Van - Unit 1',       5,3,'2022-01-20',36000.00,3600.00, 5,'Active','VAN-2022-001','Fleet Motors','2025-02-01');

-- Miami (STR-004)
INSERT INTO assets VALUES (4001,'TAG-4001','Walk-In Refrigeration Unit A',1,4,'2015-08-10',50000.00,2500.00,15,'Active','RF-2015-001','Arctic Cold Systems','2025-02-10');
INSERT INTO assets VALUES (4002,'TAG-4002','POS Terminal - Register 1',   2,4,'2021-03-01', 3600.00,   0.00, 7,'Active','POS-2021-001','TechPOS Inc','2025-02-10');
INSERT INTO assets VALUES (4003,'TAG-4003','HVAC Unit - Main Floor',      3,4,'2013-05-20',31000.00,3100.00,20,'Active','HVAC-2013-001','CoolAir Co','2025-02-10');
INSERT INTO assets VALUES (4004,'TAG-4004','Store Shelving - Full Set',   4,4,'2018-11-15',19000.00,   0.00,10,'Active','SHF-2018-001','RetailFit Inc','2025-02-10');
INSERT INTO assets VALUES (4005,'TAG-4005','Security Camera System',      7,4,'2021-06-30',14000.00,   0.00, 8,'Active','SEC-2021-001','SafeGuard Tech','2025-02-10');

-- Gainesville (STR-005)
INSERT INTO assets VALUES (5001,'TAG-5001','Walk-In Refrigeration Unit A',1,5,'2018-03-15',52000.00,2600.00,15,'Active','RF-2018-001','Arctic Cold Systems','2025-02-15');
INSERT INTO assets VALUES (5002,'TAG-5002','POS Terminal - Register 1',   2,5,'2022-09-10', 3800.00,   0.00, 7,'Active','POS-2022-001','TechPOS Inc','2025-02-15');
INSERT INTO assets VALUES (5003,'TAG-5003','HVAC Unit - Main Floor',      3,5,'2016-04-05',30500.00,3050.00,20,'Active','HVAC-2016-001','CoolAir Co','2025-02-15');
INSERT INTO assets VALUES (5004,'TAG-5004','Store Shelving - Full Set',   4,5,'2019-07-20',18500.00,   0.00,10,'Active','SHF-2019-001','RetailFit Inc','2025-02-15');
INSERT INTO assets VALUES (5005,'TAG-5005','Delivery Van - Unit 1',       5,5,'2023-02-28',38000.00,3800.00, 5,'Active','VAN-2023-001','Fleet Motors','2025-02-15');


-- ------------------------------------------------------------
-- Table 4: Depreciation Schedule
-- Annual depreciation records per asset
-- ------------------------------------------------------------
CREATE TABLE depreciation (
    depreciation_id   INT PRIMARY KEY,
    asset_id          INT           NOT NULL REFERENCES assets(asset_id),
    fiscal_year       INT           NOT NULL,
    annual_depreciation DECIMAL(12,2) NOT NULL,
    accumulated_depreciation DECIMAL(12,2) NOT NULL,
    book_value        DECIMAL(12,2) NOT NULL
);

-- Straight-Line: (Cost - Salvage) / Useful Life
-- Asset 1001: Walk-In Fridge Tampa, Cost=45000, Salvage=2250, Life=15 => Annual=(45000-2250)/15=2850
INSERT INTO depreciation VALUES (1,1001,2010, 2850.00,  2850.00, 42150.00);
INSERT INTO depreciation VALUES (2,1001,2011, 2850.00,  5700.00, 39300.00);
INSERT INTO depreciation VALUES (3,1001,2012, 2850.00,  8550.00, 36450.00);
INSERT INTO depreciation VALUES (4,1001,2013, 2850.00, 11400.00, 33600.00);
INSERT INTO depreciation VALUES (5,1001,2014, 2850.00, 14250.00, 30750.00);
INSERT INTO depreciation VALUES (6,1001,2015, 2850.00, 17100.00, 27900.00);
INSERT INTO depreciation VALUES (7,1001,2016, 2850.00, 19950.00, 25050.00);
INSERT INTO depreciation VALUES (8,1001,2017, 2850.00, 22800.00, 22200.00);
INSERT INTO depreciation VALUES (9,1001,2018, 2850.00, 25650.00, 19350.00);
INSERT INTO depreciation VALUES (10,1001,2019,2850.00, 28500.00, 16500.00);
INSERT INTO depreciation VALUES (11,1001,2020,2850.00, 31350.00, 13650.00);
INSERT INTO depreciation VALUES (12,1001,2021,2850.00, 34200.00, 10800.00);
INSERT INTO depreciation VALUES (13,1001,2022,2850.00, 37050.00,  7950.00);
INSERT INTO depreciation VALUES (14,1001,2023,2850.00, 39900.00,  5100.00);
INSERT INTO depreciation VALUES (15,1001,2024,2850.00, 42750.00,  2250.00);

-- Asset 1003: POS Terminal Tampa, Cost=3200, Salvage=0, Life=7 => Annual=3200/7=457.14
INSERT INTO depreciation VALUES (16,1003,2018, 457.14,   457.14, 2742.86);
INSERT INTO depreciation VALUES (17,1003,2019, 457.14,   914.28, 2285.72);
INSERT INTO depreciation VALUES (18,1003,2020, 457.14,  1371.42, 1828.58);
INSERT INTO depreciation VALUES (19,1003,2021, 457.14,  1828.56, 1371.44);
INSERT INTO depreciation VALUES (20,1003,2022, 457.14,  2285.70,  914.30);
INSERT INTO depreciation VALUES (21,1003,2023, 457.14,  2742.84,  457.16);
INSERT INTO depreciation VALUES (22,1003,2024, 457.14,  3199.98,    0.02);


-- ------------------------------------------------------------
-- Table 5: Audit Log
-- Tracks physical inventory audits per location per year
-- ------------------------------------------------------------
CREATE TABLE audit_log (
    audit_id        INT PRIMARY KEY,
    location_id     INT      NOT NULL REFERENCES locations(location_id),
    audit_date      DATE     NOT NULL,
    auditor_name    VARCHAR(100) NOT NULL,
    assets_verified INT      NOT NULL,
    discrepancies   INT      NOT NULL DEFAULT 0,
    notes           VARCHAR(500)
);

INSERT INTO audit_log VALUES (1,1,'2025-01-15','Saeed Rahman',10,0,'All assets verified and reconciled. No discrepancies found.');
INSERT INTO audit_log VALUES (2,2,'2025-01-20','Saeed Rahman', 7,0,'All assets verified and reconciled. No discrepancies found.');
INSERT INTO audit_log VALUES (3,3,'2025-02-01','Saeed Rahman', 5,1,'One shelving unit tag could not be located. Flagged for follow-up.');
INSERT INTO audit_log VALUES (4,4,'2025-02-10','Saeed Rahman', 5,0,'All assets verified and reconciled. No discrepancies found.');
INSERT INTO audit_log VALUES (5,5,'2025-02-15','Saeed Rahman', 5,0,'All assets verified and reconciled. No discrepancies found.');
