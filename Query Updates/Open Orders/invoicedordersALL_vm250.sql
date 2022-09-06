SELECT
	DERF.DERF_DealerNo AS dealer
	, OH.DistributorNum AS dist --Not sure about this one
	, OH.JobName AS jobnam
	, OH.OrderNum AS ordernumber
	, OH.OrderReceivedDate AS recdate
	, OH.ShipDate AS shipdate
	, OH.OrderStatus AS status
	, OH.DesignGroup AS designgroup
	, DERF.DERF_Name AS dealername
	, OT.TotalDollarsAtPricing AS invoiceamount
	, OI.InvoiceDate AS invoicedate
	, OI.ReleasedDate AS rundate --Check this
	, OI.InvoiceNum AS invoicenumber
	, '??' AS discount
	, '??' AS totalinvoicecharges
	, OH.DepositAmount AS depositamount
	, OT.TotalOrderDollars AS totalorderamount
	
FROM WIPS_DealerRef_DERF AS DERF
JOIN OrderHeader AS OH
	ON DERF.DERF_DealerNo = OH.Account
JOIN OrderItems AS OI
	ON OH.OrderNum = OI.OrderNum
JOIN OrderTotals AS OT
	ON OH.OrderNum = OT.OrderNum
	
WHERE	
	(LEFT(DERF.DERF_DealerNo,2) = DERF.DERF_Territory)

ORDER BY 
	dealer
	