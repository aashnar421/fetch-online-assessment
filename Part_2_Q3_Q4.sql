-- When considering average spend from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?
-- When considering total number of items purchased from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?

-- Analysis:
-- These metrics are good to determine average spend habits of accepted receipts vs rejected
-- Helps understand why receipts were rejected - we should check for correlation between receipts rejected and average spend/number of items as next step

WITH spend_per_receipt AS 
(
SELECT 
	rewardsreceiptstatus,
	receipt_id,
    SUM(purchasedItemCount) AS receipt_item_count,
	SUM(itemPrice) AS receipt_total_spend
FROM mydb.receipts r
JOIN mydb.receiptitems ri
ON r.receipt_id = ri.receipts_receipt_id
GROUP BY rewardsreceiptstatus, receipt_id
)
SELECT rewardsreceiptstatus,
	AVG(receipt_total_spend) AS avg_spend,
    SUM(receipt_item_count) AS total_items_purchased
FROM spend_per_receipt
GROUP BY rewardsreceiptstatus
;
