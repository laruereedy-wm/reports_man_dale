SELECT DISTINCT 'None' AS WOOD
FROM            openorders.dbo.WOODS
UNION ALL
SELECT DISTINCT WOOD
FROM            openorders.dbo.WOODS AS WOODS_1