SELECT        TOP 1 'None' AS CABTYPE
FROM            Finishing.dbo.CNTCAB
UNION ALL
SELECT        RTRIM(CABTYPE) AS Expr1
FROM            Finishing.dbo.CNTCAB AS CNTCAB_1