SET search_path TO classicmodels;

--Nomor 1
SELECT productCode AS "Kode Produk",
	productName AS "Nama Produk",
	msrp AS "MSRP",
	quantityInStock AS "Jumlah Stok",
	CASE
		WHEN msrp < 50 AND quantityInStock > 500 THEN 'Ekonomis - Stok Tinggi'
		WHEN msrp < 50 AND quantityInStock <= 500 THEN 'Ekonomis - Stok Rendah'
		WHEN (msrp BETWEEN 50 AND 100) AND quantityInStock > 500 THEN 'Harga Menengah - Stok Tinggi'
		WHEN (msrp BETWEEN 50 AND 100) AND quantityInStock <= 500 THEN 'Harga Menengah - Stok Rendah'
		WHEN msrp > 100 AND quantityInStock > 500 THEN 'Harga Premium - Stok Tinggi'
		ELSE 'Harga Premium - Stok Rendah'
	END AS  "Kategori"
FROM products
ORDER BY msrp DESC;

--Nomor 2
SELECT productcode,
	SUM(quantityOrdered) AS "total unit terjual",
	COUNT(DISTINCT orderNumber) AS "jumlah unit"
FROM orderDetails
GROUP BY productCode
HAVING SUM(quantityOrdered) > (
	SELECT AVG(quantityOrdered) FROM orderDetails) AND COUNT(DISTINCT orderNumber) > 10
ORDER BY SUM(quantityOrdered) DESC;

--Nomor 3
SELECT productCode,
	productName,
	quantityInStock,
	msrp
FROM products
WHERE quantityInStock > (SELECT AVG(quantityInStock) FROM products) 
	AND msrp > (SELECT AVG(msrp) FROM products)
ORDER BY quantityInStock DESC;

--Nomor 4
BEGIN;

UPDATE orders
SET status = 'Shipped'
WHERE orderNumber = '10100'

SAVEPOINT status_pengiriman;

UPDATE orders
SET status = 'Cancelled'
WHERE orderNumber = '10100'

ROLLBACK TO SAVEPOINT status_pengiriman;

SELECT status FROM orders
WHERE orderNumber = '10100';

COMMIT;

--Nomor 5
CREATE TABLE anggota (
	id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nama_anggota VARCHAR(50) NOT NULL,
	kota_domisili VARCHAR(20) NOT NULL
) 

CREATE TABLE buku (
	id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	judul_buku VARCHAR(100) NOT NULL,
	genre VARCHAR(20) NOT NULL,
	Stok INTEGER DEFAULT 1
)

CREATE TABLE peminjaman(
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	idAnggota INT,
	CONSTRAINT fk_peminjaman_anggota
		FOREIGN KEY (idAnggota)
		REFERENCES anggota(id),
	idBuku INT,
	CONSTRAINT fk_peminjaman_buku
		FOREIGN KEY (idBuku)
		REFERENCES buku(id),
	tanggal_pinjam DATE NOT NULL,
	tanggal_kembali DATE NOT NULL,
	denda INT DEFAULT 0
)

CREATE INDEX buku_genre
ON buku(genre);

CREATE INDEX anggota_kota_domisili
ON anggota(kota_domisili);


