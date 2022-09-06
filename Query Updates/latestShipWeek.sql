--vm250
--WIPS_Production

SELECT ClearDate
FROM ManufacturingCalendar
WHERE CalendarDate = CAST(GETDATE() AS DATE)