set search_path TO classicmodels;

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

--soal 1
INSERT INTO prodi (nama_prodi)
VALUES ('Sistem Informasi');
SELECT * FROM prodi;

INSERT INTO mahasiswa (nim, nama, email, id_prodi)
VALUES
	('H071251085', 'Andi Alifah Mahrani', NULL, 1),
	('H071251065', 'Zahwa Dwi Putri', 'zahwa@gmail.com', 1),
	('H071251064', 'Aqilah Raihana', 'aqilah@gmail.com', 1);
SELECT * FROM mahasiswa;

--soal 2
UPDATE mahasiswa
SET ipk=3.75
WHERE ipk=3.50;
SELECT * FROM mahasiswa;

DELETE FROM mahasiswa
WHERE email IS NULL
SELECT * FROM mahasiswa;

--soal 3
SELECT 
	customerNumber AS "Nomor Pelanggan", 
	customerName AS "Nama Pelanggan", 
	phone AS "Telepon", 
	country AS "Negara" 
FROM customers;

--soal 4
SELECT productCode, productName, buyPrice FROM products
WHERE buyprice > 50
ORDER BY buyPrice DESC
LIMIT 7;

--soal 5
SELECT DISTINCT 
	country AS "Negara Pelanggan"
FROM customers
ORDER BY country ASC
LIMIT 5 
OFFSET 5;

--tambahan soal 1
SELECT productCode, productName, quantityInStock, buyPrice, 
	quantityInStock*buyPrice AS "Total Nilai Stok" FROM products
WHERE productLine = 'Motorcycles'
ORDER BY quantityInStock*buyPrice DESC
LIMIT 8;

--tambahan soal 2
SELECT customerNumber, checkNumber, paymentDate, amount FROM payments
WHERE paymentDate BETWEEN '2004-01-01' AND '2004-03-31' AND amount > 20000.00
ORDER BY amount DESC
OFFSET 5 LIMIT 5;

