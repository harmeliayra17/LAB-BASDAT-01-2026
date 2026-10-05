CREATE TABLE prodi (
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
	nama_prodi VARCHAR(100) NOT NULL
);

CREATE TABLE mahasiswa (
	nim VARCHAR(10) PRIMARY KEY,
	nama VARCHAR(100) NOT NULL,
	ipk NUMERIC(3,2) DEFAULT 0.00,
	email VARCHAR(150) UNIQUE,
	id_prodi INT,
	CONSTRAINT fk_mahasiswa_prodi
		FOREIGN KEY (id_prodi)
		REFERENCES prodi(id)
);

INSERT INTO prodi (nama_prodi)
VALUES
	('Sistem Informasi'), ('Kedokteran');

--soal 1
INSERT INTO mahasiswa (nim, nama, email, id_prodi)
VALUES 
	('H071251040', 'Alpha', 'alpa@gmail.com', 1), 
	('H071251041', 'Beta', 'beta@gmail.com', 2), 
	('H071251042', 'Charlie', NULL, 1), 

--soal 2
UPDATE mahasiswa
SET ipk = 3.75
WHERE ipk = 3.50;

DELETE FROM mahasiswa
WHERE email IS NULL;

SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public'

SELECT column_name, data_type, character_maximum_length, is_nullable FROM information_schema.columns WHERE table_name = 'prodi';
SELECT column_name, data_type, character_maximum_length, is_nullable FROM information_schema.columns WHERE table_name = 'mahasiswa';


--soal 3
SELECT 
	customerNumber AS "Nomor Pelanggan",
	customerName AS "Nama Pelanggan",
	phone AS "Telepon",
	country AS "Negara"
FROM customers;

--soal 4
SELECT productCode, productName, buyPrice 
FROM products 
WHERE buyprice > 50 
ORDER BY buyprice DESC 
LIMIT 7;

--soal 5
SELECT DISTINCT country AS "Negara Pelanggan" FROM customers ORDER BY country LIMIT 5 OFFSET 5;

--STUDY CASE
--1
SELECT * FROM orders;
SELECT orderNumber, orderdate, requireddate, status, customernumber 
FROM orders
WHERE status = 'Cancelled' or status = 'Disputed' or status = 'On Hold'
ORDER BY orderdate DESC
LIMIT 5;

--2
SELECT * FROM products;
SELECT productcode, productname, quantityinstock, buyprice, (quantityInStock * buyPrice) AS "Total Nilai Stok"  FROM products
WHERE productline = 'Motorcycles'
ORDER BY  "Total Nilai Stok"
LIMIT 8;


