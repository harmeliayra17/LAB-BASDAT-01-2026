-- NO. 1
SELECT c.contactfirstname, c.customername, o.city, CONCAT(e.firstname, ' ', e.lastname) AS sales_rep_name
FROM customers AS c
INNER JOIN employees AS e
ON c.salesrepemployeenumber = e.employeenumber
INNER JOIN offices AS o
ON e.officecode = o.officecode
WHERE c.contactfirstname ILIKE 'a%' AND o.city != 'NYC'
ORDER BY c.customername ASC;

-- NO. 2
SELECT c.customername, SUM(p.amount) AS total_payment, MAX(p.amount) AS max_single_payment
FROM customers AS c
INNER JOIN payments AS p
ON c.customernumber = p.customernumber
GROUP BY c.customername
HAVING SUM(p.amount) > 50000
ORDER BY total_payment DESC;

-- NO. 3
SELECT c.customername, COUNT(DISTINCT o.ordernumber) AS total_order, AVG(ROUND(od.quantityordered, 2)) AS avg_quantity_per_order
FROM customers AS c
INNER JOIN orders AS o
ON c.customernumber = o.customernumber
INNER JOIN orderdetails AS od
ON o.ordernumber = od.ordernumber
GROUP BY c.customername
HAVING COUNT(DISTINCT o.ordernumber) > 3 AND AVG(od.quantityordered) > 35
ORDER BY total_order DESC, avg_quantity_per_order DESC;

-- NO. 4
SELECT p.productline, SUM(od.quantityordered) AS total_terjual, AVG(ROUND(od.priceeach, 2)) AS rata_rata_harga, ROUND(AVG((p.MSRP - od.priceeach) / p.MSRP * 100), 2) AS avg_discount_percentage
FROM products AS p
INNER JOIN orderdetails AS od
ON p.productcode = od.productcode
GROUP BY p.productline
HAVING SUM(od.quantityordered) > 3000 AND AVG(od.priceeach) > 80
ORDER BY total_terjual DESC;

-- NO. 5
SELECT c.customername, SUM(od.quantityordered * od.priceeach) AS total_transaksi, COUNT(DISTINCT o.ordernumber) AS total_shipped_orders, ROUND(SUM(od.quantityordered * od.priceeach) / COUNT(DISTINCT o.ordernumber), 2) AS avg_transaction_per_order
FROM customers AS c
INNER JOIN orders AS o
ON c.customernumber = o.customernumber
INNER JOIN orderdetails AS od
ON o.ordernumber = od.ordernumber
WHERE o.status = 'Shipped'
GROUP BY c.customernumber, c.customername
HAVING COUNT(DISTINCT EXTRACT(YEAR FROM o.orderdate)) > 1
ORDER BY total_transaksi DESC
LIMIT 5;

-- NO. 6
SELECT c.customername, c.city AS customer_city, o.city AS office_city, SUM(od.quantityordered) AS total_unit_terjual, ROUND(SUM(od.quantityordered * od.priceeach) / COUNT(DISTINCT ord.ordernumber), 2) AS avg_nilai_per_order
FROM customers AS c
INNER JOIN employees AS e
ON c.salesrepemployeenumber = e.employeenumber
INNER JOIN offices AS o
ON e.officecode = o.officecode
INNER JOIN orders AS ord
ON c.customernumber = ord.customernumber
INNER JOIN orderdetails AS od
ON ord.ordernumber = od.ordernumber
WHERE o.territory = 'EMEA'
GROUP BY c.customernumber, c.customername, c.city, o.city
HAVING COUNT(DISTINCT EXTRACT(YEAR FROM ord.orderdate)) > 2 AND SUM(od.quantityordered) > 1000 AND SUM(od.quantityordered * od.priceeach) / COUNT(DISTINCT ord.ordernumber) > 10000
ORDER BY avg_nilai_per_order DESC;

-- SC 1
SELECT c.customernumber, c.contactfirstName, COALESCE(SUM(od.quantityordered), 0) AS totalKuantitas
FROM customers AS c
LEFT JOIN orders AS o
ON c.customernumber = o.customernumber
LEFT JOIN orderdetails AS od
ON o.ordernumber = od.ordernumber
GROUP BY c.customernumber, c.customername
ORDER BY totalKuantitas DESC;