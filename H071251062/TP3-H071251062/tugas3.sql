set search_path TO classicmodels;

SELECT orderNumber, UPPER(productCode) AS "Kode Produk", quantityOrdered, priceEach FROM orderdetails
WHERE ((quantityOrdered BETWEEN 20 AND 50) OR (priceEach < 30)) AND productCode LIKE 'S18%'
ORDER BY quantityOrdered DESC

SELECT customerNumber, customerName, country, contactFirstName || ' ' || contactLastName AS "Nama Kontak", creditLimit, creditLimit - 10000 AS "Selisih Kredit" FROM customers
WHERE country IN ('USA', 'Canada', 'France') AND creditLimit > 30000
ORDER BY creditLimit DESC

SELECT productCode, productName, buyPrice, msrp, GREATEST(buyPrice, msrp) AS "Harga Tertinggi", LEAST(buyPrice, msrp) AS "Harga Terendah" FROM products
WHERE productName ILIKE '%car%'

SELECT orderNumber, orderDate, shippedDate, EXTRACT(YEAR FROM orderDate) AS "Tahun", EXTRACT(MONTH FROM orderDate) AS "Bulan", shippedDate - orderDate AS "Lama Pengiriman", AGE(shippedDate, orderDate) AS "Interval Pengiriman", CURRENT_DATE AS "Tanggal Laporan", CURRENT_TIME AS "Waktu Laporan" FROM orders
WHERE shippedDate IS NOT NULL

SELECT orderNumber, orderDate, shippedDate, orderDate + INTERVAL '10 days' AS "Estimasi Kirim", COALESCE(shippedDate, orderDate + INTERVAL '10 days') AS "Tanggal Aktual", AGE(shippedDate, orderDate) AS "Selisih Waktu" FROM orders
WHERE comments ILIKE '%customer%' AND (EXTRACT(MONTH FROM orderdate) BETWEEN 10 AND 12) AND orderNumber % 2 != 0
ORDER BY orderDate DESC

SELECT employeeNumber, firstName, lastName, email, LOWER(CONCAT(SUBSTRING(firstName, 3), SUBSTRING(lastName, 3))) AS "Username" FROM employees
WHERE jobTitle LIKE '%Sales Rep%' AND (officeCode = '1' OR officeCode = '3' OR officeCode = '2')
ORDER BY employeeNumber DESC

SELECT officeCode, city, phone, country, COALESCE(state, country) AS "Wilayah" FROM offices
WHERE state IS NULL AND  NOT country = 'USA'
ORDER BY officeCode ASC