SELECT 
	dbo.neword20.ID
	, dbo.neword20.ordn07
	, dbo.neword20.item07
	, dbo.neword20.cabn07
	, dbo.neword20.trak07
	, dbo.neword20.Track_Date
	, dbo.neword20.shpr07
	, dbo.neword20.carr07
	, dbo.neword20.cube07
	, dbo.neword20.Inv_Date
	, dbo.neword20.Due_Wrhse
	, dbo.neword20.Date_Itm_Changed
	, dbo.neword20.Tracking_Num
	, dbo.neword20.bill07
	, dbo.neword20.oos07
	, dbo.neword20.team07
	, dbo.neword20.qty07
	, dbo.neword20.trackingcode
	, dbo.ItemHeaders.HEADERNO
	, dbo.TRACKINGCODES.RSTATUS
	, dbo.TRACKINGCODES.DSTATUS
	
FROM dbo.neword20 
LEFT OUTER JOIN dbo.TRACKINGCODES 
	ON dbo.neword20.trackingcode = dbo.TRACKINGCODES.trackingcode 
LEFT OUTER JOIN dbo.ItemHeaders 
	ON dbo.neword20.ordn07 = dbo.ItemHeaders.ORDN07 
	AND dbo.neword20.item07 = dbo.ItemHeaders.ITEM07