--5
CREATE TABLE anggota(
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nama_anggota VARCHAR(50) NOT NULL,
	kota_domisili VARCHAR(20) NOT NULL
);

CREATE TABLE buku(
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	judul_buku VARCHAR(100) NOT NULL,
	genre VARCHAR(20) NOT NULL,
	stok INT DEFAULT 1
);

CREATE TABLE peminjaman(
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	id_anggota INT 
	CONSTRAINT fk_peminjaman_anggota
		FOREIGN KEY (id_anggota)
		REFERENCES anggota(id),
	id_buku INT,
	CONSTRAINT fk_peminjaman_buku
		FOREIGN KEY (id_buku)
		REFERENCES buku(id),
	tanggal_pinjam DATE NOT NULL,
	tanggal_kembali DATE NULL,
	denda INT DEFAULT 0
);

CREATE INDEX index_buku_genre
ON buku (genre);

DROP INDEX index_buku_genre;
------------------------------------
CREATE INDEX index_anggota_kotaDomisili
ON anggota (kota_domisili);

DROP INDEX index_anggota_kotaDomisili;

-------------------------------------
SELECT table_name FROM information_schema.tables WHERE table_schema = 'public'

SELECT column_name, data_type, character_maximum_length, is_nullable
FROM information_schema.columns
WHERE table_name = 'buku';

SELECT column_name, data_type, character_maximum_length, is_nullable
FROM information_schema.columns
WHERE table_name = 'anggota';

SELECT column_name, data_type, character_maximum_length, is_nullable
FROM information_schema.columns
WHERE table_name = 'peminjaman';

