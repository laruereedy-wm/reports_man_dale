SELECT DISTINCT 
	loggeddate
	, territory
	, dealernumber
	, distnumber
	, jobname
	, ordernumber
	, recdate
	, code
	, probshipdate
	, oldshipdate
	, designcode
	, dealername
	, estimated
	, logdate
	, credithold
	, isonline
	
FROM stockorders

WHERE (loggeddate >= @loggedDate) 
	AND (loggeddate <= @loggedDate + '11:59:59 PM') 
	AND (territory = @territory)
	
ORDER BY dealernumber, territory