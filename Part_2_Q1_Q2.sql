-- What are the top 5 brands by receipts scanned for most recent month?
-- How does the ranking of the top 5 brands by receipts scanned for the recent month compare to the ranking for the previous month?

-- Analysis:
-- This metric shows popular brands among customers
-- However, it would be better to get top brands by number of units bought, total spend, and points rewarded
-- Next step: account for seasonal/monthly trends in brands by comparing YoY data


WITH all_receipts_last_2_months AS 
(
SELECT 
	EXTRACT(MONTH FROM dateScanned) AS month,
    EXTRACT(YEAR FROM dateScanned) AS year,
    i.brands_brand_id AS brand,
    COUNT(DISTINCT(r.receipts_receipt_id)) AS num_receipts
FROM mydb.receiptitems r
JOIN mydb.items i
ON i.barcode = r.items_barcode
WHERE MONTH(dateScanned) IN (MONTH( DATE_SUB(CURDATE(),INTERVAL 1 MONTH )), MONTH( DATE_SUB(CURDATE(),INTERVAL 2 MONTH )))
	AND YEAR(dateScanned) = YEAR(DATE_SUB(CURDATE( ),INTERVAL 2 MONTH ))
GROUP BY month, year, brand
)
,
all_ranks AS 
(
SELECT 
	month, 
    year,
    brand,
	ROW_NUMBER() OVER (PARTITION BY month, year ORDER BY num_receipts DESC) AS month_brand_rank
FROM all_receipts_last_2_months
)
SELECT * 
FROM all_ranks
WHERE month_brand_rank <= 5
ORDER BY month ASC, year ASC, month_brand_rank DESC
LIMIT 10
;



