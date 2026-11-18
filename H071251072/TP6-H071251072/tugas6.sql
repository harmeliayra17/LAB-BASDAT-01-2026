--no 1 (110 baris)
SELECT productCode, productName, MSRP, quantityInStock, 
	CASE 
	WHEN MSRP < 50 AND quantityInStock > 500 THEN 'Ekonomis - Stok Tinggi'
	WHEN MSRP < 50 AND quantityInStock <= 500 THEN 'Ekonomis - Stok Rendah'
	WHEN MSRP BETWEEN 50 AND 100 THEN 'Harga Menengah'
	WHEN MSRP > 100 THEN 'Harga Premium'
	END AS kategori
FROM products
ORDER BY MSRP DESC;

--no 2 (109 baris)
SELECT productCode, total_terjual, jumlah_pesanan
FROM (
    SELECT productCode,
           SUM(quantityOrdered)       AS total_terjual,
           COUNT(DISTINCT orderNumber) AS jumlah_pesanan
    FROM orderdetails
    GROUP BY productCode
) AS penjualan_produk
WHERE total_terjual > (SELECT AVG(quantityOrdered) FROM orderdetails)
  AND jumlah_pesanan > 10
ORDER BY total_terjual DESC;

--no 3
SELECT productCode, productName, quantityInStock, MSRP
FROM products 
WHERE quantityInStock > (SELECT AVG(quantityInStock) from products)
AND MSRP > (SELECT AVG(MSRP) from products)
ORDER BY quantityInStock DESC;

--no 4
BEGIN;

UPDATE orders
SET status 'Pengiriman'
WHERE orderNumbers = 10100;

SAVEPOINT status_pengiriman;

UPDATE orders
SET status 'Batal'
WHERE orderNumbers = 10100;

ROLLBACK TO SAVEPOINT status_pengiriman;

COMMIT;

--no 5
CREATE TABLE anggota (
	id_anggota INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nama_anggota VARCHAR(50) NOT NULL,
	kota_domisili VARCHAR(20) NOT NULL
);

CREATE TABLE buku (
	id_buku INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	judul_buku VARCHAR(100) NOT NULL,
	genre VARCHAR(20) NOT NULL,
	stok INTEGER DEFAULT 1
);

CREATE TABLE peminjaman (
	id_peminjaman INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	id_anggota INTEGER,
		CONSTRAINT fk_id_anggota
		FOREIGN KEY (id_anggota)
		REFERENCES anggota(id_anggota),
	id_buku INTEGER,
		CONSTRAINT fk_id_buku
		FOREIGN KEY (id_buku)
		REFERENCES buku(id_buku),
	tanggal_pinjam DATE NOT NULL,
	tanggal_kembali DATE,
	denda INTEGER DEFAULT 0
);

CREATE INDEX index_buku_genre
ON buku(genre);

CREATE INDEX index_anggota_domisili
ON anggota(kota_domisili);