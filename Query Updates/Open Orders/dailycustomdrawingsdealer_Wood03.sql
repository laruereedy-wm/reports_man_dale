SELECT     
	dbo.neword01.Territory
	, dbo.neword01.acct07
	, dbo.neword01.dealer
	, dbo.Drawings.OrderNumber
	,RTRIM(LEFT(Drawings.OrderNumber,2) + RIGHT(Drawings.OrderNumber,9))
	, dbo.Drawings.ItemNumber
	, dbo.neword20.cabn07
	, dbo.Drawings.Library
	, dbo.Drawings.Status
	, dbo.Drawings.FileName
	, dbo.Drawings.Sheet
	, dbo.Drawings.WebConversionDate
	, DATEADD(dd,DATEDIFF(dd, 0, dbo.Drawings.LastUpdatedDate), 0) AS LastUpdatedDate
	, dbo.neword01.jobn07
	, dbo.neword01.dist07
FROM dbo.neword20 
INNER JOIN dbo.neword01 
	ON dbo.neword20.ordn07 = dbo.neword01.ordn07 
INNER JOIN dbo.Drawings 
	ON dbo.neword20.ordn07 = dbo.Drawings.OrderNumber 
	AND dbo.neword20.item07 = dbo.Drawings.ItemNumber
--WHERE 
--	(WebConversionDate>= LastUpdatedDate) 
--	AND (WebConversionDate<= DATEADD(day, 1, LastUpdatedDate) + '11:59:59 PM') 
--	AND (acct07 = dealer)   
ORDER BY 
	Drawings.OrderNumber   