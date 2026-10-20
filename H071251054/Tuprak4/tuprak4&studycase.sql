-- soal 1
SELECT 
    customerNumber AS id_pelanggan,
    SUM(amount) AS total_akumulasi_dana,
    COUNT(checkNumber) AS frekuensi_transaksi,
    MAX(amount) AS setoran_tunai_terbesar
FROM payments
GROUP BY customerNumber
HAVING COUNT(checkNumber) > 4 AND AVG(amount) > 20000;

-- soal 2
SELECT
	customerNumber AS id_pelanggan,
    SUM(amount) AS total_keseluruhan_setoran
FROM payments
GROUP BY customerNumber
HAVING SUM(amount) > 80000
ORDER BY total_keseluruhan_setoran DESC;

-- soal 3
SELECT
    productLine AS kategori_produk,
    COUNT(productCode) AS jumlah_produk,
    ROUND(AVG(MSRP), 2) AS rata_rata_harga_jual,
    STRING_AGG(productName, ', ') AS daftar_nama_produk
FROM products
GROUP BY productLine
HAVING COUNT(productCode) > 10;

-- soal 4
SELECT
    reportsTo AS nomor_identifikasi_karyawan
FROM employees
WHERE reportsTo IS NOT NULL
EXCEPT
SELECT
    employeeNumber AS id_karyawan
FROM employees
WHERE jobTitle LIKE '%VP%' OR jobTitle LIKE '%President%';

-- soal 5
SELECT
    productCode AS kode_produk,
    SUM(quantityOrdered) AS total_unit_fisik_terjual,
    ROUND(AVG(priceEach), 2) AS rata_rata_harga_riil
FROM orderdetails
WHERE priceEach > 100
GROUP BY productCode
HAVING SUM(quantityOrdered) > 50
ORDER BY total_unit_fisik_terjual DESC;

-- soal 6
SELECT
    productCode AS kode_produk,
    SUM(quantityOrdered) AS total_keseluruhan_unit,
    SUM(quantityOrdered * priceEach) AS estimasi_pendapatan_kotor,
    ROUND(AVG(priceEach), 2) AS rata_rata_harga_satuan,
    (MAX(priceEach) - MIN(priceEach)) AS rentang_selisih_harga
FROM orderdetails
WHERE quantityOrdered > 20
GROUP BY productCode
HAVING SUM(quantityOrdered * priceEach) > 50000
ORDER BY estimasi_pendapatan_kotor DESC;

-- soal 7
SELECT
    customerNumber
FROM customers
WHERE creditLimit > 80000
INTERSECT
SELECT
    customerNumber
FROM orders
WHERE status IN ('Cancelled', 'On Hold')
EXCEPT
SELECT
    customerNumber
FROM payments
GROUP BY customerNumber
HAVING SUM(amount) > 100000;

-- studycase
SELECT
	customerNumber,
	SUM(amount) AS total_pembayaran,
	ROUND(AVG(amount), 2) AS rata_rata_pembayaran,
	COUNT(checkNumber) AS total_pembayaran
FROM payments
GROUP BY customerNumber
HAVING AVG (amount) > 3000
ORDER BY MAX(amount) DESC;












