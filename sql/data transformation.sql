/*
Stage 3: Data Transformation (Analysis-Ready Layer)
---------------------------------------------------
Purpose:
- Prepare a final dataset for analysis and reporting
- Add time-based analytical features
- Segment data into economic periods
- Preserve cleaned numeric values and NULLs

This table is intended to be consumed by:
- Python (analysis & visualization)
- Power BI (dashboarding)
*/

DROP TABLE IF EXISTS dbo.rbi_analysis_ready;

-- 2. Create analysis-ready table explicitly
CREATE TABLE dbo.rbi_analysis_ready (
    week_ended DATE,
    year INT,
    economic_period VARCHAR(15),

    call_money INT,
    notice_money INT,
    term_money INT,

    triparty_repo INT,
    market_repo INT,
    repo_corporate_bond INT,

    forex_usd_mn BIGINT,

    govt_dated_sec BIGINT,
    state_govt_sec BIGINT,
    total_govt_sec BIGINT,

    tb_91_day INT,
    tb_182_day INT,
    tb_364_day INT,
    cmb INT,

    rbi INT
);
GO

-- 3. Insert transformed data
INSERT INTO dbo.rbi_analysis_ready
SELECT
    week_ended,
    YEAR(week_ended) AS year,

    CASE
        WHEN YEAR(week_ended) BETWEEN 2008 AND 2011 THEN '2008-2011'
        WHEN YEAR(week_ended) BETWEEN 2012 AND 2015 THEN '2012-2015'
        WHEN YEAR(week_ended) BETWEEN 2016 AND 2019 THEN '2016-2019'
        ELSE '2020-2025'
    END AS economic_period,

    call_money,
    notice_money,
    term_money,

    triparty_repo,
    market_repo,
    repo_corporate_bond,

    forex_usd_mn,

    govt_dated_sec,
    state_govt_sec,
    total_govt_sec,

    tb_91_day,
    tb_182_day,
    tb_364_day,
    cmb,

    rbi
FROM dbo.rbi_clean
WHERE week_ended IS NOT NULL;


    -- Row count consistency
SELECT
    (SELECT COUNT(*) FROM dbo.rbi_clean) AS cleaned_rows,
    (SELECT COUNT(*) FROM dbo.rbi_analysis_ready) AS analysis_ready_rows;

-- Period distribution check
SELECT
    economic_period,
    COUNT(*) AS records
FROM dbo.rbi_analysis_ready
GROUP BY economic_period
ORDER BY economic_period;

SELECT * FROM dbo.rbi_analysis_ready;

SELECT * FROM dbo.rbi_clean;

-- Structure check
EXEC sp_help rbi_analysis_ready;

-- Data preview now need to eport 
SELECT TOP 5 *
FROM dbo.rbi_analysis_ready;

