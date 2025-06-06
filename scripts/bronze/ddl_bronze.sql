/*
=========================================
DROP TABLES AND CREATE
=========================================
SCRIPT PURPOSE:
This script defines the bronze schema, by creating tables and dropping tables if they already exists.
Run this script to redefine the DDL Structure of the bronze schema tables.
*/

DROP TABLE IF EXISTS bronze.crm_cust_info;
DROP TABLE IF EXISTS bronze.crm_sales_details;
DROP TABLE IF EXISTS bronze.crm_prd_info ;
DROP TABLE IF EXISTS bronze.erp_cust_az12;
DROP TABLE IF EXISTS bronze.erp_loc_a101;
DROP TABLE IF EXISTS bronze.erp_px_cat_g1v2;

CREATE TABLE bronze.crm_cust_info(
	cst_id INT,
	cst_key VARCHAR(50),
	cst_firstname VARCHAR(50),
	cst_lastname VARCHAR(50),
	cst_marital_status VARCHAR(10),
	cst_gender VARCHAR(10),
	cst_create_data DATE
);
CREATE TABLE bronze.crm_sales_details(
	sls_ord_num VARCHAR(50),
	sls_prd_key VARCHAR(50),
	sls_cust_id INT,
	sls_order_dt INT,
	sls_ship_dt INT,
	sls_due_dt INT,
	sls_sales INT,
	sls_quantity INT,
	sls_price INT
);
CREATE TABLE bronze.crm_prd_info(
	prd_id INT,
	prd_key VARCHAR(50),
	prd_nm VARCHAR(50),
	prd_cost INT,
	prd_line VARCHAR(50),
	prd_start_dt DATE,
	prd_end_dt DATE
);
CREATE TABLE bronze.erp_cust_az12(
	cid VARCHAR(50),
	bdate DATE,
	gen VARCHAR(50)
);
CREATE TABLE bronze.erp_loc_a101(
	cid VARCHAR(50),
	cntry VARCHAR(50)
);
CREATE TABLE bronze.erp_px_cat_g1v2(
	idty VARCHAR(50),
	cat VARCHAR(50),
	subcat VARCHAR(50),
	maintenance VARCHAR(50)
);

/*Loading/Initialising tables were done by using the copy of psql in the pgadmin4 query tool 
by using this command \copy table_name FROM 'file location'
This command was used multiple times to load each file.
*/

/*
Note: Realised that the column name in crm_cust_info was named data instead of date, thus this sql command was used to rename the column 
in a separate query.
*/
ALTER TABLE bronze.crm_cust_info
RENAME COLUMN cst_create_data to cst_create_date;
