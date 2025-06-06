/*
=========================================
Transform and Insert crm_cust_info (Customer Information) table.
=========================================
SCRIPT PURPOSE:
This script performs trnasformations such as removing duplicates, converting null values for gender and marital_status, and normalisation/standardisation
*/
TRUNCATE TABLE silver.crm_cust_info;
INSERT INTO silver.crm_cust_info(
cst_id,
cst_key,
cst_firstname,
cst_lastname,
cst_marital_status,
cst_gender,
cst_create_date
)
SELECT
cst_id,
cst_key,
TRIM(cst_firstname) AS cst_firstname,
TRIM(cst_lastname) AS cst_lastname,
CASE WHEN UPPER(cst_marital_status)= 'M' THEN 'Married'
	 WHEN UPPER (cst_marital_status) ='S'THEN 'Single'
	 ELSE 'Unknown'
END cst_marital_status,
CASE WHEN UPPER(cst_gender) ='F'THEN 'Female'
	WHEN UPPER(cst_gender) = 'M' THEN 'Male'
	ELSE 'Unknown'
END cst_gender,
cst_create_date
FROM(
SELECT * ,ROW_NUMBER() OVER(PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_last
FROM bronze.crm_cust_info
)AS sub
WHERE flag_last =1;





