SELECT 
	dealernumber
	, territory
	, dealername
	, distnumber
	, jobname
	, ordernumber
	, recdate
	, shipdate
	, designcode
	, estimated
	, logdate
	, credithold
	, rushjc
	, ackdate
	, ID
	, oldshipdate
	
FROM ackorders AS ackorders

WHERE (ackdate >= ackDate) 
	AND (ackdate <= ackDate + '11:59:59 PM') 
	AND (dealernumber = dealer)
	
ORDER BY dealernumber