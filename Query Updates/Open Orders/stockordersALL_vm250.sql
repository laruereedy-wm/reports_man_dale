SELECT
	'??' AS loggeddate
	, DERF.DERF_Territory AS territory
	, DERF.DERF_DealerNo AS dealernumber
	, OH.DistributorNum AS distnumber
	, OH.JobName AS jobname
	, OH.OrderNum AS ordernumber
	, OH.OrderReceivedDate AS recdate
	, DGRF.DGRF_DesignGroup AS code --Same as below, not logical
	, '??' AS probshipdate
	, '??' AS oldshipdate
	, DGRF.DGRF_DesignGroup AS designcode
	, DERF.DERF_Name AS dealername
	, '??' AS estimated
	, OH.OrderLogDate AS logdate
	, CASE OH.CreditStatus
		wHEN 0 THEN 'YES'
		ELSE 'NO' END AS credithold
	, '??' AS isonline

FROM OrderHeader AS OH
JOIN WIPS_DealerRef_DERF AS DERF
	ON OH.Account = DERF.DERF_DealerNo
JOIN WIPS_DesignGroupRef_DGRF AS DGRF
	ON OH.DesignGroup = DGRF.DGRF_DesignGroupOneChar

WHERE
	OH.OrderStatus = 'O'
	AND OH.AllItemsInvoiced = 0

ORDER BY
	dealernumber
	, territory