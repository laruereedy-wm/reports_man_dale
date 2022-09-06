SELECT DISTINCT 
	territory
	, dealernumber
	, ordernumber
	, distnumber
	, dealername
	, jobname
	, recdate
	, probshipdate
	, designcode
	, logdate
	, estimated
	, credithold
	, oldshipdate
	, loggeddate
	, code
FROM loggedorders
WHERE (territory = @territory) 
	AND (loggeddate >= @loggedDate) 
	AND (loggeddate <= @loggedDate + '11:59:59 PM')
ORDER BY dealernumber, territory