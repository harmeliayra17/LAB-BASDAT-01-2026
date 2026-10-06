SET search_path TO classicmodels;

-- 1
SELECT orderNumber,
	UPPER (productCode) AS "Kode Produk", 
	quantityOrdered, 
	priceEach 
FROM orderdetails
WHERE (quantityOrdered BETWEEN 20 AND 50 OR priceEach < 30) AND productCode LIKE '%S18%'
ORDER BY quantityOrdered DESC;

-- 2
SELECT customerNumber, 
	   customerName, 
	   country, 
	   creditLimit, 
	   CONCAT(contactFirstName, ' ', contactLastName) AS "Nama Kontak", 
	   (creditLimit - 10000) AS "Selisih Kredit"
FROM customers
WHERE country IN ('USA', 'Canada', 'France') AND creditLimit > 30000
ORDER BY creditLimit DESC;

-- 3
SELECT productCode, 
	   productName,
	   buyPrice, 
	   msrp, 
	   GREATEST(buyPrice, msrp) AS "Harga Tertinggi",
	   LEAST (buyprice,msrp) AS "Harga Terendah" 
FROM products
WHERE productName ILIKE '%car%';

-- 4
SELECT orderNumber, 
	   orderDate,
	   shippedDate, 
	   EXTRACT(YEAR FROM orderDate) AS "Tahun",
	   EXTRACT(MONTH FROM orderDate) AS "Bulan",
	   shippedDate - orderDate AS "Lama Pengiriman",
	   AGE(shippedDate, orderDate) AS "Interval Pengiriman",
	   CURRENT_DATE AS "Tanggal Laporan",
	   CURRENT_TIME AS "Waktu Laporan"
FROM orders
WHERE shippedDate IS NOT NULL;

-- 5
SELECT orderNumber, 
	   orderDate, 
	   shippedDate, 
	   orderDate + INTERVAL '10 days' AS "Estimasi Kirim", 
	   COALESCE(shippedDate, orderDate + INTERVAL '10 days') AS "Tanggal Aktual", 
	   AGE(shippedDate, orderDate) AS "Selisih Waktu" 
FROM orders
WHERE comments ILIKE '%customer%' AND (EXTRACT(MONTH FROM orderdate) BETWEEN 10 AND 12) AND orderNumber % 2 != 0
ORDER BY orderDate DESC;

-- SOAL TAMBAHAN 1
SELECT officeCode, 
	   city, 
	   phone, 
	   country,
	   COALESCE(state, country)
FROM offices
WHERE state IS NULL AND NOT country = 'USA';
-- SOAL TAMBAHAN 2
SELECT productCode, 
	   productName, 
	   quantityInStock,
	   (quantityInStock * buyPrice) AS "Total Aset",
	   (quantityInStock % 12) AS "Sisa Stok Lusinan" 
FROM products
WHERE productLine ILIKE '%motor%' OR quantityInStock > 5000
ORDER BY "Total Aset" DESC;