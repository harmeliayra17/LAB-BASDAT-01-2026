--1
SELECT productcode, productname, msrp, quantityinstock,
	CASE 
		 WHEN msrp < 50 AND quantityinstock > 500 THEN 'Ekonomis - Stok Tinggi'
		 WHEN msrp < 50 AND quantityinstock <= 500 THEN 'Ekonomis - Stok Rendah'
		 WHEN msrp BETWEEN 50 AND 100 THEN 'Harga Menengah'
		 WHEN msrp > 100 THEN 'Harga Premium'
	END AS kategori
FROM products
ORDER BY kategori DESC;

SELECT * FROM orderdetails;

--2
SELECT productcode, SUM(quantityordered) AS total_unit_terjual, COUNT(DISTINCT ordernumber)
FROM orderdetails
GROUP BY productcode
HAVING SUM(quantityordered) > (SELECT AVG(quantityordered) FROM orderdetails) AND COUNT(DISTINCT ordernumber) > 10
ORDER BY total_unit_terjual DESC;

--3
SELECT productcode, productname, quantityinstock, msrp
FROM products
WHERE quantityinstock > (SELECT AVG(quantityinstock) FROM products) AND msrp > (SELECT AVG(msrp) FROM products) 
ORDER BY quantityinstock DESC;

--4
SELECT *
FROM orders;

SELECT *
FROM orders
WHERE ordernumber = 10100;

BEGIN;

UPDATE orders
SET status = 'Pengiriman'
WHERE ordernumber = 10100;

SAVEPOINT perubahan_status_pertama;

SELECT *
FROM orders
WHERE ordernumber = 10100;

UPDATE orders
SET status = 'Batal'
WHERE ordernumber = 10100;

ROLLBACK TO SAVEPOINT perubahan_status_pertama;

COMMIT;

--5







