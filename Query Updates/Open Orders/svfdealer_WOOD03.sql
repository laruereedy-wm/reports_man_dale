SELECT DISTINCT 
	design
	, ordernum
	, amount
	, display
	, billto
	, dname
	, sstate
	, scity
	, jobnam
	, cubic
	, routing
	, cod
	, shipment
	, Territory
	, tflag
FROM svfweb AS svfweb
WHERE (billto = @dealer)
ORDER BY billto, ordernum