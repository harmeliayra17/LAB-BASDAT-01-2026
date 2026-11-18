-- soal 1

SELECT ordernumber, UPPER(productcode) AS Kode_Produk, quantityordered, priceeach FROM orderdetails
WHERE (quantityordered BETWEEN 20 AND 50 OR priceeach < 30) AND LEFT(productcode, 3) = 'S18'
ORDER BY quantityordered DESC;


-- soal 2

SELECT customernumber, customername, country, CONCAT(contactfirstname, ' ', contactlastname) AS Nama_Kontak, 
creditlimit, creditlimit - 10000 AS Selisih_Kredit FROM customers
WHERE (country = 'USA' OR country = 'Canada' OR country = 'France') AND creditlimit > 30000
ORDER BY creditlimit DESC;


-- soal 3

SELECT productcode, productname, buyprice, msrp,  GREATEST(buyprice, MSRP) AS Harga_Tertinggi, 
LEAST(buyprice, msrp) AS Harga_Terendah FROM products
WHERE productname ILIKE '%car%';


-- soal 4

SELECT ordernumber, orderdate, shippeddate, EXTRACT(YEAR FROM orderdate) AS Tahun, 
EXTRACT(MONTH FROM orderdate) AS Bulan, (shippeddate - orderdate) AS Lama_Pengiriman, 
AGE(shippeddate, orderdate) AS Interval_Pengiriman, CURRENT_DATE AS Tanggal_Laporan, 
CURRENT_TIME AS Waktu_Laporan FROM orders
WHERE shippeddate IS NOT NULL;


-- soal 5

SELECT ordernumber, orderdate, shippeddate, orderdate + INTERVAL '10 days' AS "Estimasi Kirim", 
COALESCE(shippeddate, orderdate + INTERVAL '10 days') AS "Tanggal Aktual", 
AGE(shippeddate, orderdate) AS "Selisih Waktu" FROM orders
WHERE comments ILIKE '%customer%' AND EXTRACT(MONTH FROM orderdate) BETWEEN 10 AND 12 AND (ordernumber % 2) = 1
ORDER BY orderdate DESC;


-- study case 1

SELECT customernumber, checknumber, paymentdate, amount, EXTRACT(MONTH FROM paymentdate) AS "Bulan Pembayaran", paymentdate + INTERVAL '14 days' AS "Batas Rekonsiliasi" FROM payments
WHERE EXTRACT(YEAR FROM paymentdate) = 2004 AND amount > 40000
ORDER BY paymentdate;

-- study case 2

SELECT customername, phone, country, creditlimit, CONCAT(RIGHT(phone, 4), customernumber)AS "Kode Kupon" FROM customers
WHERE country IN ('Australia', 'New Zealand') AND (creditlimit BETWEEN 50000 AND 100000)
ORDER BY creditlimit DESC;