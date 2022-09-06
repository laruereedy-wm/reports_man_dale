SELECT 
	Territory
	, acct07
	, dealer
	, OrderNumber
	, ItemNumber
	, cabn07
	, Library
	, Status
	, FileName
	, Sheet
	, WebConversionDate
	, LastUpdatedDate
	, jobn07
	, dist07

FROM         vDrawingsWithOrderItemDetail
WHERE (Territory = @territory) 
	AND (WebConversionDate >= @lastupdateddate) 
	AND (WebConversionDate <= DATEADD(day, 1, @lastupdateddate) 
                      + '11:59:59 PM')
ORDER BY acct07

