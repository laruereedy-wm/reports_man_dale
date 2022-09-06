SELECT        TOP 1 'None' AS CABTYPE
FROM            Finishing.dbo.CNTMLD
UNION
SELECT        RTRIM(CABTYPE) AS Expr1
FROM            Finishing.dbo.CNTMLD AS CNTMLD_1
ORDER BY CABTYPE