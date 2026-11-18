SET search_path TO classicmodels

-- 1
SELECT 
	customerNumber AS "Nomor Identifikasi Pelanggan",
	SUM(amount) AS "Akumulasi Dana Rill",
	COUNT(*) AS "Jumlah Transaksi",
	MAX(amount) AS "Nilai Setoran Terbesar"
FROM payments
GROUP BY customerNumber
HAVING COUNT(*) > 4 AND AVG(amount) > 20000;

-- 2
SELECT
	customerNumber AS "Nomor Identifikasi Pelanggan",
	SUM(amount) AS "Total Keseluruhan Dana"
FROM payments
GROUP BY customerNumber
HAVING SUM(amount) > 80000
ORDER BY SUM(amount) DESC

-- 3
SELECT 
	productLine AS "Kategori Barang",
	COUNT(*) AS "Jumlah Ragam Produk",
	ROUND(AVG(buyPrice), 2) AS "Rata Rata",
	STRING_AGG(productName, ', ' ORDER BY productName) AS "Nama Produk"
FROM products
GROUP BY productLine
HAVING COUNT(productLine) > 10

-- 4
SELECT DISTINCT reportsto AS "Nomor Identitas"
FROM employees
WHERE reportsto IS NOT NULL
EXCEPT
SELECT DISTINCT employeeNumber 
FROM employees
WHERE jobtitle LIKE 'VP%' OR jobtitle LIKE 'President%'

-- 5
SELECT 
	productCode AS "Produk Kode",
	SUM(quantityOrdered) AS "Total Unit Terjual",
	ROUND(AVG(priceEach), 2) AS "Harga Rata Rata"
FROM orderdetails
WHERE priceEach > 100
GROUP BY productCode
HAVING SUM(quantityOrdered) > 50
ORDER BY SUM(quantityOrdered) DESC

-- 6
SELECT
	productCode AS "Produk Kode",
	SUM(quantityOrdered) AS "Total Unit Terjual",
	SUM(quantityOrdered * priceEach) AS "Pendapatan Kotor",
	ROUND(AVG(priceEach), 2) AS "Harga Rata Rata",
	MAX(priceEach) - MIN(priceEach) AS "Rentang Volatilitas"
FROM orderdetails
WHERE quantityOrdered <= 20
GROUP BY productCode
HAVING SUM(quantityOrdered * priceEach) > 50000
ORDER BY SUM(quantityOrdered * priceEach) DESC

-- 7
SELECT customerNumber 
FROM customers
WHERE creditlimit > 80000
INTERSECT
SELECT customerNumber 
FROM orders
WHERE status IN ('Cancelled', 'On Hold')
EXCEPT
SELECT customerNumber 
FROM payments
GROUP BY customerNumber
HAVING SUM(amount) > 100000

