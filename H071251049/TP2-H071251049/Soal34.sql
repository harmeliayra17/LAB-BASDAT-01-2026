-- SOAL 3: Memberikan Alias Kolom
SELECT 
    customerNumber AS "Nomor Pelanggan", 
    customerName AS "Nama Pelanggan", 
    phone AS "Telepon", 
    country AS "Negara"
FROM customers;

-- SOAL 4: Filter dan Limit 
SELECT productCode, productName, buyPrice
FROM products
WHERE buyPrice > 50
ORDER BY buyPrice DESC
LIMIT 7;

-- SOAL 5: Distinct dan Offset
SELECT DISTINCT country AS "Negara Pelanggan"
FROM customers
ORDER BY country ASC
LIMIT 5 OFFSET 5;