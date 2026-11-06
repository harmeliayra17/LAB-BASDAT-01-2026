--no 1
SELECT 
    customerNumber,
    SUM(amount) AS total_setoran,
    COUNT(amount) AS frekuensi_transaksi,
    MAX(amount) AS setoran_terbesar
FROM payments
GROUP BY customerNumber
HAVING COUNT(amount) > 4 
   AND AVG(amount) > 20000;

--no 2
SELECT 
    customerNumber,
    SUM(amount) AS total_setoran
FROM payments
GROUP BY customerNumber
HAVING SUM(amount) > 80000
ORDER BY total_setoran DESC;

--no 3
SELECT 
    productLine AS nama_kategori,
    COUNT(productCode) AS jumlah_ragam_produk,
    ROUND(AVG(MSRP), 2) AS rata_rata_msrp
FROM products
GROUP BY productLine
HAVING COUNT(productCode) > 10;

--no 4
SELECT reportsTo 
FROM employees
EXCEPT
SELECT employeeNumber 
FROM employees 
WHERE jobTitle LIKE '%VP%' OR jobTitle LIKE '%President%';

--no 5
SELECT 
    productCode,
    SUM(quantityOrdered) AS total_unit_terjual,
    ROUND(AVG(priceEach), 2) AS rata_rata_harga_riil
FROM orderdetails
WHERE priceEach > 100
GROUP BY productCode
HAVING SUM(quantityOrdered) > 50
ORDER BY total_unit_terjual DESC;

--no 6
SELECT 
    productCode,
    SUM(quantityOrdered) AS total_unit_dipesan,
    SUM(quantityOrdered * priceEach) AS pendapatan_kotor,
    ROUND(AVG(priceEach), 2) AS rata_rata_harga_riil
FROM orderdetails
WHERE quantityOrdered > 20
GROUP BY productCode
HAVING SUM(quantityOrdered * priceEach) > 50000
ORDER BY pendapatan_kotor DESC;

--no 7
(
    SELECT customerNumber 
    FROM customers 
    WHERE creditLimit > 80000
    INTERSECT
    SELECT customerNumber 
    FROM orders 
    WHERE status IN ('Cancelled', 'On Hold')
)
EXCEPT
(
    SELECT customerNumber 
    FROM payments 
    GROUP BY customerNumber 
    HAVING SUM(amount) > 100000
);