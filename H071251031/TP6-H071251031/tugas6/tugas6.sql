-- soal1
SELECT productcode, productname, msrp, quantityinstock,
CASE
	WHEN msrp < 50 AND quantityinstock > 500 THEN 'Ekonomis - Stok Tinggi'
	WHEN msrp < 50 AND quantityinstock <= 500 THEN 'Ekonomis - Stok Rendah'
	WHEN msrp > 50 AND msrp < 100 THEN 'Harga Menengah'
	WHEN msrp > 100 THEN 'Harga Premium'
	END AS kategori
FROM products 

-- soal2
SELECT productcode, SUM(quantityordered) AS total_unit_terjual, COUNT(ordernumber) AS jumlah
FROM orderdetails
GROUP BY productcode
HAVING SUM(quantityordered) > (SELECT AVG(quantityordered) FROM orderdetails) AND COUNT(ordernumber) > 10
ORDER BY total_unit_terjual DESC;


-- soal3
SELECT productcode, productname, quantityinstock, msrp
FROM products
GROUP BY productcode
HAVING quantityinstock > (SELECT AVG(quantityinstock) FROM products) AND msrp > (SELECT AVG(msrp) FROM products)
ORDER BY quantityinstock DESC;


-- soal4
BEGIN;

UPDATE orders
SET status = 'Pengiriman'
WHERE ordernumber = 10100;

SAVEPOINT status_pengiriman;

SELECT * FROM orders
WHERE ordernumber = 10100;

UPDATE orders
SET status = 'Batal'
WHERE ordernumber = 10100;

SAVEPOINT status_pengiriman2;

ROLLBACK TO SAVEPOINT status_pengiriman;

COMMIT;
