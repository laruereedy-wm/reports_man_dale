SELECT DISTINCT 
	dealer
	, territory --Check of parameter, not in original
	, dist
	, jobnam
	, ordernumber
	, recdate
	, shipdate
	, status
	, designgroup
	, dealername
	, invoiceamount
	, invoicedate
	, rundate
	, invoicenumber
	, discount
	, totalinvoicecharges
	, depositamount
	, totalorderamount

FROM invoicedorders

WHERE 
	(LEFT(dealer, 2) = territory)

ORDER BY dealer