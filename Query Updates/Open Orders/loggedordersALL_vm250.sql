SELECT
	DERF.DERF_Territory AS territory
	, DERF_DealerNo AS dealernumber
	, OH.OrderNum AS ordernumber
	, OH.DistributorNum AS distnumber
	, DERF.DERF_Name AS dealername
	, OH.JobName AS jobname
	, OH.OrderReceivedDate AS recdate
	, OH.ShipDateWasPluggedFlag AS probshipdate --Check this
	, OH.DesignGroup AS designcode
	, OH.OrderLogDate AS logdate
	, OH.EstimatedTotal AS estimated
	, CASE OH.CreditStatus
		WHEN 0 THEN 'YES'
		ELSE 'NO' END as credithold
	, '??' AS oldshipdate
	, OH.OrderLogDate AS loggeddate
	, '??' AS code

FROM OrderHeader AS OH
JOIN WIPS_DealerRef_DERF AS DERF
	ON OH.Account = DERF.DERF_DealerNo
	

WHERE
	OH.OrderStatus = 'O'
	AND OH.AllItemsInvoiced = 0

ORDER BY
	dealernumber, territory