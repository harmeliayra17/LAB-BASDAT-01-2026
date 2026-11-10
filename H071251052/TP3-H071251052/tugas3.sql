-- NO. 1
SELECT orderNumber, UPPER(productCode) AS "Kode Produk", quantityOrdered, priceEach FROM orderdetails
WHERE (LEFT(productCode, 3) = 'S18') AND ((quantityOrdered BETWEEN 20 AND 50) OR (priceEach < 30))
ORDER BY quantityOrdered DESC;

-- NO. 2
SELECT customerNumber, customerName, country, creditLimit, (contactFirstName || ' ' || contactLastName) AS NamaKontak, CONCAT(contactFirstName, ' ', contactLastName) AS nama , (creditLimit - 10000) AS "Selisih Kredit" FROM customers
WHERE country IN ('USA', 'France', 'Canada') AND (creditLimit > 30000)
ORDER BY creditLimit DESC;

-- NO. 3
SELECT productCode, productName, buyPrice, MSRP, GREATEST(buyPrice, MSRP) AS "Harga Tertinggi", LEAST(buyPrice, MSRP) AS "Harga Terendah" FROM products
WHERE LOWER(productName) ILIKE '%car%';

-- NO. 4
SELECT orderNumber, orderDate, shippedDate, EXTRACT(YEAR FROM orderDate) AS tahun, EXTRACT(MONTH FROM orderDate) AS bulan, (shippedDate - orderDate) AS "Jumlah Hari", AGE(shippedDate, orderDate) AS "Lama Interval", CURRENT_DATE AS "Tanggal Laporan", CURRENT_TIME AS "Waktu Laporan" FROM orders
WHERE shippedDate IS NOT NULL;

-- NO. 5
SELECT orderNumber, orderDate, shippedDate, (orderDate + INTERVAL '10 days') AS "Estimasi Kirim", COALESCE(shippedDate, orderDate + INTERVAL '10 days') AS "Tanggal Aktual", AGE(shippedDate, orderDate) AS "Selisih Waktu" FROM orders
WHERE comments ILIKE '%customer%' AND EXTRACT(MONTH FROM orderDate) BETWEEN 10 AND 12 AND orderNumber % 2 = 1
ORDER BY orderDate DESC;

-- SC 1
SELECT customerName, phone, country, creditLimit, CONCAT(RIGHT(phone, 4), '', customerNumber) AS "Kode Kupon" FROM customers
WHERE (country IN ('Australia', 'New Zealand')) AND (creditLimit BETWEEN 50000 AND 100000)
ORDER BY creditLimit DESC;


SELECT officeCode from employees;
-- SC 2
SELECT employeeNumber, firstName, lastName, email, LOWER(CONCAT(SUBSTRING(firstName, 1, 3), SUBSTRING(lastName, 1, 3))) AS Username FROM employees
WHERE jobTitle = 'Sales Rep' AND officeCode BETWEEN '1' AND '3'
ORDER BY employeeNumber ASC;