--B Building - Production Clearing - Master Expeditor Report
-- department
--Wood03_Expeditor

declare @SQL nvarchar(1000)
declare @whereClause as nvarchar(200)

if @areaLeader = 'None'
   if @groupLeader = 'None'
      if @department <> 'None'
set @whereClause = 'WHERE   CSSI.DEPARTMENT = ' + '''' + @department + ''''
if @areaLeader = 'None'
   if @department = 'None'
      if @groupLeader <> 'None'
set @whereClause = 'WHERE   CSSI.GROUPLEADER = ' + '''' + @groupLeader + ''''
if @department = 'None'
   if @groupLeader = 'None'
      if @areaLeader <> 'None' 
set @whereClause = 'WHERE  CSSI.AREALEADER = ' + '''' + @areaLeader + ''''
if @areaLeader <> 'None'
   if @groupLeader <> 'None'
      if @department = 'None'
set @whereClause = 'WHERE   CSSI.AREALEADER = ' + '''' + @areaLeader + '''' + ' AND   CSSI.GROUPLEADER = ' + '''' + @groupLeader + ''''
if @areaLeader <> 'None'
   if @groupLeader = 'None'
      if @department <> 'None'
set @whereClause = 'WHERE   CSSI.AREALEADER = ' + '''' +@areaLeader + '''' + ' AND   CSSI.DEPARTMENT = ' + '''' +@department + ''''
if @areaLeader = 'None'
   if @groupLeader <> 'None'
      if @department <> 'None'
set @whereClause = 'WHERE  CSSI.GROUPLEADER= ' + '''' +@groupLeader + '''' + ' AND   CSSI.DEPARTMENT = ' + '''' +@department + ''''
if @areaLeader <> 'None'
   if @groupLeader <> 'None'
      if @department <> 'None'
set @whereClause = 'WHERE   CSSI.AREALEADER = ' + '''' + @areaLeader + '''' + '  AND   CSSI.GROUPLEADER= ' + '''' + @groupLeader + '''' + ' AND   CSSI.DEPARTMENT = ' + '''' + @department + ''''


SET @SQL = 'SELECT DISTINCT DEPARTMENT
                     FROM  PROFITKEYDB.PK1.dbo.CSSI_LOCATIONS AS CSSI '  + @whereClause + ' AND NOT DEPARTMENT IS NULL'

EXEC(@SQL)