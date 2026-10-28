-- Soal Nomor 1 
-- A. Tabel poliklinik (Tabel Induk)
CREATE TABLE poliklinik (
    id_poli INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nama_poli VARCHAR(50) NOT NULL UNIQUE,
    gedung VARCHAR(50) NOT NULL
);

-- B. Tabel pasien (Tabel Induk)
CREATE TABLE pasien (
    id_pasien INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nik VARCHAR(16) NOT NULL UNIQUE,
    nama_pasien VARCHAR(150) NOT NULL,
    jenis_kelamin VARCHAR(1) CHECK (jenis_kelamin IN ('L', 'P'))
);

-- C. Tabel dokter (Tabel Anak dari poliklinik)
CREATE TABLE dokter (
    id_dokter INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nama_dokter VARCHAR(150) NOT NULL,
    no_izin_praktek VARCHAR(30) UNIQUE,
    pengalaman_tahun INT DEFAULT 0 CHECK (pengalaman_tahun >= 0),
    id_poli INT,
    CONSTRAINT fk_dokter_poli FOREIGN KEY (id_poli) REFERENCES poliklinik (id_poli)
);

-- D. Tabel rekam_medis (Tabel Anak dari pasien dan dokter)
CREATE TABLE rekam_medis (
    id_rm INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    keluhan TEXT NOT NULL,
    biaya_pemeriksaan NUMERIC DEFAULT 150000,
    id_pasien INT,
    id_dokter INT,
    CONSTRAINT fk_rm_pasien FOREIGN KEY (id_pasien) REFERENCES pasien (id_pasien),
    CONSTRAINT fk_rm_dokter FOREIGN KEY (id_dokter) REFERENCES dokter (id_dokter)
);

-- E. Tabel resep_obat (Tabel Anak dari rekam_medis)
CREATE TABLE resep_obat (
    id_resep INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nama_obat VARCHAR(100) NOT NULL,
    jumlah INT CHECK (jumlah > 0),
    id_rm INT,
    CONSTRAINT fk_resep_rm FOREIGN KEY (id_rm) REFERENCES rekam_medis (id_rm)
);


-- Soal Nomor 2
-- 1. Menambahkan kolom gol_darah pada tabel pasien
ALTER TABLE pasien ADD COLUMN gol_darah VARCHAR(2);

-- 2. Mengubah tipe data nama_obat menjadi teks tanpa batas (TEXT)
ALTER TABLE resep_obat ALTER COLUMN nama_obat TYPE TEXT;

-- 3. Menghapus kolom gedung pada tabel poliklinik
ALTER TABLE poliklinik DROP COLUMN gedung;

-- Soal Nomor 3
-- 1. Hapus tabel anak (resep_obat) terlebih dahulu
DROP TABLE resep_obat;

-- 2. hapus tabel induk (rekam_medis)
DROP TABLE rekam_medis;


SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public' ;