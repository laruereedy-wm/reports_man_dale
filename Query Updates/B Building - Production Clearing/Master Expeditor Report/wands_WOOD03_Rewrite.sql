DECLARE @myLocations TABLE (myDept VARCHAR(10), myLoc VARCHAR(10))
INSERT INTO @myLocations (myDept, myLoc) VALUES ('2328', '43')
INSERT INTO @myLocations (myDept, myLoc) VALUES ('2331/2329', '43')
INSERT INTO @myLocations (myDept, myLoc) VALUES ('2226', '43')
INSERT INTO @myLocations (myDept, myLoc) VALUES ('3058', '44')
INSERT INTO @myLocations (myDept, myLoc) VALUES ('3058', '44A')
INSERT INTO @myLocations (myDept, myLoc) VALUES ('2437', '44')
INSERT INTO @myLocations (myDept, myLoc) VALUES ('2437', '44A')
INSERT INTO @myLocations (myDept, myLoc) VALUES ('2435', '44')
INSERT INTO @myLocations (myDept, myLoc) VALUES ('2435', '44A')

--DECLARE @department VARCHAR(10)
--SET @department = 'NONE' --'2435'
--DECLARE @arealeader VARCHAR(25)
--SET @arealeader = 'None' --'Joe Bogetti'
--DECLARE @groupleader VARCHAR(25)
--SET @groupleader = 'Dennis Buck B4'

DECLARE @firstWhere TINYINT
SET @firstWhere =
    CASE WHEN @areaLeader = 'None' THEN 0 ELSE 1 END
        + CASE WHEN @groupLeader = 'None' THEN 0 ELSE 3 END
        + CASE WHEN @department = 'None' THEN 0 ELSE 5 END

SELECT DISTINCT Loc.myLoc AS LOCATIONCODE
FROM @myLocations AS Loc
LEFT JOIN PROFITKEYDB.PK1.dbo.CSSI_LOCATIONS CSSI
    ON CSSI.DEPARTMENT = Loc.myDept
WHERE 
    CSSI.AREALEADER = @arealeader
    OR Loc.myDept = @department

UNION ALL
SELECT DISTINCT 
    CSSI.LOCATIONCODE
FROM PROFITKEYDB.PK1.dbo.CSSI_LOCATIONS AS CSSI
LEFT JOIN (
    SELECT DISTINCT
        DEPARTMENT, AREALEADER
    FROM PROFITKEYDB.PK1.dbo.CSSI_LOCATIONS
    WHERE DEPARTMENT IN ('2328','2331/2329','2226','3058','2437','2435')
    ) AS AL
    ON CSSI.DEPARTMENT = AL.DEPARTMENT
WHERE
    CSSI.DEPARTMENT = @department
    OR AL.AREALEADER = @arealeader
    OR (
        (@firstWhere = 5
            AND    CSSI.DEPARTMENT = @department)
        OR (@firstWhere = 3
            AND CSSI.GROUPLEADER = @groupLeader)
        OR (@firstWhere = 1
            AND CSSI.AREALEADER = @areaLeader)
        OR(@firstWhere = 4
            AND CSSI.AREALEADER = @areaLeader
            AND CSSI.GROUPLEADER = @groupLeader)
        OR (@firstWhere = 6
            AND CSSI.AREALEADER = @areaLeader
            AND CSSI.DEPARTMENT = @department)
        OR (@firstWhere = 8
            AND CSSI.GROUPLEADER = @groupLeader
            AND CSSI.DEPARTMENT = @department)
        OR (@firstWhere = 9
            AND CSSI.AREALEADER = @areaLeader
            AND CSSI.GROUPLEADER = @groupLeader
            AND CSSI.DEPARTMENT = @department)
    )

UNION ALL 
SELECT DISTINCT 
    OP_WCKEY
FROM  vExpeditorOrdersAll AS EXPEDITOR
WHERE
    (
        (@firstWhere = 3
            AND EXPEDITOR.PKGROUPLEADER = @groupLeader)
        OR(@firstWhere = 4
            AND EXPEDITOR.AREALEADER = @areaLeader
            AND EXPEDITOR.PKGROUPLEADER = @groupLeader)
        OR (@firstWhere = 8
            AND EXPEDITOR.PKGROUPLEADER = @groupLeader
            AND EXPEDITOR.DEPARTMENT = @department)
        OR (@firstWhere = 9
            AND EXPEDITOR.AREALEADER = @areaLeader
            AND EXPEDITOR.PKGROUPLEADER = @groupLeader
            AND EXPEDITOR.DEPARTMENT = @department)
    )
    AND OP_WCKEY <> ''

--ORDER BY LocationCode