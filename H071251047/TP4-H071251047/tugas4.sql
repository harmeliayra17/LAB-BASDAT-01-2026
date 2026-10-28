--NOMOR 1
SELECT 
	customernumber, 
	SUM(amount) AS total_transaksi, 
	COUNT(checknumber) AS "Jumlah Frekuensi Transaksi", 
	MAX(amount) AS Traksaksi_Terbesar 
FROM payments
GROUP BY customernumber
HAVING COUNT(checknumber) > 4 AND AVG(amount) > 20000;

--NOMOR 2
SELECT 
	customernumber, 
	SUM(amount) AS total_transaksi
FROM payments
GROUP BY customernumber
HAVING SUM(amount) > 80000
ORDER BY total_transaksi DESC;

--NOMOR 3
SELECT 
	productline,
	COUNT(productcode) AS Jumlah_ragam_product,
	ROUND(AVG(msrp),2) AS rata_rata_harga_jual,
	STRING_AGG(productname, ', ' ORDER BY productline) AS Nama_produk
FROM products
GROUP BY productline
HAVING COUNT(productcode) > 10;

--NOMOR 4
SELECT employeenumber AS nomor_staff, jobtitle
FROM employees
WHERE employeenumber IN (SELECT DISTINCT reportsto FROM employees)
EXCEPT
SELECT employeenumber AS nomor_staff, jobtitle
FROM employees
WHERE jobtitle ILIKE '%vp%' OR jobtitle ILIKE '%presiden%'; 

--NOMOR 5
SELECT
	productcode,
	SUM(quantityordered) AS total_unit_terjual,
	ROUND(AVG(priceeach), 2) AS rata_rata_harga
FROM orderdetails
WHERE priceeach > 100
GROUP BY productcode
HAVING SUM(quantityordered) > 50
ORDER BY total_unit_terjual DESC;

--NOMOR 6
SELECT
	productcode,
	SUM(quantityordered) AS jumlah_barang_dipesan,
	SUM(quantityordered * priceeach) AS laba_kotor,
	ROUND(AVG(priceeach), 2) AS rata_rata_harga_barang,
	MAX(priceeach) - MIN(priceeach) AS selisih_harga
FROM orderdetails
WHERE NOT quantityordered <= 20
GROUP BY productcode
HAVING SUM(quantityordered * priceeach) > 50000
ORDER BY laba_kotor DESC;

--NOMOR 7
SELECT customernumber
FROM customers
WHERE creditlimit > 80000
	INTERSECT
SELECT customernumber
FROM orders
WHERE status IN('Cancelled', 'On Hold')
	EXCEPT
SELECT customernumber
FROM payments
GROUP BY customernumber
HAVING SUM(amount) > 100000;

---SC
SELECT	productline,
		COUNT(productcode) AS jumlah_produk, 
		ROUND(AVG(msrp - buyprice),2) AS rata_margin 
FROM products
WHERE quantityinstock > 1000
GROUP BY productline
HAVING COUNT(productline) >= 5
ORDER BY rata_margin DESC;
