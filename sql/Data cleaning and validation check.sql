/*
Stage 2: Data Cleaning & Datatype Standardization
------------------------------------------------
Purpose:
- Convert string-based numeric columns into proper numeric types
- Handle formatting issues such as commas and empty strings
- Preserve original raw data by creating a separate cleaned table

No analytical transformations are performed at this stage.
*/

DROP TABLE IF EXISTS dbo.rbi_cleaned;

SELECT
    /* Date column
       Converted from NVARCHAR to DATE for time-series analysis */
    TRY_CAST(Week_Ended AS DATE) AS week_ended,

    /* Money market rates
       Remove commas and safely convert to INT */
    TRY_CAST(REPLACE(NULLIF(Call_Money, ''), ',', '') AS INT) AS call_money,
    TRY_CAST(REPLACE(NULLIF(Notice_Money, ''), ',', '') AS INT) AS notice_money,
    TRY_CAST(REPLACE(NULLIF(Term_Money, ''), ',', '') AS INT) AS term_money,

    /* Repo market instruments */
    TRY_CAST(REPLACE(NULLIF(Triparty_Repo, ''), ',', '') AS INT) AS triparty_repo,
    TRY_CAST(REPLACE(NULLIF(Market_Repo, ''), ',', '') AS INT) AS market_repo,
    TRY_CAST(REPLACE(NULLIF(Repo_in_Corporate_Bond, ''), ',', '') AS INT) AS repo_corporate_bond,

    /* Forex reserves
       Large macroeconomic values → BIGINT */
    TRY_CAST(REPLACE(NULLIF(Forex_US_million, ''), ',', '') AS BIGINT) AS forex_usd_mn,

    /* Government securities */
    TRY_CAST(REPLACE(NULLIF(Govt_of_India_Dated_Securities, ''), ',', '') AS BIGINT) AS govt_dated_sec,
    TRY_CAST(REPLACE(NULLIF(State_Govt_Securities, ''), ',', '') AS BIGINT) AS state_govt_sec,

    /* Treasury bills */
    TRY_CAST(REPLACE(NULLIF(Treasury_Bills_91_Day, ''), ',', '') AS INT) AS tb_91_day,
    TRY_CAST(REPLACE(NULLIF(Treasury_Bills_182_Day, ''), ',', '') AS INT) AS tb_182_day,
    TRY_CAST(REPLACE(NULLIF(Treasury_Bills_364_Day, ''), ',', '') AS INT) AS tb_364_day,
    TRY_CAST(REPLACE(NULLIF(Treasury_Bills_Cash_Management_Bills, ''), ',', '') AS INT) AS cmb,

    /* Aggregate and RBI values */
    TRY_CAST(REPLACE(NULLIF(Total_Govt_Securities, ''), ',', '') AS BIGINT) AS total_govt_sec,
    TRY_CAST(REPLACE(NULLIF(RBI, ''), ',', '') AS INT) AS rbi
INTO rbi_clean
FROM RBI_DATA
WHERE TRY_CAST(Week_Ended AS DATE) IS NOT NULL;

-- Validate row counts
SELECT
    (SELECT COUNT(*) FROM dbo.RBI_DATA) AS raw_rows,
    (SELECT COUNT(*) FROM dbo.rbi_clean) AS cleaned_rows;

-- Check for unexpected NULLs after conversion
SELECT
    COUNT(*) AS total_rows,
    COUNT(call_money) AS valid_call_money,
    COUNT(forex_usd_mn) AS valid_forex
FROM dbo.rbi_clean;

select * from rbi_clean
