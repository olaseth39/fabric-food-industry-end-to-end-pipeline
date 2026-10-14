End-to-End Data Engineering Pipeline in Microsoft Fabric
This project demonstrates a fully automated, end-to-end Data Engineering solution built in Microsoft Fabric for a Food & Beverage (F&B) client. The pipeline ingests raw CSV data from OneDrive, processes it through a Medallion Architecture (Bronze, Silver, Gold), and delivers actionable business insights via an interactive Power BI dashboard.

🏗️ Architecture
The solution utilizes a Medallion Architecture:

Bronze Layer: Raw CSV files ingested live from OneDrive using a OneLake Shortcut.
Silver Layer: Cleaned and transformed Delta Tables processed dynamically using PySpark.
Gold Layer: A structured Fabric Data Warehouse utilizing a Star Schema for reporting.
Architecture Diagram

🛠️ Tech Stack
Platform: Microsoft Fabric (Lakehouse, Warehouse, Data Factory, Power BI)
Languages: PySpark (Python), T-SQL, DAX
Concepts: Medallion Architecture, Star Schema, Dynamic Automation, Delta Lake
✨ Key Features & Highlights
1. Dynamic Bronze-to-Silver Ingestion (PySpark)
Instead of hardcoding file paths, the PySpark script uses mssparkutils.fs.ls to dynamically scan the OneDrive shortcut for new folders and files. It automatically creates schemas and converts raw CSVs into optimized Delta tables. If a new folder is added, the code requires zero changes.

Handles Schema Mismatches (overwriteSchema = true)
Protects manually transformed tables (like joined dproduct) via exclusion lists.
2. Dynamic Warehouse Loading (T-SQL)
A dynamic Stored Procedure (edw.DynamicWarehouseLoad) loops through the Silver Lakehouse metadata using STRING_AGG and sp_executesql to automatically drop, create, and load tables into the Fabric Warehouse.

3. Pipeline Orchestration & Automation
A Fabric Data Pipeline orchestrates the flow:

Triggers the PySpark Notebook (Bronze -> Silver).
On success, triggers the Stored Procedure (Silver -> Gold Warehouse).
Scheduled for nightly automated execution.
4. Power BI Dashboard & Semantic Modeling
Built a robust Star Schema connecting Dim and Fact tables.
Created explicit DAX measures (Total Revenue, Average Order Value, Total Order Volume).
Designed an executive dashboard featuring time-series trends, top-selling products, and revenue by brand.
Power BI Dashboard

📂 Repository Structure
/notebooks: Contains the dynamic PySpark code for Bronze-to-Silver ingestion.
/sql: Contains T-SQL scripts for Stored Procedures and Warehouse automation.

Pipeline Orchestration
The entire ETL process is automated using a Fabric Data Pipeline. The PySpark Notebook triggers first, and upon success, the Stored Procedure loads the data into the Warehouse.

Data Pipeline Architecture

Pipeline Succeeded

This repository includes two loading strategies: a dynamic full-load script for rapid POC deployment, and an incremental upsert script using WHERE NOT EXISTS for production-level optimization on large datasets.
/powerbi: Contains DAX formulas used in the Semantic Model.
🚀 How to Reproduce
Create an LH_Bronze and LH_Silver Lakehouse in Fabric.
Establish a OneLake Shortcut to your OneDrive folder in LH_Bronze.
Run the PySpark notebook to generate Silver Delta Tables.
Execute the T-SQL scripts in a new Fabric Warehouse.
Connect a Power BI Semantic Model to the Warehouse and build visuals.
