-- nomor 1
SELECT
	productCode,
	productname,
	MSRP,
	quantityInStock,
	CASE
		WHEN MSRP < 50 AND quantityInStock > 500
			THEN 'Ekonomis - Stook Tinggi'
		WHEN MSRP < 50 AND quantityInStock <= 500
			THEN 'Ekonomis - Stok Rendah'
		WHEN MSRP > 100
			THEN 'Harga Premium'
		WHEN MSRP BETWEEN 50 AND 100
			THEN 'Harga Menengah'
	END AS kategori
FROM Products
ORDER BY MSRP DESC;

-- nomor 2
SELECT 
	productCode,
	SUM(quantityOrdered) AS total_unit_terjual,
	COUNT(DISTINCT orderNumber) AS jumlah_pesanan
FROM OrderDetails
GROUP BY productCode
HAVING
	SUM(quantityOrdered) > (
		SELECT AVG(quantityOrdered)
		FROM OrderDetails
	)
	AND COUNT(DISTINCT orderNumber) > 10
ORDER BY total_unit_terjual DESC;

-- nomor 3
SELECT 
	productCode,
	productname,
	quantityInStock,
	MSRP
FROM Products
WHERE quantityInStock > (
	SELECT AVG(quantityInStock)
	FROM Products
)
AND MSRP > (
	SELECT AVG(MSRP)
	FROM Products
)
ORDER BY quantityInStock DESC;

-- nomor 4
BEGIN;

UPDATE Orders
SET status = 'Pengiriman'
WHERE orderNumber = 10100;

SAVEPOINT status_pengiriman;

UPDATE Orders
SET status = 'batal'
WHERE orderNumber = 10100;

ROLLBACK TO SAVEPOINT status_pengiriman;

COMMIT;

-- studycase by kak ananta no.5
BEGIN;

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

UPDATE Customers
SET creditLimit = creditLimit + 10000
WHERE orderNumber = 103;

SAVEPOINT sp_update_kredit;

UPDATE Customers
SET city = 'Surabaya'
WHERE Customers = 103;

ROLLBACK TO SAVEPOINT sp_update_kredit;

ROLLBACK;


















	