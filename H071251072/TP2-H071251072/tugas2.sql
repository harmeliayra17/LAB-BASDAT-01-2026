--TUPRAK NO 1-2 (PRAKTIKUM DB)
CREATE TABLE prodi (
	id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nama_prodi VARCHAR(100) NOT NULL
);

CREATE TABLE mahasiswa (
	nim VARCHAR(10) PRIMARY KEY,
	nama VARCHAR(100) NOT NULL,
	ipk NUMERIC(3, 2) DEFAULT 0.00,
	email VARCHAR(150) UNIQUE,
	id_prodi BIGINT,
	CONSTRAINT fk_mahasiswa_prodi
		FOREIGN KEY (id_prodi)
		REFERENCES prodi(id)
);

INSERT INTO mahasiswa (nim, nama, email, id_prodi)
VALUES 
    ('MHS010', 'Eren', 'eren@gmail.com', 1),
    ('MHS011', 'Aeru', NULL, 1),
    ('MHS012', 'Mokel', 'mokel@gmail.com', 1)
RETURNING *;

UPDATE mahasiswa
SET ipk = 3.75
WHERE ipk = 3.50
RETURNING *;

DELETE FROM mahasiswa
WHERE email IS NULL
RETURNING *;

--TUPRAK NO 3-5 (CLASSICMODELS)
SELECT 
    customerNumber AS "Nomor Pelanggan",
    customerName AS "Nama Pelanggan",
    phone AS "Telepon",
    country AS "Negara"
FROM customers;

SELECT 
    productCode,
    productName,
    buyPrice
FROM products
WHERE buyPrice > 50
ORDER BY buyPrice DESC
LIMIT 7;

SELECT DISTINCT 
    country AS "Negara Pelanggan"
FROM customers
ORDER BY country
LIMIT 5 OFFSET 5;

--SOAL TAMBAHAN
--no 1

SELECT DISTINCT city AS "kota_utama" FROM customers
WHERE country = 'USA' AND creditLimit > 100000
ORDER BY city ASC
LIMIT 4 OFFSET 2;

--no 2
SELECT productcode, productName, quantityInstock, buyPrice, quantityInstock * buyPrice AS total_nilai_stok FROM products
WHERE productLine = 'Motorcycles'
ORDER BY total_nilai_stok DESC
LIMIT 8;