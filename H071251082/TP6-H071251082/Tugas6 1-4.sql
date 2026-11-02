SET search_path to classicmodels;

-- 1
SELECT productcode, productname, msrp, quantityinstock, 
	CASE
		WHEN msrp < 50 AND quantityinstock > 500 THEN 'Ekonomis - Stok Tinggi'
		WHEN msrp < 50 AND quantityinstock <= 500 THEN 'Ekonomis - Stok Rendah'
		WHEN (msrp BETWEEN 50 AND 100) AND quantityinstock > 500 THEN 'Harga Menengah - Stok Tinggi'
		WHEN (msrp BETWEEN 50 AND 100) AND quantityinstock <= 500 THEN 'Harga Menengah - Stok Rendah'
		WHEN (msrp > 100) AND quantityinstock <= 500 THEN 'Harga Premium - Stok Rendah'
		ELSE 'Harga Premium - Stok Tinggi'
	END AS kategori_produk
FROM products
ORDER BY msrp DESC;

-- 2
SELECT productcode, 
	   SUM(quantityordered), 
	   COUNT(DISTINCT ordernumber)
FROM orderdetails
GROUP BY productcode
HAVING SUM(quantityordered) > (
	SELECT AVG(quantityordered)
	FROM orderdetails
	) AND COUNT(DISTINCT ordernumber) > 10
ORDER BY SUM(quantityordered) DESC;

-- 3
SELECT productcode, 
	   productname,
	   quantityinstock,
	   msrp
FROM products
WHERE quantityinstock > (
	SELECT AVG(quantityinstock)
	FROM products
) AND
	msrp > (
	SELECT AVG(msrp)
	FROM products
)
ORDER BY quantityinstock DESC;

-- 4
BEGIN;

UPDATE orders
SET status = 'Shipped'
WHERE ordernumber = 10100;

SAVEPOINT status_pengiriman;

UPDATE orders
SET status = 'Cancelled'
WHERE ordernumber = 10100;

ROLLBACK TO SAVEPOINT status_pengiriman;

COMMIT;

















