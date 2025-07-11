DROP TABLE IF EXISTS silver.crm_sales_details;
	
	CREATE TABLE silver.crm_sales_details (
	  sls_ord_num VARCHAR(50),
	  sls_prd_key VARCHAR(50),
	  sls_cust_id INT,
	  sls_order_dt DATE,
	  sls_ship_dt DATE ,
	  sls_due_dt DATE ,
	  sls_sales INT,
	  sls_quantity INT,
	  sls_price INT	
	);
INSERT INTO silver.crm_sales_details (
  sls_ord_num,
  sls_prd_key,
  sls_cust_id,
  sls_order_dt,
  sls_ship_dt,
  sls_due_dt,
  sls_sales,
  sls_quantity,
  sls_price
)
	SELECT
	  sls_ord_num,
	  sls_prd_key,
	  sls_cust_id,
	
	  CASE 
	    WHEN sls_order_dt IS NULL OR sls_order_dt::text !~ '^\d{8}$'
	    THEN NULL
	    ELSE TO_DATE(sls_order_dt::text, 'YYYYMMDD')
	  END AS sls_order_dt,
	
	  CASE 
	    WHEN sls_ship_dt IS NULL OR sls_ship_dt::text !~ '^\d{8}$'
	    THEN NULL
	    ELSE TO_DATE(sls_ship_dt::text, 'YYYYMMDD')
	  END AS sls_ship_dt,
	
	  CASE 
    	WHEN sls_due_dt <= 0 OR LENGTH(sls_due_dt::text) != 8 THEN NULL
    	ELSE TO_DATE(sls_due_dt::text, 'YYYYMMDD')
	END AS sls_due_dt,
	
	  CASE 
	    WHEN sls_sales IS NULL OR sls_sales <= 0 OR sls_sales != sls_quantity * ABS(sls_price)
	    THEN sls_quantity * ABS(sls_price)
	    ELSE sls_sales 
	  END AS sls_sales,
	
	  sls_quantity,
	
	  CASE 
	    WHEN sls_price IS NULL OR sls_price <= 0
	    THEN sls_sales / NULLIF(sls_quantity, 0)
	    ELSE sls_price
	  END AS sls_price
	
	FROM bronze.crm_sales_details;
