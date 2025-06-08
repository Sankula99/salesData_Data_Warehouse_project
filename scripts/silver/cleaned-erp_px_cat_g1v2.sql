TRUNCATE silver.erp_px_cat_g1v2;
INSERT INTO silver.erp_px_cat_g1v2(idty,cat,subcat,maintenance)
SELECT idty,
cat,
subcat,
maintenance 
FROM bronze.erp_px_cat_g1v2;
