-- soal 1
INSERT INTO mahasiswa
VALUES 
	('H071251048', 'Heindro Pakhsi Hidayat', null, null, 1),
	('H071251018', 'Muhammad Farhan Nurrahmat Latif', null, 'farhan.nurrahmat@gmail.com', 1),
	('H071251052', 'Ilmi Ahmad Alfaridzi', null, 'i.aalfaridzi@gmail.com', 1);
SELECT * FROM mahasiswa;

-- soal 2
UPDATE mahasiswa
SET ipk = 3.50
WHERE id_prodi = 1;

UPDATE mahasiswa
SET ipk = 3.75
WHERE ipk = 3.50;

DELETE FROM mahasiswa
WHERE email IS NULL;
SELECT * FROM mahasiswa;

-- soal 3
SELECT 
	customernumber AS "Nomor Pelanggan", 
	customername AS "Nama Pelanggan", 
	phone AS "Telepon", 
	country AS "Negara" 
FROM customers;

-- soal 4
SELECT productcode, productname, buyprice FROM products
WHERE buyprice > 50
ORDER BY buyprice DESC
LIMIT 7;

-- soal 5
SELECT DISTINCT country  AS "Negara Pelanggan" FROM customers
ORDER BY country ASC
LIMIT 5 OFFSET 5;

--studycase 1
SELECT ordernumber, orderdate, shippeddate, status, comments FROM orders
WHERE status = 'Shipped' AND comments IS NOT NULL
ORDER BY orderdate DESC
LIMIT 4;

--studycase 2
SELECT customernumber, checknumber, paymentdate, amount FROM payments
WHERE paymentdate BETWEEN '2004-01-10' AND '2004-03-31' AND amount > 20000.00
ORDER BY amount DESC
OFFSET 5;