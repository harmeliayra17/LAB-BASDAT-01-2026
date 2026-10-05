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

-- SOAL 1
INSERT INTO prodi(nama_prodi)
VALUES ('Sistem Informasi')

INSERT INTO mahasiswa 
	(nim, nama, email, id_prodi)
VALUES 
	('H071251009', 'Muhammad Naufal Alim', 'alimnaufal@gmail.com', 1),
	('H071251062', 'Ahmad Fauzi Ali', 'ahmadfauzi7218@gmail.com', 1),
	('H071251065', 'Zahwa Dwi Putri', NULL, 1)
RETURNING *

-- SOAL 2
UPDATE mahasiswa
SET ipk=3.75
WHERE ipk=3.50
RETURNING *

DELETE FROM mahasiswa
WHERE email IS NULL
RETURNING *

-- SOAL 3
SELECT 
	customernumber AS "Nomor Pelanggan", 
	customername AS "Nama Pelanggan", 
	phone AS "Telepon", 
	country AS "Negara" 
FROM customers;

-- SOAL 4
SELECT productcode, productname, buyprice FROM products
WHERE buyprice > 50
ORDER BY buyprice DESC
LIMIT 7

-- SOAL 5
SELECT DISTINCT 
	country AS "Negara Pelanggan"
FROM customers
ORDER BY country ASC
LIMIT 5 
OFFSET 5

-- SOAL TAMBAHAN 1
UPDATE products
SET msrp = msrp * 1.08
WHERE productline = 'Motorcycles' AND quantityinstock < 2000
RETURNING
	productcode,
	productname,
	msrp AS "msrp_baru"

-- SOAL TAMBAHAN 2
SELECT ordernumber, orderdate, requireddate, status, customernumber FROM orders
WHERE status = 'Cancelled' OR status = 'Disputed' OR status = 'On Hold'
ORDER BY orderdate DESC
LIMIT 5