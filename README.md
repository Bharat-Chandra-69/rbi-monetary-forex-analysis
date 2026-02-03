# RBI Monetary & Forex Trend Analysis

## Overview
This project analyzes long-term trends and volatility in RBI monetary indicators and foreign exchange reserves using an end-to-end analytics pipeline. The objective is to understand how key monetary metrics behave across different economic periods.

The project demonstrates a structured workflow covering data exploration, cleaning, transformation, analysis, and dashboarding.

---

## Tech Stack
- **SQL Server** – Data exploration, cleaning, and transformation  
- **Python (Pandas, Matplotlib, Seaborn)** – Time-series analysis and visualizations  
- **Power BI** – Interactive dashboard for reporting insights  

---

## Project Workflow
1. **Data Exploration (SQL)**  
   Explored dataset structure, time coverage, and missing values to understand long-term macroeconomic data.

2. **Data Cleaning & Standardization (SQL)**  
   Converted datatypes, handled formatting inconsistencies, and preserved missing values to maintain data integrity.

3. **Data Transformation (SQL)**  
   Created an analysis-ready dataset and segmented data into economic periods:
   - 2008–2011  
   - 2012–2015  
   - 2016–2019  
   - 2020–2025  

4. **Analysis & Visualization (Python)**  
   Performed time-series analysis, period-wise comparisons, and volatility analysis using Python.

5. **Dashboarding (Power BI)**  
   Built an interactive Power BI dashboard summarizing long-term trends, comparisons across economic periods, and key metrics.

---

## Key Insights
- Call money rates and forex reserves show distinct trends across different economic periods.  
- Volatility patterns vary across economic cycles.  
- Period-based segmentation helps contextualize monetary behavior over time.

---

## Repository Structure

dashboard/screenshots
[RBI dashboard on economic trend.pbit.pbix
Screenshot 2026-02-03 140807.png]


data
[processed
raw]


notebooks
[RBI_data_analysis_.ipynb]


references

sql
[Data cleaning and validation check.sql
data exploring and understanding .sql
data transformation.sql]

.gitignore

LICENSE

README.md


---

## Data Source
Publicly available weekly monetary and foreign exchange data published by the **Reserve Bank of India (RBI)**.  
The dataset is not included in the repository for brevity and data-handling caution.

---

## Notes
All data transformations were handled upstream in SQL. Python and Power BI were used strictly for analysis and reporting to ensure a clean, consistent, and reproducible analytics pipeline.
