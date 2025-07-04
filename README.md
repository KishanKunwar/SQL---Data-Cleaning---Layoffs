# SQL---Data-Cleaning---Layoffs
SQL Data Cleaning Project: Layoff Dataset
This project demonstrates data cleaning using SQL on a dataset of company layoffs during economic downturns. The project is built step-by-step using MySQL, focusing on practical data wrangling techniques to prepare the dataset for further analysis or visualization.

📁 Dataset Overview
The dataset contains information on layoffs across tech companies, with the following columns:

company

location

industry

total_laid_off

percentage_laid_off

date (in mm/dd/yyyy format)

stage

country

funds_raised_millions

🧠 Key Skills Demonstrated
Creating staging tables

Removing duplicate rows using ROW_NUMBER()

Standardizing inconsistent text data (e.g., trimming, renaming)

Handling missing (NULL) and blank values

Using subqueries and joins to auto-fill missing values

Data type conversion (e.g., converting text to DATE)

Dropping unnecessary rows and columns

🛠️ Steps Performed
1. 🧱 Staging the Data
Created a staging table (layoff_staging) as a working copy of the original table.

2. 🔁 Removing Duplicates
Used ROW_NUMBER() window function to detect duplicates based on all relevant columns.

Removed rows with row_num > 1.

3. 🔧 Standardizing Data
Trimmed whitespace from fields like company, industry, and country.

Unified inconsistent naming (e.g., all variations like “Cryptocurrency”, “Crypto Co.” → “Crypto”).

Cleaned up country names like “United States.” → “United States”.

4. 🕓 Converting Date Format
Transformed the date column from text to DATE using STR_TO_DATE().

Modified the column type using ALTER TABLE.

5. 🧩 Handling Null and Blank Values
Identified rows with missing values in key fields.

Used self-joins and subqueries to fill in missing industry values from other rows of the same company.

Deleted rows where both total_laid_off and percentage_laid_off were null.

6. 🧹 Final Cleanup
Dropped the helper column row_num after duplicate removal.


