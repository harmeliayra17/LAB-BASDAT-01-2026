CREATE DATABASE db_rs_wahidin;

CREATE TABLE poliklinik (
	id_poli BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nama_poli VARCHAR(50) NOT NULL UNIQUE,
	gedung VARCHAR(50) NOT NULL
);

CREATE TABLE pasien (
	id_pasien BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nik VARCHAR(16) NOT NULL UNIQUE,
	nama_pasien VARCHAR(150) NOT NULL,
	jenis_kelamin VARCHAR(1) CHECK(jenis_kelamin = 'L' OR jenis_kelamin = 'P')
);

CREATE TABLE dokter (
	id_dokter BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nama_dokter VARCHAR(150) NOT NULL,
	no_izin_praktek VARCHAR(30) UNIQUE,
	pengalaman_tahun INT CHECK(pengalaman_tahun >= 0) DEFAULT 0,
	id_poli BIGINT,
	CONSTRAINT fk_dokter_poliklinik
	FOREIGN KEY (id_poli)
	REFERENCES poliklinik(id_poli)
);

CREATE TABLE rekam_medis (
	id_rm BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	keluhan TEXT NOT NULL,
	biaya_pemeriksaan NUMERIC(15,2) DEFAULT 150000,
	id_pasien BIGINT,
	CONSTRAINT fk_rm_pasien
	FOREIGN KEY (id_pasien)
	REFERENCES pasien(id_pasien),
	id_dokter BIGINT,
	CONSTRAINT fk_rm_dokter
	FOREIGN KEY (id_dokter)
	REFERENCES dokter(id_dokter)
);

CREATE TABLE resep_obat (
	id_resep BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nama_obat VARCHAR(100) NOT NULL,
	jumlah INT CHECK(jumlah > 0),
	id_rm BIGINT,
	CONSTRAINT fk_resep_rm
	FOREIGN KEY (id_rm)
	REFERENCES rekam_medis(id_rm)
);

-- soal2
ALTER TABLE pasien
ADD COLUMN gol_darah VARCHAR(2);

ALTER TABLE resep_obat
ALTER COLUMN nama_obat TYPE TEXT;

ALTER TABLE poliklinik
DROP COLUMN gedung;


-- soal3
DROP TABLE rekam_medis;
DROP TABLE resep_obat;