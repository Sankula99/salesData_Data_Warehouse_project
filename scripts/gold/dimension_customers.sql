CREATE VIEW gold.dim_customers AS 
SELECT 
ROW_NUMBER() OVER (ORDER BY cst_id)AS customer_key,
cst_id AS customer_id,
cst_key AS customer_number,
cst_firstname AS firstname,
cst_lastname AS lastname,
LA.cntry AS country,
cst_marital_status AS marital_status,
CASE WHEN CI.cst_gender != 'Unknown' THEN CI.cst_gender--CRM IS MASTER FOR GENDER INFORMATION
	 ELSE COALESCE(CA.gen,'Unknown')
END AS gender,
ca.bdate AS birthdate,
cst_create_date AS create_date


FROM silver.crm_cust_info CI
LEFT JOIN silver.erp_cust_az12 CA
ON CI.cst_key = CA.cid
LEFT JOIN silver.erp_loc_a101 LA
ON CI.cst_key =LA.cid;
