-- 1
INSERT INTO mahasiswa (nim,nama, email, id_prodi)
VALUES ('MHS1', 'Abdul', NULL, 1),
	   ('MHS2', 'Bintang', 'bintang@gmail.com', 2),
	   ('MHS3', 'Carli', 'carli@gmail.com', 3)
RETURNING * ;

-- 2
UPDATE mahasiswa
SET ipk = 3.75
WHERE ipk = 3.50
RETURNING * ;

DELETE FROM mahasiswa
WHERE email IS NULL
RETURNING * ;
-- NO 3
set search_path TO classicmodels;

SELECT 
	customerNumber AS "Nomor Pelanggan", 
	customerName AS "Nama Pelanggan", 
	phone AS "Telepon", 
	country AS "Negara"
FROM customers;

-- NO 4
SELECT productCode, productName, buyPrice FROM products
WHERE buyPrice > 50
ORDER BY buyPrice DESC
LIMIT 7;

-- NO 5
SELECT DISTINCT 
	country AS "Negara Pelanggan" 
FROM customers
ORDER BY country 
LIMIT 5 
OFFSET 5;

-- STUDY CASE
SELECT orderNumber, orderDate, requiredDate, status, customerNumber FROM orders
WHERE status = 'Cancelled' OR status = 'Disputed' OR status = 'On Hold'
ORDER BY orderDate DESC
LIMIT 5;

SELECT productCode, productName, quantityInStock, buyPrice, (quantityInStock * buyPrice) AS "Total Nilai Stok" FROM products
WHERE productLine = 'Motorcycles'
ORDER BY "Total Nilai Stok" DESC
LIMIT 8;