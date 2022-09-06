SELECT
	DERF.DERF_Territory AS Territory
	, DERF.DERF_DealerNo AS acct07
	, DERF.DERF_Name AS dealer
	, OH.OrderNum AS OrderNumber
	, RIGHT('00' + CAST(OI.ItemNum AS VARCHAR(3)),3) AS ItemNumber
	, OI.CabinetNumber AS cabn07
	, DWG.Library AS Library
	, DWG.Status AS Status
	, DWG.FileName AS FileName
	, DWG.Sheet AS Sheet
	, DWG.WebConversionDate AS WebConversionDate
	, DATEADD(dd, DATEDIFF(dd, 0, DWG.LastUpdatedDate), 0) AS LastUpdatedDate
	, OH.JobName AS jobn07
	, OH.DistributorNum AS dist07
	--, dbo.wmfOrderNumStrip(DWG.OrderNumber) AS DWGOrderNumber -- removes extra space form order number
	--, dbo.wmfOrderNumPad(OH.OrderNum, 1) AS OHOrderNumber -- adds extra space to order number
	--, dbo.wmfOrderNumPad(dbo.wmfOrderNumStrip(DWG.OrderNumber),1)
FROM OrderHeader AS OH
JOIN WIPS_DealerRef_DERF AS DERF
	ON OH.Account = DERF.DERF_DealerNo
JOIN OrderItems AS OI
	ON OH.OrderNum = OI.OrderNum
JOIN WOOD03.openorders.dbo.Drawings AS DWG
	--ON OH.OrderNum = dbo.wmfOrderNumPad(dbo.wmfOrderNumStrip(DWG.OrderNumber),1)
	ON OH.OrderNum = RTRIM(LEFT(DWG.OrderNumber,2) + RIGHT(DWG.OrderNumber,9))
	AND RIGHT('00' + CAST(OI.ItemNum AS VARCHAR(3)),3) = RTRIM(DWG.ItemNumber)

WHERE --Suggest removing this statement to test other parts of code for accuracy.
    OH.OrderStatus = 'O' --removes canceled orders
    AND OI.ItemStatus = 'O' --removes canceled items
    AND OI.ItemNum < 888 --removes hardware item 888
    AND OH.AllItemsInvoiced = 0

ORDER BY acct07