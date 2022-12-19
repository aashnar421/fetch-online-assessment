-- Which brand has the most spend among users who were created within the past 6 months?
-- Which brand has the most transactions among users who were created within the past 6 months?

-- Analysis:
-- Tells us which brand is most popular among customers
-- Should maintain relationship with this brand moving forward
-- These metrics can drive down CAC by marketing popular brands to potential users
-- Should compare these brands to popular brands among veteran users.


SELECT 
	i.brands_brand_id,
 	b.name,
	SUM(ri.quantitypurchased) AS num_transactions,
	SUM(ri.quantitypurchased * ri.itemprice) AS total_spend
FROM mydb.users u
JOIN mydb.receiptitems ri
ON u.user_id = ri.user_id
JOIN mydb.items i
ON ri.items_barcode = i.barcode
JOIN mydb.brands b
ON i.brands_brand_id = b.brand_id
WHERE MONTH(createddate) BETWEEN MONTH(DATE_SUB(CURDATE(),INTERVAL 6 MONTH)) AND MONTH(CURDATE())
	AND YEAR(createddate) BETWEEN YEAR(DATE_SUB(CURDATE(),INTERVAL 6 MONTH)) AND YEAR(CURDATE())
GROUP BY brands_brand_id, name
ORDER BY total_spend DESC
-- ORDER BY num_transactions DESC -- run this to see top brands by number of transactions 
LIMIT 1
;
