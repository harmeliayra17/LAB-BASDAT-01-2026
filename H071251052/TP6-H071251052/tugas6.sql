-- NO. 1
SELECT productcode, productname, MSRP, quantityinstock,
	CASE
		WHEN MSRP < 50 AND quantityinstock > 500
			THEN 'Ekonomis - Stock Tinggi'
		WHEN MSRP < 50 AND quantityinstock <= 500
			THEN 'Ekonomis - Stok Rendah'
		WHEN MSRP > 50 AND MSRP < 100
			THEN 'Harga Menengah'
		WHEN MSRP > 100
			THEN 'Harga Premium'
	END AS kategori
FROM products
ORDER BY MSRP DESC;

-- NO. 2
SELECT productCode, SUM(quantityOrdered) AS total_unit_terjual, COUNT(DISTINCT orderNumber) AS jumlah_pesanan
FROM orderdetails 
GROUP BY productCode
HAVING SUM(quantityOrdered) > (
		SELECT AVG(quantityOrdered)
        FROM orderdetails
    )
    AND COUNT(DISTINCT orderNumber) > 10
ORDER BY total_unit_terjual DESC;

-- NO. 3
SELECT productCode, productName, quantityInStock, MSRP
FROM products
WHERE quantityInStock > (
		SELECT AVG(quantityInStock)
        FROM products
    )
    AND MSRP > (
        SELECT AVG(MSRP)
        FROM products
    )
ORDER BY quantityInStock DESC;

-- NO. 4
BEGIN;

UPDATE orders
SET status = 'Pengiriman'
WHERE ordernumber = 10100;

SAVEPOINT status_pengiriman;

UPDATE orders
SET status = 'Batal'
WHERE ordernumber = 10100;

ROLLBACK TO SAVEPOINT status_pengiriman;

COMMIT;

-- NO. 5
CREATE TABLE anggota(
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nama_anggota VARCHAR(50) NOT NULL,
	kota_domisili VARCHAR(30) NOT NULL
);

CREATE TABLE buku(
	id INT  GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	judul_buku VARCHAR(100) NOT NULL,
	genre VARCHAR(20) NOT NULL,
	stok INT DEFAULT 1
);

CREATE TABLE peminjaman(
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	tanggal_pinjam DATE NOT NULL,
	tanggal_kembali DATE,
	denda INT DEFAULT 0,
	id_anggota INT,
	id_buku INT,
	CONSTRAINT fk_id_anggota
		FOREIGN KEY (id_anggota)
		REFERENCES anggota(id),
	CONSTRAINT fk_id_buku
		FOREIGN KEY (id_buku)
		REFERENCES buku(id)
);

CREATE INDEX index_genre_buku
ON buku(genre);

CREATE INDEX index_domisili_anggota
ON anggota(kota_domisili);