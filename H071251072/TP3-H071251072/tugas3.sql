--SOAL TUPRAK 1-5

SELECT
    orderNumber,
    UPPER(productCode) AS "Kode Produk",
    quantityOrdered,
    priceEach
FROM orderdetails
WHERE (quantityOrdered BETWEEN 20 AND 50 OR priceEach < 30)
  AND LEFT(productCode, 3) = 'S18'
ORDER BY quantityOrdered DESC;

SELECT
    customerNumber,
    customerName,
    country,
    CONCAT(contactFirstName, ' ', contactLastName) AS "Nama Kontak",
    creditLimit,
    creditLimit - 10000 AS "Selisih Kredit"
FROM customers
WHERE country IN ('USA', 'Canada', 'France')
  AND creditLimit > 30000
ORDER BY creditLimit DESC;

SELECT
    productCode,
    productName,
    buyPrice,
    MSRP,
    GREATEST(buyPrice, MSRP) AS "Harga Tertinggi",
    LEAST(buyPrice, MSRP)    AS "Harga Terendah"
FROM products
WHERE productName ILIKE '%car%';

SELECT
    orderNumber,
    orderDate,
    shippedDate,
    EXTRACT(YEAR FROM orderDate)  AS "Tahun",
    EXTRACT(MONTH FROM orderDate) AS "Bulan",
    shippedDate - orderDate       AS "Lama Pengiriman",
    AGE(shippedDate, orderDate)   AS "Interval Pengiriman",
    CURRENT_DATE                  AS "Tanggal Laporan",
    CURRENT_TIME                  AS "Waktu Laporan"
FROM orders
WHERE shippedDate IS NOT NULL;

SELECT
    orderNumber,
    orderDate,
    shippedDate,
    orderDate + INTERVAL '10 days' AS "Estimasi Kirim",
    COALESCE(shippedDate, orderDate + INTERVAL '10 days') AS "Tanggal Aktual",
    AGE(shippedDate, orderDate)   AS "Selisih Waktu",
FROM orders
WHERE comments ILIKE '%customer%'
  AND EXTRACT(MONTH FROM orderDate) BETWEEN 10 AND 12
  AND orderNumber % 2 = 1
ORDER BY orderDate DESC;

--SOAL TAMBAHAN 2 NOMOR

SELECT 
    orderNumber,
	LOWER(status) AS status_ic,
	COALESCE(comments, 'Tidak Ada Catatan')
FROM orders
WHERE NOT status = 'Shipped';

SELECT 
	customerNumber,
	checkNumber,
	paymentDate,
	amount,
	EXTRACT(MONTH FROM paymentDate) AS "Bulan Pembayaran",
	paymentDate + INTERVAL '14 days' AS "Batas Rekonsiliasi"
FROM payments
WHERE EXTRACT(YEAR FROM paymentDate) = 2004 AND amount > 40000
ORDER BY paymentDate ASC;