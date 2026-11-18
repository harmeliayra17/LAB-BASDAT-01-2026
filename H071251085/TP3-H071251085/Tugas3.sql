SET search_path TO classicmodels;

--soal 1
SELECT orderNumber, UPPER (productCode)  AS "Kode Produk", quantityOrdered, priceEach FROM orderDetails
WHERE (quantityOrdered BETWEEN 20 AND 50 OR priceEach < 30) AND LEFT(productCode, 3) = 'S18'
ORDER BY quantityOrdered DESC;

--soal 2
SELECT customerNumber, customerName, country, 
	CONCAT(contactFirstName,' ',contactLastName) AS "Nama Kontak", creditLimit, (creditLimit-10000) AS "Selisih Kredit" 
	FROM customers
WHERE country IN ('USA','France','Canada') AND creditLimit > 30000
ORDER BY creditLimit DESC;

--soal 3
SELECT productCode, productName, buyPrice, MSRP, 
GREATEST(buyPrice, MSRP) AS "Nilai Tertinggi",
LEAST(buyPrice, MSRP) AS "Nilai Terendah" FROM products
WHERE productName ILIKE '%car%';

--soal 4
SELECT orderNumber, orderDate, shippedDate,
EXTRACT (YEAR FROM orderDate) AS "Tahun", EXTRACT(MONTH FROM orderDate) AS "Bulan",
shippedDate - orderDate AS "Lama Pengiriman",  AGE (shippedDate, orderDate) AS "Interval Pengiriman",
CURRENT_DATE AS "Tanggal Laporan", CURRENT_TIME AS "Waktu Laporan" FROM orders;

--soal 5
SELECT orderNumber, orderDate, shippedDate, (orderDate + INTERVAL '10 days') AS "Estimasi Kirim",
shippedDate AS "Tanggal Aktual", AGE (shippedDate, orderDate) AS "Selisih Waktu"
FROM orders
WHERE comments ILIKE '%customer%' AND orderNumber % 2 = 1 AND EXTRACT(MONTH FROM orderDate) BETWEEN 10 AND 12 
ORDER BY orderDate DESC;

--soal tambahan 1
SELECT productCode, productName, quantityInStock, (quantityInStock * buyPrice) AS "Total Aset", 
	(quantityInStock%12) AS "Sisa Stok Lusinan" FROM products
WHERE productLine ILIKE ('%motor%') OR quantityInStock > 5000
ORDER BY quantityInStock * buyPrice DESC;

--soal tambahan 2
SELECT customerNumber, checkNumber, paymentDate, amount, 
EXTRACT(MONTH FROM paymentDate) AS "Bulan Pembayaran", 
(paymentDate + INTERVAL '14 days') AS "Batas Rekonsiliasi" FROM payments
WHERE EXTRACT(YEAR FROM paymentDate) = '2004' AND amount > 40000
ORDER BY paymentDate ASC;



