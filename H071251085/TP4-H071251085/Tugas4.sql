SET search_path TO classicmodels;

-- nomor 1
SELECT customerNumber,
	SUM(amount) AS "Total Akumulasi Dana",
	COUNT(*) AS "Jumlah Frekuensi Transaksi",
	MAX(amount) AS "Nilai Setoran Tunai Terbesar" 
FROM payments
GROUP BY customerNumber
HAVING COUNT(*) > 4 AND AVG(amount) > 20000;

-- nomor 2
SELECT customerNumber,
	SUM(amount) AS "Total Keseluruhan Dana"
FROM payments
GROUP By customerNumber
HAVING SUM(amount) > 80000
ORDER BY SUM(amount) DESC;

SELECT * FROM products;

-- nomor 3
45

SELECT * FROM employees;

-- nomor 4
SELECT DISTINCT reportsTo
FROM employees
WHERE reportsTo IS NOT NULL 
EXCEPT
SELECT employeeNumber
FROM employees
WHERE jobTitle LIKE '%VP%' OR jobTitle LIKE '%President%';

-- nomor 5
SELECT productCode,
	SUM(quantityOrdered),
	ROUND(AVG(priceEach),2)
	FROM orderDetails
WHERE priceEach > 100
GROUP BY productCode
HAVING SUM(quantityOrdered) > 50
ORDER BY SUM(quantityOrdered) DESC;

SELECT * FROM orderDetails
ORDER BY quantityOrdered;

-- nomor 6
SELECT 
	productCode AS produk_kode,
	SUM(quantityOrdered) AS "total keseluruhan unit fisik",
	SUM(quantityOrdered*priceEach) AS "Estimasi Pendapatan Kotor",
	ROUND(AVG(priceEach), 2) AS "Rata-rata Harga Riil",
	(MAX(priceEach)-MIN(priceEach)) AS "rentang volatilitas"
FROM orderDetails
WHERE quantityOrdered > 20
GROUP BY productCode
HAVING SUM(quantityOrdered*priceEach) > 50000
ORDER BY SUM(quantityOrdered*priceEach) DESC;

SELECT * FROM orders;

--nomor 7
SELECT customerNumber FROM customers
WHERE creditLimit > 80000
INTERSECT
SELECT customerNumber FROM orders
WHERE status IN ('Cancelled', 'On Hold')
EXCEPT
SELECT customerNumber FROM payments
GROUP BY customerNumber
HAVING SUM(amount) > 100000;

SELECT * FROM products;

--soal tambahan
SELECT productLine,
	COUNT (productCode) AS "Jumlah Produk",
	ROUND(AVG(MSRP-buyPrice), 2) AS "Rata-rata margin"
FROM products
WHERE quantityInStock > 1000
GROUP BY productLine
HAVING COUNT(productCode) > 5
ORDER BY ROUND(AVG(MSRP-buyPrice)) DESC;

