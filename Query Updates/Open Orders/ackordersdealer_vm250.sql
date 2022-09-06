SELECT 
	DERF_DealerNo AS dealernumber
	, DERF_Territory AS territory
	, DERF_Name AS dealername
	, OH.DistributorNum AS distnumber
	, OH.JobName AS jobname
	, OH.OrderNum AS ordernumber
	, OH.OrderReceivedDate AS recdate
	, OH.ShipDate AS shipdate
	, DGRF.DGRF_DesignGroup AS designcode
	, OH.EstimatedTotal AS estimated
	, OH.OrderLogDate AS logdate
	, CASE OH.CreditStatus
		WHEN 0 THEN 'YES'
		ELSE 'NO' END AS credithold
	, OH.OrderType AS rushjob --See what comes up
	, OH.ReleasedToPlantDate AS ackdate --Need Source
	, '??' AS ID
	, '??' AS oldshipdate
	
FROM OrderHeader AS OH
JOIN WIPS_DealerRef_DERF AS DERF
	ON OH.Account = DERF.DERF_DealerNo
JOIN WIPS_DesignGroupRef_DGRF AS DGRF
	ON OH.DesignGroup = DGRF.DGRF_DesignGroupOneChar

WHERE 
	OH.OrderStatus = 'O'
	AND OH.AllItemsInvoiced = 0

ORDER BY dealernumber