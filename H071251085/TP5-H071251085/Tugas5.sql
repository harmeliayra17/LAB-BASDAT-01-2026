SET search_path TO classicmodels, public;

--Nomor 1
SELECT c.contactFirstName AS "Nama Depan Kontak Pelanggan", 
	c.customerName AS "Nama Lengkap Pelanggan",
	c.salesRepEmployeeNumber,
	o.city AS "Kota Tempat Kantor Cabang",
	CONCAT(e.firstName, ' ', e.lastName) AS "Nama Lengkap Sales Representative"
FROM customers c
JOIN employees e
	ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN offices o
	ON e.officeCode = o.officeCode
WHERE c.contactFirstName ILIKE 'A%' AND o.city != 'NYC'
ORDER BY c.customerName;

--Nomor 2
SELECT c.customerName AS "Nama Pelanggan",
	SUM(p.amount) AS total_payment,
	MAX(p.amount) AS max_single_payment
FROM customers c
JOIN payments p
	ON c.customerNumber = p.customerNumber
GROUP BY c.customerNumber
HAVING SUM(p.amount) > 50000
ORDER BY SUM(p.amount) DESC;

--Nomor 3
SELECT c.customerName AS "Nama Pelanggan",
	COUNT(DISTINCT o.orderNumber) AS total_order,
	ROUND(AVG(od.quantityOrdered),2) AS avg_quantity_per_order
FROM customers c
JOIN orders o
	ON o.customerNumber = c.customerNumber
JOIN orderDetails od
	ON od.orderNumber = o.orderNumber
GROUP BY c.customerNumber
HAVING COUNT(DISTINCT o.orderNumber) > 3 AND ROUND(AVG(od.quantityOrdered),2) > 35
ORDER BY COUNT(DISTINCT o.orderNumber) DESC, ROUND(AVG(od.quantityOrdered),2) DESC;

--Nomor 4
SELECT p.productLine,
    SUM(od.quantityOrdered) AS total_terjual,
    ROUND(AVG(od.priceEach), 2) AS rata_rata_harga,
    ROUND(AVG((p.MSRP - od.priceEach) / p.MSRP * 100),2) AS avg_discount_percentage
FROM products p
JOIN orderdetails od
    ON p.productCode = od.productCode
GROUP BY p.productLine
HAVING SUM(od.quantityOrdered) > 3000
   AND AVG(od.priceEach) > 80
ORDER BY total_terjual DESC;

--Nomor 5
SELECT c.customerName,
    SUM(od.quantityOrdered * od.priceEach) AS total_transaksi,
    COUNT(DISTINCT o.orderNumber) AS total_shipped_orders,
    ROUND(SUM(od.quantityOrdered * od.priceEach)/ COUNT(DISTINCT o.orderNumber),2) AS avg_transaction_per_order
FROM customers c
JOIN orders o
    ON c.customerNumber = o.customerNumber
JOIN orderdetails od
    ON o.orderNumber = od.orderNumber
WHERE o.status = 'Shipped'
GROUP BY c.customerNumber
HAVING COUNT(DISTINCT EXTRACT(YEAR FROM o.orderDate)) > 1
ORDER BY total_transaksi DESC
LIMIT 5;

--Nomor 6
SELECT c.customerName,
    c.city AS customer_city,
    o2.city AS office_city,
    SUM(od.quantityOrdered) AS total_unit_terjual,
    ROUND(SUM(od.quantityOrdered * od.priceEach)/ COUNT(DISTINCT o.orderNumber),2) AS avg_nilai_per_order
FROM customers c
JOIN employees e
    ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN offices o2
    ON e.officeCode = o2.officeCode
JOIN orders o
    ON c.customerNumber = o.customerNumber
JOIN orderdetails od
    ON o.orderNumber = od.orderNumber
WHERE o2.territory = 'EMEA'
GROUP BY
    c.customerNumber,
    o2.city
HAVING COUNT(DISTINCT EXTRACT(YEAR FROM o.orderDate)) > 2
   AND SUM(od.quantityOrdered) > 1000
   AND SUM(od.quantityOrdered * od.priceEach)/ COUNT(DISTINCT o.orderNumber) > 10000
ORDER BY avg_nilai_per_order DESC;