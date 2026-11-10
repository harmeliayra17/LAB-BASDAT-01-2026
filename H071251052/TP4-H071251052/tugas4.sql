-- NO 1
SELECT customerNumber, SUM(amount) AS total_pembayaran, COUNT(DISTINCT checkNumber) AS frekuensi_setoran, MAX(amount) AS setoran_terbesar FROM payments
GROUP BY customerNumber
HAVING COUNT(DISTINCT checkNumber) > 4 AND AVG(amount) > 20000;

-- NO 2
SELECT customerNumber, SUM(amount) AS total_setoran FROM payments
GROUP BY customerNumber
HAVING SUM(amount) > 80000
ORDER BY total_setoran DESC;

-- NO 3
SELECT productLine AS kategori_produk, COUNT(DISTINCT productCode) AS jumlah_produk, ROUND(AVG(MSRP), 2) AS rata_rata_harga, STRING_AGG(productName, ', ' ORDER BY productName) AS daftar_produk FROM products
GROUP BY productLine
HAVING COUNT(DISTINCT productCode) > 10;

-- NO 4
SELECT DISTINCT reportsTo AS employeeNumber FROM employees
WHERE reportsTo IS NOT NULL
EXCEPT
SELECT employeeNumber FROM employees
WHERE jobTitle LIKE '%VP%' OR jobTitle LIKE '%President%';

-- NO 5
SELECT productCode, SUM(quantityOrdered) AS total_unit_terjual, ROUND(AVG(priceEach), 2) AS rata_rata_harga FROM orderdetails
WHERE priceEach > 100
GROUP BY productCode
HAVING SUM(quantityOrdered) > 50
ORDER BY total_unit_terjual DESC;

-- NO 6
SELECT productCode, SUM(quantityOrdered) AS total_unit_dipesan, SUM(quantityOrdered * priceEach) AS total_pendapatan, ROUND(AVG(priceEach), 2) AS rata_rata_harga, MAX(priceEach) - MIN(priceEach) AS rentang_harga FROM orderdetails
WHERE quantityOrdered > 20
GROUP BY productCode
HAVING SUM(quantityOrdered * priceEach) > 50000
ORDER BY total_pendapatan DESC;

-- NO 7
SELECT customerNumber FROM customers
WHERE creditLimit > 80000
INTERSECT
SELECT customerNumber FROM orders
WHERE status IN ('Cancelled', 'On Hold')
EXCEPT
SELECT customerNumber FROM payments
GROUP BY customerNumber
HAVING SUM(amount) > 100000;