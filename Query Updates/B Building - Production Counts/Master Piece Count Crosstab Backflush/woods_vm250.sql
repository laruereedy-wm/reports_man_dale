-- Results in many duplicate values

SELECT
	OS.DoorWoodCode AS WOOD

FROM 
	OrderStyles AS OS

ORDER BY WOOD ASC;