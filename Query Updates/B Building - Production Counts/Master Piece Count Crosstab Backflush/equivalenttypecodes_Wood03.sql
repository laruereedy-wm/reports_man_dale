SELECT        TOP 1 'None' AS CABTYPE
FROM            Finishing.dbo.CNTEQV
UNION
SELECT        RTRIM(CABTYPE) AS Expr1
FROM            Finishing.dbo.CNTEQV AS CNTEQV_1
ORDER BY CABTYPE