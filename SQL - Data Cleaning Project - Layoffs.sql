-- Data Cleaning

select *
from layoffs;


-- 1. Remove Duplicates if any
-- 2. Standardize the Data
-- 3. Null values or blank values
-- 4. Remove any columns or rows

create table layoff_staging -- create table with all the columns from layoffs
LIKE layoffs;

insert layoff_staging -- adding all the rows from layoffs
select *
from layoffs;

select * from layoff_staging;

-- 1. Remove Duplicates if any

select *,
row_number() over(partition by company,location, industry, total_laid_off, percentage_laid_off, 'date', stage, country, funds_raised_millions) as row_num
from layoff_staging;

-- here every row wnumber should be 1, if it is 2 , it means duplicate as we group by each 

with duplicate_cte as (
select *,
row_number() over(partition by company,location, 
industry, total_laid_off, percentage_laid_off,
 date, stage, country, funds_raised_millions) as row_num
from layoff_staging
)
select * from duplicate_cte
where company = 'Casper';









CREATE TABLE `layoffs_staging2` (
    `company` TEXT,
    `location` TEXT,
    `industry` TEXT,
    `total_laid_off` INT DEFAULT NULL,
    `percentage_laid_off` TEXT,
    `date` TEXT,
    `stage` TEXT,
    `country` TEXT,
    `funds_raised_millions` INT DEFAULT NULL,
    `row_num` INT
)
ENGINE = InnoDB 
DEFAULT CHARSET = utf8mb4 
COLLATE = utf8mb4_0900_ai_ci;


select * from layoffs_staging2;

insert into layoffs_staging2
select *,
row_number() over(partition by company,location, 
industry, total_laid_off, percentage_laid_off,
 date, stage, country, funds_raised_millions) as row_num
from layoff_staging;

set sql_safe_updates = 0;

delete from layoffs_staging2
where row_num > 1;

select * from layoffs_staging2;

select * from layoffs_staging2
where row_num > 1;

# 2. Standardizing Data - means making values consistent
-- across your dataset so they can be accurately analyzed or compared.
--  Standardizing = cleaning + unifying how data is stored and formatted

select company, trim(company)
from layoffs_staging2;

update layoffs_staging2
set company = TRIM(company);

select industry, trim(industry)
from layoffs_staging2;

select * -- check to see crypto in industry if they wrote with differnnt name but similar name such as cryto, crytocurrency
from layoffs_staging2
where industry like 'Crypto%';



update layoffs_staging2
set industry = 'Crypto'
where industry like 'Crypto%' ;

select * 
from layoffs_staging2;

-- checking country column only

select distinct country
from layoffs_staging2
where country like "United State%"
order by 1;

-- Here we have United State and United State. . which should be same so need to update it

update layoffs_staging2
set country = "United States"
where country like "United States%";


-- Date need to be change
-- here date is in text and has to be change to time colum 

select `date`
from layoffs_staging2;

update layoffs_staging2
set `date` = STR_TO_DATE (`date`, '%m/%d/%Y');

-- NEVER DO TO MAIN ORIGINAL TABLE
-- TO CHNAGE 'date' colum from text datatype to 'date' datatype
ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;



-- 3. NULL Values Cleaning 

-- Populating The data if possible



-- to see if industry has null value 
select * 
from layoffs_staging2
where industry is null
or industry ='';


select *
from  layoffs_staging2
where company ="Airbnb";

update layoffs_staging2
set industry ="NULL"
where industry = '';


-- Here
select t1.industry, t2.industry
from layoffs_staging2 t1
join layoffs_staging2 t2 
	on t1.company = t2.company
where (t1.industry is null or t1.industry = '')
and t2.industry is not null;


update layoffs_staging2 t1
join layoffs_staging2 t2 
	on t1.company = t2.company
set t1.industry = t2.industry
where (t1.industry is null )
and t2.industry is not null;



select *
from  layoffs_staging2;

-- remove colums and rows
select *
from layoffs_staging2
where total_laid_off  IS NULL
and percentage_laid_off is NULL;

delete
from layoffs_staging2
where total_laid_off  IS NULL
and percentage_laid_off is NULL;

select *
from  layoffs_staging2;

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;






















