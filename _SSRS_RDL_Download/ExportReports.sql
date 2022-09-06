DECLARE @OutputPath AS VARCHAR(500) = 'D:\Reports' 
DECLARE @ReportName AS VARCHAR(500) = NULL 
DECLARE @ReportData AS VARCHAR(MAX) 
  
--Reset the OutputPath separator. 
SET @OutputPath = REPLACE(@OutputPath,'\','/') 

DECLARE @type TABLE (id INT, value VARCHAR(10), ext VARCHAR(4))
INSERT INTO @type (id,value,ext) VALUES (2,'Report','.rdl')
INSERT INTO @type (id,value,ext) VALUES (4,'Linked','.rll')
INSERT INTO @type (id,value,ext) VALUES (5,'DataSource','.rds')

DECLARE reportList CURSOR FOR
	SELECT
		@OutputPath + CL.Path COLLATE SQL_Latin1_General_CP1_CI_AS + RT.ext AS rptFileName
		, CASE 
			WHEN LEFT( CONVERT( VARCHAR(MAX), CONVERT( VARBINARY(MAX), CL.content ) ),3 ) = 0xEFBBBF
			THEN STUFF(CONVERT( VARCHAR(MAX), CONVERT( VARBINARY(MAX), CL.content ) ),1,3,'')
			ELSE CONVERT( VARCHAR(MAX), CONVERT( VARBINARY(MAX), CL.content ) )
			END AS ReportContent
	FROM WOOD20.ReportServer.dbo.[Catalog] CL 
	JOIN @type RT
		ON CL.[Type] = RT.id
	WHERE 
		CL.[Type] IN (2,5) --Report
		AND NOT CL.Content IS NULL

OPEN reportList
FETCH NEXT FROM reportlist INTO @ReportName, @ReportData

WHILE @@FETCH_STATUS = 0
BEGIN
	--Do Something
	PRINT(@ReportName)
	EXEC WriteToFile @ReportName,@ReportData

	FETCH NEXT FROM reportlist INTO @ReportName, @ReportData
END

CLOSE reportList
DEALLOCATE reportList
