SELECT
	OH.DesignGroup AS design
	, OH.OrderNum AS ordernum
	, '??' AS amount
	, OH.DisplayCategory AS display
	, OH.CustomerNum AS billto
	

FROM OrderHeader AS OH
JOIN OrderTotals AS OT
	ON OH.OrderNum = OT.OrderNum


WHERE

ORDER BY
