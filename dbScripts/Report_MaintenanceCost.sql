USE [KRV]
GO
/****** Object:  StoredProcedure [dbo].[KRV_Report_TruckMaintenance]    Script Date: 07/01/2012 16:38:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[KRV_Report_TruckMaintenance]
AS
SELECT 
t.TruckNo,
l.City,
DATENAME(MONTH,CAST(MONTH(tm.MaintenanceDate) AS VARCHAR) + '/01/1900') AS MaintenanceMonth,
YEAR(tm.MaintenanceDate) as MaintenanceYear,
SUM(tm.TotalCost) AS TotalCost
FROM
TruckMaintenance tm,
Trucks t,
Locations l
WHERE
tm.LocationID=l.LocationID
AND
tm.TruckID=t.TruckID
AND
t.LocationID=l.LocationID
GROUP BY
YEAR(tm.MaintenanceDate),t.TruckNo,l.City,DATENAME(MONTH,CAST(MONTH(tm.MaintenanceDate) AS VARCHAR) + '/01/1900')