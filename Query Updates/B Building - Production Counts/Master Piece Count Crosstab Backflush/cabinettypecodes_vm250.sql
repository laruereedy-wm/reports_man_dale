--Results in many deuplicate values.
SELECT 
	OI.CabinetType AS CABTYPE

FROM 
	OrderItems AS OI
	
ORDER BY CABTYPE ASC;