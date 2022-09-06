--B Building - Production Clearing - Master Expeditor Report
--wands
--WOOD03_Expeditor

Declare @SQL nvarchar(1000)
declare @whereClause as nvarchar(200)
declare @PKwhereClause as nvarchar(2000)

SET @PKwhereClause = ''


    IF(@department = '2328' OR '2328' IN (SELECT DISTINCT DEPARTMENT
                                                     FROM         PROFITKEYDB.PK1.dbo.CSSI_LOCATIONS
                                                     WHERE     (AREALEADER = @areaLeader)))
    BEGIN
              set @whereClause = @whereClause + ' OR CSSI.LOCATIONCODE = ''43'' ' 
    END

    IF(@department = '2331/2329' OR '2331/2329' IN (SELECT DISTINCT DEPARTMENT
                                                     FROM         PROFITKEYDB.PK1.dbo.CSSI_LOCATIONS
                                                     WHERE     (AREALEADER = @areaLeader)))
    BEGIN
              set @whereClause = @whereClause + ' OR CSSI.LOCATIONCODE = ''43'' ' 
    END

    IF(@department = '2226' OR '2226' IN (SELECT DISTINCT DEPARTMENT
                                                     FROM         PROFITKEYDB.PK1.dbo.CSSI_LOCATIONS
                                                     WHERE     (AREALEADER = @areaLeader)))
    BEGIN
              set @whereClause = @whereClause + ' OR CSSI.LOCATIONCODE = ''43'' ' 
    END

    IF(@department = '3058' OR '3058' IN (SELECT DISTINCT DEPARTMENT
                                                     FROM         PROFITKEYDB.PK1.dbo.CSSI_LOCATIONS
                                                     WHERE     (AREALEADER = @areaLeader)))
    BEGIN
             set @whereClause = @whereClause + ' OR CSSI.LOCATIONCODE = ''44'' 
             OR CSSI.LOCATIONCODE = ''44A'' ' 
    END

    IF(@department = '2437' OR '2437' IN (SELECT DISTINCT DEPARTMENT
                                                     FROM         PROFITKEYDB.PK1.dbo.CSSI_LOCATIONS
                                                     WHERE     (AREALEADER = @areaLeader)))
    BEGIN
              set @whereClause = @whereClause + ' OR CSSI.LOCATIONCODE = ''44'' 
              OR CSSI.LOCATIONCODE = ''44A'' ' 
    END

    IF(@department = '2435' OR '2435' IN (SELECT DISTINCT DEPARTMENT
                                                     FROM         PROFITKEYDB.PK1.dbo.CSSI_LOCATIONS
                                                     WHERE     (AREALEADER = @areaLeader)))
    BEGIN
              set @whereClause = @whereClause + ' OR CSSI.LOCATIONCODE = ''44'' 
              OR CSSI.LOCATIONCODE = ''44A'' ' 
    END

SET @SQL = 'SELECT DISTINCT LOCATIONCODE
                     FROM  PROFITKEYDB.PK1.dbo.CSSI_LOCATIONS AS CSSI '  + @whereClause 
IF(@PKwhereClause <> '')
                 SET @SQL = @SQL + ' UNION ALL 
                     SELECT DISTINCT OP_WCKEY
                     FROM  vExpeditorOrdersAll AS EXPEDITOR ' + @PKwhereClause + ' AND OP_WCKEY <> ''''' + ' ORDER BY LOCATIONCODE'
                     
                     
                     
DECLARE @myLocations TABLE (myDept VARCHAR(10), myLoc VARCHAR(10))
INSERT INTO @myLocations (myDept, myLoc)
    VALUES ('2328', '43')
    ,VALUES ('2331/2329', '43')
    ,VALUES ('2226', '43')
    ,VALUES ('3058', '44')
    ,VALUES ('3058', '44A')
    ,VALUES ('2437', '44')
    ,VALUES ('2437', '44A')
    ,VALUES ('2435', '44')
    ,VALUES ('2435', '44A')

DECLARE @firstWhere TINYINT
SET @firstWhere =
	CASE WHEN @areaLeader = 'None' THEN 0 ELSE 1 END
		+ CASE WHEN @groupLeader = 'None' THEN 0 ELSE 3 END
		+ CASE WHEN @department = 'None' THEN 0 ELSE 5 END

SELECT DISTINCT 
	LOCATIONCODE
FROM  dbo.CSSI_LOCATIONS AS CSSI
WHERE 
	(
		(@firstWhere = 5
			AND	CSSI.DEPARTMENT = @department)
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
		--(@firstWhere = 5
		--	AND	CSSI.DEPARTMENT = @department)
		--OR 
		(@firstWhere = 3
			AND EXPEDITOR.PKGROUPLEADER = @groupLeader)
		--OR (@firstWhere = 1
		--	AND CSSI.AREALEADER = @areaLeader)
		OR(@firstWhere = 4
			AND CSSI.AREALEADER = @areaLeader
			AND EXPEDITOR.PKGROUPLEADER = @groupLeader)
		--OR (@firstWhere = 6
		--	AND CSSI.AREALEADER = @areaLeader
		--	AND CSSI.DEPARTMENT = @department)
		OR (@firstWhere = 8
			AND EXPEDITOR.PKGROUPLEADER = @groupLeader
			AND CSSI.DEPARTMENT = @department)
		OR (@firstWhere = 9
			AND CSSI.AREALEADER = @areaLeader
			AND EXPEDITOR.PKGROUPLEADER = @groupLeader
			AND CSSI.DEPARTMENT = @department)
	)
	AND OP_WCKEY <> ''