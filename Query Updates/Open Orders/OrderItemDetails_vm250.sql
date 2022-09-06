SELECT
	OH.OrderNum AS ordn07
	, OI.ItemNum AS item07
	, OI.CabinetCode AS description
	, OH.OrderStatus AS status
	, LS.TRACKINGDATETIME AS Track_Date
	, '??' AS shpr07
	, '??' AS cube07
	, OI.InvoiceDate AS Inv_Date
	, Oh.DueToWarehouseDate AS duetowarehouse
	, OI.ChangedDate As Date_Itm_Changed
	, LS.TRACKINGPOINT AS Tracking_Num
	, OI.BillNum AS bill07
	, '??' AS oos07
	, '??' AS team07
	, OI.ItemQty AS quantity
	, '??' AS header
	, '??' AS RSTATUS
	, '??' AS DSTATUS
	
FROM OrderHeader OH
LEFT JOIN OrderItems OI
	ON OH.OrderNum = OI.OrderNum
LEFT JOIN WIPS_StagedData.dbo.PK_CSSI_TRACKING_LASTSCAN LS
    ON OH.OrderNum = LS.MOS_JOB
    AND OI.ItemNum = LS.MOS_LOT