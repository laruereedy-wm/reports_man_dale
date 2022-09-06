SELECT
    Report
    ,ReportMonth
    ,ReportYear
    ,ReportCount
    ,Reviewed
    ,DateUpdated
FROM ReportServer.wm.vUsageHistory_Reports
ORDER BY
    ReportYear DESC
    , ReportMonth DESC
    , ReportCount DESC