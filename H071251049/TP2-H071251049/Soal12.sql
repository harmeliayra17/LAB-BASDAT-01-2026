SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public';

-- SOAL 1: Tambah 3 Data Baru
INSERT INTO mahasiswa (nim, nama, email, id_prodi)
VALUES 
    ('H071251049', 'Afdhol As Syamardi', 'afdhol@gmail.com', 1),
    ('H071251050', 'Budi Santoso', 'budi@gmail.com', 1),
    ('H071251051', 'Siti Aminah', NULL, 2)
RETURNING *;

-- SOAL 2A: Update IPK
UPDATE mahasiswa
SET ipk = 3.75
WHERE ipk = 3.50
RETURNING *;

-- SOAL 2B: Hapus Data dengan Email NULL
DELETE FROM mahasiswa
WHERE email IS NULL
RETURNING *;

