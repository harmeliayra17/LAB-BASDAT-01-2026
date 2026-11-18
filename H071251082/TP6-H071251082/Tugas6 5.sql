CREATE TABLE anggota (
	id_anggota INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nama_anggota VARCHAR(50) NOT NULL,
	kota_domisili VARCHAR(20) NOT NULL
);

CREATE TABLE buku (
	id_buku INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	judul_buku VARCHAR(100) NOT NULL,
	genre VARCHAR(20) NOT NULL,
	stok INT DEFAULT 1
);

CREATE TABLE peminjaman (
	id_peminjaman INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	id_anggota INT,
	CONSTRAINT fk_anggota_peminjaman
		FOREIGN KEY (id_anggota)
		REFERENCES anggota(id_anggota),
	id_buku INT,
	CONSTRAINT fk_buku_dipinjam
		FOREIGN KEY (id_buku)
		REFERENCES buku(id_buku),
	tanggal_pinjam DATE,
	tanggal_kembali DATE NOT NULL,
	denda INT DEFAULT 0
);

CREATE INDEX cari_genre
ON buku(genre);

CREATE INDEX cari_domisili
ON anggota(kota_domisili);














