--1
SELECT c.contactfirstname, c.customername, o.city, CONCAT(e.firstname, ' ', e.lastname) AS sales_rep_name
FROM customers c
JOIN employees e
ON c.salesrepemployeenumber = e.employeenumber
JOIN offices o
ON e.officecode = o.officecode
WHERE c.contactfirstname ILIKE 'A%' AND NOT o.city = 'NYC' 
ORDER BY c.customername ASC;

--2
SELECT c.customername, SUM(p.amount) AS total_payment, MAX(p.amount) AS max_single_payment
FROM customers c
JOIN payments p
ON p.customernumber = c.customernumber
GROUP BY c.customername
HAVING SUM(p.amount) > 50000
ORDER BY total_payment DESC;


--3
SELECT c.customername, COUNT(DISTINCT o.ordernumber) AS total_order, ROUND(AVG(od.quantityordered), 2) AS avg_quantity_per_order
FROM customers c
JOIN orders o
ON o.customernumber = c.customernumber
JOIN orderdetails od
ON o.ordernumber = od.ordernumber
GROUP BY c.customername
HAVING COUNT(DISTINCT o.ordernumber) > 3 AND AVG(od.quantityordered) > 35
ORDER BY total_order DESC;

--4
SELECT	p.productline, 
		SUM(od.quantityordered) AS total_terjual, 
		ROUND(AVG(od.priceeach), 2) AS rata_rata_harga, 
		ROUND(AVG((msrp - priceeach) / msrp * 100), 2) AS avg_discount_percentage
FROM products p
JOIN orderdetails od
ON od.productcode = p.productcode
GROUP BY p.productline
HAVING SUM(od.quantityordered) > 3000 AND AVG(od.priceeach) > 80
ORDER BY total_terjual DESC;

--5
SELECT	c.customername, 
		SUM(od.priceeach * od.quantityordered) AS total_transaksi, 
		COUNT(o.status) FILTER(WHERE o.status = 'Shipped') AS total_shipped_orders, 
		ROUND(SUM(od.priceeach * od.quantityordered) / COUNT(DISTINCT o.ordernumber), 2) AS avg_transaction_per_order, 
		COUNT(DISTINCT EXTRACT (YEAR FROM o.orderdate)) AS tahun_pesanan
FROM customers AS c
JOIN orders AS o
ON o.customernumber = c.customernumber
JOIN orderdetails AS od
ON od.ordernumber = o.ordernumber
GROUP BY c.customername
HAVING COUNT(DISTINCT EXTRACT(YEAR FROM o.orderdate)) > 1
ORDER BY total_transaksi DESC
LIMIT 5;

--6
SELECT	c.customername, 
		c.city AS customer_city, 
		ofc.city AS office_city, 
		SUM(od.quantityordered) AS total_unit_terjual, 
		ROUND(SUM(od.priceeach * od.quantityordered) / COUNT(DISTINCT o.ordernumber), 2) AS avg_nilai_per_order,
		COUNT(DISTINCT EXTRACT(YEAR FROM o.orderdate)) AS tahun_pesanan
FROM customers c
JOIN employees e ON e.employeenumber = c.salesrepemployeenumber
JOIN offices ofc ON e.officecode = ofc.officecode
JOIN orders o ON o.customernumber = c.customernumber
JOIN orderdetails od ON od.ordernumber = o.ordernumber
WHERE ofc.territory = 'EMEA'
GROUP BY c.customername, c.city, ofc.city
HAVING	COUNT(DISTINCT EXTRACT(YEAR FROM o.orderdate)) > 2 AND 
		SUM(od.quantityordered) > 1000 AND 
		SUM(od.priceeach * od.quantityordered) / COUNT(DISTINCT o.ordernumber) > 10000
ORDER BY avg_nilai_per_order DESC;




