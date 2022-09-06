--B Building - Production Clearing - Master Location Duration
--latestShipWeek
--vm250_WIPS_Production

SELECT ClearDate AS SHIPDATE

FROM ManufacturingCalendar

WHERE CalendarDate = CAST(GETDATE() AS DATE)