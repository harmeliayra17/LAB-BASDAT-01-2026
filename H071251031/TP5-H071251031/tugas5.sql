--- soal 1
SELECT c.contactfirstname, c.customername, o.city,
CONCAT(e.firstname, ' ', e.lastname) AS sales_rep_name
FROM customers c
JOIN employees e 
ON c.salesrepemployeenumber = e.employeenumber
JOIN offices o 
ON e.officecode = o.officecode
WHERE c.contactfirstname ILIKE 'a%' AND o.city != 'NYC'
ORDER BY c.customername;

--- soal 2
SELECT c.customername, 
SUM(p.amount) AS total_payment, 
MAX(p.amount) AS max_single_payment
FROM customers c
JOIN payments p 
ON c.customernumber = p.customernumber
GROUP BY c.customernumber
HAVING SUM(p.amount) > 50000
ORDER BY total_payment DESC;

--- soal 3
SELECT c.customername, 
COUNT(DISTINCT o.ordernumber) AS total_order, 
ROUND(AVG(od.quantityordered), 2) AS avg_quantity_per_order
FROM customers c
JOIN orders o 
ON c.customernumber = o.customernumber
JOIN orderdetails od 
ON o.ordernumber = od.ordernumber
GROUP BY c.customernumber
HAVING COUNT(DISTINCT o.ordernumber) > 3 AND AVG(od.quantityordered) > 35
ORDER BY total_order DESC, avg_quantity_per_order DESC;

--- soal 4
SELECT p.productline, 
SUM(od.quantityordered) AS total_terjual,
ROUND(AVG(od.priceeach), 2) AS rata_rata_harga,
ROUND(AVG((p.msrp - od.priceeach) / p.msrp * 100), 2) AS avg_discount_percentage
FROM products p
JOIN orderdetails od 
ON p.productcode = od.productcode
GROUP BY p.productline
HAVING SUM(od.quantityordered) > 3000 AND AVG(od.priceeach) > 80
ORDER BY total_terjual DESC;

--- soal 5
SELECT c.customername,
SUM(od.quantityordered * od.priceeach) AS total_transaksi,
COUNT(DISTINCT o.ordernumber) FILTER (WHERE o.status = 'Shipped') AS total_shipped_orders,
ROUND(SUM(od.quantityordered * od.priceeach) / COUNT(DISTINCT o.ordernumber), 2) AS avg_transaction_per_order
FROM customers c
JOIN orders o 
ON c.customernumber = o.customernumber
JOIN orderdetails od 
ON o.ordernumber = od.ordernumber
GROUP BY 
c.customernumber
HAVING COUNT(DISTINCT EXTRACT(YEAR FROM o.orderdate)) > 1
ORDER BY total_transaksi DESC
LIMIT 5;

--- soal 6
SELECT c.customername, c.city AS customer_city, o.city AS office_city,
SUM(od.quantityordered) AS total_unit_terjual,
ROUND(SUM(od.quantityordered * od.priceeach) / COUNT(DISTINCT ord.ordernumber), 2) AS avg_nilai_per_order
FROM customers c
JOIN employees e 
ON c.salesrepemployeenumber = e.employeenumber
JOIN offices o 
ON e.officecode = o.officecode
JOIN orders ord 
ON c.customernumber = ord.customernumber
JOIN orderdetails od 
ON ord.ordernumber = od.ordernumber
WHERE o.territory = 'EMEA'
GROUP BY c.customernumber, o.city
HAVING COUNT(DISTINCT EXTRACT(YEAR FROM ord.orderdate)) > 2 
	AND SUM(od.quantityordered) > 1000
	AND (SUM(od.quantityordered * od.priceeach) / COUNT(DISTINCT ord.ordernumber)) > 10000
ORDER BY avg_nilai_per_order DESC;


-- studycase 1
SELECT CONCAT(e.firstName, ' ' , e.lastName) AS nama_sales, e.jobTitle, c.customerName
FROM customers c
JOIN employees e
ON c.salesrepemployeenumber = e.employeenumber
WHERE e.jobTitle = 'Sales Rep'
ORDER BY e.firstName
LIMIT 10