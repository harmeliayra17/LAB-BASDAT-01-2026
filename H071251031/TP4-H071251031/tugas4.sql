--- soal 1

SELECT customernumber, SUM(amount) AS total_pembayaran, COUNT(DISTINCT checknumber) AS jumlah_transaksi, MAX(amount) AS pembayaran_terbesar
FROM payments
GROUP BY customernumber
HAVING COUNT(DISTINCT checknumber) > 4 AND AVG(amount) > 20000;


--- soal 2

SELECT customernumber, SUM(amount) AS total_pembayaran
FROM payments
GROUP BY customernumber
HAVING SUM(amount) > 80000
ORDER BY total_pembayaran DESC;


--- soal 3

SELECT productline AS kategori, COUNT(productcode) AS jumlah_produk, ROUND(AVG(msrp), 2) AS rata_rata_harga_jual_, 
STRING_AGG(productname, ', ' ORDER BY productname) AS daftar_produk
FROM products
GROUP BY productline
HAVING COUNT(productcode) > 10;