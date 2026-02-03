create database project
use project

/*
Stage 1: Data Exploration
------------------------
Purpose:
- Understand structure and content of the raw RBI dataset
- Identify datatype issues and formatting inconsistencies
- Decide correct datatypes for each column

No data is modified in this stage.
*/

-- 1. View table structure
EXEC sp_help rbi_data

-- 2. Preview sample records
SELECT TOP 10 *
FROM rbi_data;

-- 3. Check date column format consistency
SELECT TOP 10 Week_Ended
FROM rbi_data
WHERE Week_Ended IS NOT NULL;

-- 4. Identify non-numeric characters in numeric-like columns
-- This helps decide cleaning logic later
SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN Call_Money LIKE '%,%' THEN 1 ELSE 0 END) AS call_money_with_commas,
    SUM(CASE WHEN Call_Money LIKE '%[^0-9,]%' THEN 1 ELSE 0 END) AS call_money_non_numeric
FROM rbi_data;

-- 5. Repeat checks for large-value columns (example: Forex)
SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN Forex_US_million LIKE '%,%' THEN 1 ELSE 0 END) AS forex_with_commas,
    SUM(CASE WHEN Forex_US_million LIKE '%[^0-9,]%' THEN 1 ELSE 0 END) AS forex_non_numeric
FROM rbi_data;
