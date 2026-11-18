SET search_path TO classicmodels;

-- 1
SELECT c.contactfirstname, 
	   c.customerName,
	   o.city,
	   CONCAT(e.firstname,' ',e.lastname) AS sales_rep_name
FROM customers AS c
JOIN employees AS e 
	ON c.salesrepemployeenumber = e.employeenumber
JOIN offices AS o
	ON e.officecode = o.officecode
WHERE c.contactfirstname ILIKE 'A%' AND o.city != 'NYC'
ORDER BY c.customername ASC;

-- 2
SELECT c.customername,
	   SUM(p.amount) AS total_payment,
	   MAX(p.amount) AS max_single_payment
FROM customers AS c
JOIN payments AS p
	ON c.customernumber = p.customernumber
GROUP BY c.customername
HAVING SUM(p.amount) > 50000
ORDER BY total_payment DESC;

-- 3
SELECT c.customername, 
	   COUNT(DISTINCT o.ordernumber) AS total_order,
	   ROUND(AVG(od.quantityordered), 2) AS avg_quantity_per_order
FROM customers AS c
JOIN orders AS o
	ON c.customernumber = o.customernumber
JOIN orderdetails AS od
	ON o.ordernumber = od.ordernumber
GROUP BY c.customername
HAVING COUNT(DISTINCT od.ordernumber) > 3 AND ROUND(AVG(od.quantityordered), 2) > 35
ORDER BY total_order DESC, avg_quantity_per_order DESC;

-- 4
SELECT pl.productLine,
	   SUM(od.quantityordered) AS total_terjual,
	   ROUND(AVG(od.priceEach), 2) AS rata_rata_harga,
	   ROUND(AVG((p.msrp - od.priceEach)/ p.msrp * 100), 2)
FROM productlineS AS pl
JOIN products AS p
	ON pl.productline = p.productline
JOIN orderdetails AS od
	ON p.productcode = od.productcode
GROUP BY pl.productline
HAVING SUM(od.quantityordered) > 3000 AND AVG(od.priceEach) > 80
ORDER BY total_terjual DESC;

-- 5
SELECT c.customername,
	   SUM(od.quantityordered * od.priceEach) AS total_transaksi,
	   COUNT(DISTINCT o.ordernumber) AS total_shipped_orders, 
	   ROUND(SUM(od.quantityordered * od.priceEach)/COUNT(DISTINCT o.ordernumber), 2) AS avg_transaction_per_order
FROM customers AS c
JOIN orders AS o
	ON c.customernumber = o.customernumber
JOIN orderdetails AS od
	ON o.ordernumber = od.ordernumber
WHERE o.status = 'Shipped'
GROUP BY c.customernumber
HAVING COUNT(DISTINCT EXTRACT(YEAR FROM o.orderdate)) > 1
ORDER BY total_transaksi DESC
LIMIT 5;

-- 6
SELECT c.customername,
	   c.city AS customer_city,
	   ofc.city AS office_city,
	   SUM(od.quantityordered) AS total_unit_terjual,
	   ROUND(SUM(od.quantityordered * od.priceEach)/COUNT(DISTINCT o.ordernumber), 2) AS avg_nilai_per_order
FROM customers AS c
JOIN employees AS e
	ON c.salesrepemployeenumber = e.employeenumber
JOIN offices AS ofc
	ON e.officecode = ofc.officecode
JOIN orders AS o
	ON c.customernumber = o.customernumber
JOIN orderdetails AS od
	ON o.ordernumber = od.ordernumber
WHERE ofc.territory = 'EMEA'
GROUP BY c.customernumber, ofc.city
HAVING COUNT(DISTINCT EXTRACT(YEAR FROM o.orderdate)) > 2 AND
	   SUM(od.quantityordered) > 1000 AND
	   ROUND(SUM(od.quantityordered * od.priceEach)/COUNT(DISTINCT o.ordernumber), 2) > 10000
ORDER BY ROUND(SUM(od.quantityordered * od.priceEach)/COUNT(DISTINCT o.ordernumber), 2) DESC;