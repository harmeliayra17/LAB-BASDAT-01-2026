-- soal5
CREATE TABLE anggota(
id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
nama_anggota VARCHAR(50) NOT NULL,
kota_domisili VARCHAR(20) NOT NULL);

CREATE TABLE buku(
id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
judul_buku VARCHAR(100) NOT NULL,
genre VARCHAR(20) NOT NULL,
stok INT DEFAULT 1);

CREATE TABLE peminjaman(
id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
id_anggota INT,
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

CREATE INDEX index_genre_buku
ON buku(genre);

DROP INDEX index_genre_buku;

CREATE INDEX index_kotadomisili_anggota
ON anggota(kota_domisili);