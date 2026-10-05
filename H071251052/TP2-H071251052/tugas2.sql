-- NO. 1
INSERT INTO mahasiswa (nim, nama, email, id_prodi)
VALUES ('M001', 'alfa', 'alfa@gmail', 1), ('M002',
	'Budi', 'Budi01@gaming', 1),
	('M003', 'Cece', NULL, 1)
RETURNING *;

-- NO 2
UPDATE mahasiswa
SET ipk = 3.75
WHERE ipk = 3.50

DELETE FROM mahasiswa
WHERE email = NULL
RETURNING *;

-- NO 3
SELECT customerNumber AS "Nomor Pelanggan", customerName AS "Nama Pelanggan", phone AS "Telepon", country AS "Negara" FROM customers;

-- NO 4
SELECT productCode, productName, buyPrice From products
WHERE buyPrice > 50
ORDER BY buyPrice DESC
LIMIT 7;

-- NO 5
SELECT DISTINCT country AS "Negara Pelanggan" FROM customers
ORDER BY country ASC
OFFSET 5
LIMIT 5;

-- SC 1
SELECT orderNumber, orderDate, shippedDate, status, comments FROM orders
WHERE status = 'Shipped' AND comments != 'NULL'
ORDER BY orderDate DESC
LIMIT 4;

-- SC 2
SELECT customerNumber, checkNumber, paymentDate, amount FROM payments 
WHERE paymentDate BETWEEN '2004-01-01' AND '2004-03-31' AND amount > 20000.00
ORDER BY amount DESC
OFFSET 5;