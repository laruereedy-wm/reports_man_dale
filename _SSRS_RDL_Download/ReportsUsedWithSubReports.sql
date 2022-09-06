/* declare and populate temp table */
DECLARE @tab TABLE (Path NVARCHAR(MAX), xmlColumn XML)
INSERT @tab 
SELECT top 1500 Path, CONVERT(XML, CONVERT(VARBINARY(MAX), Content)) FROM Catalog WHERE Type=2;

DECLARE @reportList TABLE(report VARCHAR(2000), subReport VARCHAR(2000));

/* find subreports in RS 2005-based main reports */
WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/reporting/2005/01/reportdefinition' as rdl)
INSERT INTO @reportList
SELECT Path as ReportPath, 
n.x.value('(//rdl:ReportName)[1]', 'nvarchar(256)') as ReferencedReport
FROM @tab
CROSS APPLY xmlColumn.nodes('//rdl:Subreport') n(x);

/* find subreports in RS 2008-based main reports */
WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/reporting/2008/01/reportdefinition' as rdl)
INSERT INTO @reportList
SELECT Path as ReportPath, 
n.x.value('(//rdl:ReportName)[1]', 'nvarchar(256)') as ReferencedReport
FROM @tab
CROSS APPLY xmlColumn.nodes('//rdl:Subreport') n(x);

SELECT RH.Report, ISNULL(RL.subReport,'') AS SubReport
FROM ReportServer.wm.vUsageHistory_Reports RH
LEFT JOIN @reportList RL
	ON RH.Report COLLATE SQL_Latin1_General_CP1_CI_AS = RL.report
GROUP BY RH.Report, ISNULL(RL.subReport,'')
ORDER BY RH.Report
--ORDER BY ReportYear DESC, ReportMonth DESC, ReportCount DESC