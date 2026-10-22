-- soal 1
SELECT
    c.contactFirstName,
    c.customerName,
    o.city AS office_city,
	CONCAT(e.firstName, ' ', e.lastName) AS sales_rep_name
FROM Customers c
JOIN Employees e ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN Offices o USING (officeCode)
WHERE c.contactFirstName ILIKE 'a%' AND o.city != 'NYC'
ORDER BY c.customerName;

-- soal 2
SELECT
    c.customerName,
    SUM(p.amount) AS total_payment,
    MAX(p.amount) AS max_single_payment
FROM Customers c
JOIN Payments p USING (customerNumber)
GROUP BY c.customerNumber, c.customerName
HAVING SUM(p.amount) > 50000
ORDER BY total_payment DESC;

-- soal 3
SELECT
	c.customerName,
	COUNT(DISTINCT o.orderNumber) AS total_order,
    ROUND(AVG(od.quantityOrdered), 2) AS avg_quantity_per_order
FROM Customers c
JOIN Orders o USING (customerNumber)
JOIN OrderDetails od USING (orderNumber)
GROUP BY c.customerNumber, c.customerName
HAVING COUNT(DISTINCT o.orderNumber) > 3 
   AND AVG(od.quantityOrdered) > 35
ORDER BY total_order DESC, avg_quantity_per_order DESC;

-- soal 4
SELECT
    p.productLine,
    SUM(od.quantityOrdered) AS total_terjual,
    ROUND(AVG(od.priceEach), 2) AS rata_rata_harga,
    ROUND(AVG((p.MSRP - od.priceEach) / p.MSRP * 100), 2) AS avg_discount_percentage
FROM Products p
JOIN OrderDetails od USING (productCode)
GROUP BY p.productLine
HAVING SUM(od.quantityOrdered) > 3000 
   AND AVG(od.priceEach) > 80
ORDER BY total_terjual DESC;

-- soal 5
SELECT
    c.customerName,
    SUM(od.quantityOrdered * od.priceEach) AS total_transaksi,
    COUNT(DISTINCT CASE WHEN o.status = 'Shipped' THEN o.orderNumber END) AS total_shipped_orders,
    ROUND(SUM(od.quantityOrdered * od.priceEach) / COUNT(DISTINCT o.orderNumber), 2) AS avg_transaction_per_order
FROM Customers c
JOIN Orders o USING (customerNumber)
JOIN OrderDetails od USING (orderNumber)
GROUP BY c.customerNumber, c.customerName
HAVING COUNT(DISTINCT EXTRACT(YEAR FROM o.orderDate)) > 1
ORDER BY total_transaksi DESC
LIMIT 5;

-- soal 6
SELECT
    c.customerName,
    c.city AS customer_city,
    oof.city AS office_city,
    SUM(od.quantityOrdered) AS total_unit_terjual,
    ROUND(SUM(od.quantityOrdered * od.priceEach) / COUNT(DISTINCT o.orderNumber), 2) AS avg_nilai_per_order
FROM Customers c
JOIN Employees e ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN Offices oof USING (officeCode)
JOIN Orders o USING (customerNumber)
JOIN OrderDetails od USING (orderNumber)
WHERE oof.territory = 'EMEA'
GROUP BY c.customerNumber, c.customerName, c.city, oof.city
HAVING COUNT(DISTINCT EXTRACT(YEAR FROM o.orderDate)) > 2
   AND SUM(od.quantityOrdered) > 1000
   AND (SUM(od.quantityOrdered * od.priceEach) / COUNT(DISTINCT o.orderNumber)) > 10000
ORDER BY avg_nilai_per_order DESC;

-- studycase 1
SELECT
	c.customerName,
	o.orderNumber,
	p.productCode,
	od.quantityOrdered,
	od.priceEach
FROM Customers c
JOIN Products p USING (productCode)
JOIN OrderDetails od USING (orderNumber)
JOIN Orders o USING (customerNumber)
WHERE od.quantityOrdered > 30 AND o.status = 'Shipped'
ORDER BY c.customerName;

-- studycase 1
SELECT
	c.customerName,
	o.orderNumber,
	p.productCode,
	od.quantityOrdered,
	od.priceEach
FROM Customers c
JOIN Orders o USING (customerNumber)
JOIN OrderDetails od USING (orderNumber)
JOIN Products p USING (productCode)
WHERE p.productLine = 'Classic Cars' AND od.quantityOrdered > 30 AND o.status = 'Shipped'
ORDER BY o.orderNumber;


-- studycase 2
SELECT
	o.orderNumber,
	o.orderDate,
	p.productname,
	p.productLine,
	od.quantityOrdered,
	od.priceEach
FROM Orders o
JOIN OrderDetails od USING (orderNumber)
JOIN Products p USING (productCode)
WHERE od.quantityOrdered > 39
	AND p.productLine IN ('Motorcycles', 'Planes')
ORDER BY orderNumber;

	
	








