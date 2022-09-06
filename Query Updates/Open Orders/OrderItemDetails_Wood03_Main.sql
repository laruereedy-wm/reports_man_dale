SELECT     
	ordn07
	, item07
	, cabn07 AS description
	, trak07 AS status
	, Track_Date
	, shpr07
	, carr07
	, cube07
	, Inv_Date
	, Due_Wrhse AS duetowarehouse
	, Date_Itm_Changed
	, Tracking_Num
	, bill07
	, oos07
	, team07
	, qty07 AS quantity
	, HEADERNO AS header
	, RSTATUS
	, DSTATUS
	
FROM vOpenOrderItems
WHERE (ordn07 = @orderNumber)