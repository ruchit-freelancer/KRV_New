USE [KRV]
GO
/****** Object:  StoredProcedure [dbo].[KRV_Report_GetFuelCost]    Script Date: 07/01/2012 12:36:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[KRV_Report_GetFuelCost]
AS

DECLARE @Stops TABLE
(
[TMonth][INT],
[Stops][INT],
[SlabsDelivered][INT],
[SlabsDeliveredPerStop][DECIMAL](18,2)
)

INSERT INTO @Stops
SELECT MONTH(t.TripDate),COUNT(ts.StopID),SUM(ts.SlabsDelivered),SUM(ts.SlabsDelivered)/COUNT(ts.StopID) 
FROM TripStops ts,Trips t WHERE t.TripID=ts.TripID GROUP BY MONTH(t.TripDate)

SELECT 
l.City,
DATENAME(MONTH,CAST(MONTH(t.TripDate) AS VARCHAR) + '/01/1900') AS TripMonth,
YEAR(t.TripDate) AS TripYear,
COUNT(DISTINCT t.TruckID) as 'Trucks',
COUNT(DISTINCT t.DriverID) as 'Drivers',
SUM(t.EndOdometer-t.StartOdometer) AS Miles,
ts.Stops AS Stops,
ts.SlabsDelivered AS SlabsOut,
(SELECT SUM(fh.Gallons) FROM FuelHistory fh WHERE MONTH(fh.FuelingDate)=MONTH(t.TripDate)) AS TotalFuelPurchased,
(SUM(t.EndOdometer-t.StartOdometer)/(SELECT SUM(fh.Gallons) FROM FuelHistory fh WHERE MONTH(fh.FuelingDate)=MONTH(t.TripDate))) AS MPG,
(SELECT SUM(fh.UnitPrice)/COUNT(fh.UnitPrice) FROM FuelHistory fh WHERE MONTH(fh.FuelingDate)=MONTH(t.TripDate)) AS CostPerGallon,
(SELECT SUM(fh.TotalCost) FROM FuelHistory fh WHERE MONTH(fh.FuelingDate)=MONTH(t.TripDate)) AS TotalFuelCost,
(SELECT SUM(fh.TotalCost)/SUM(t.EndOdometer-t.StartOdometer) FROM FuelHistory fh WHERE MONTH(fh.FuelingDate)=MONTH(t.TripDate)) AS FuelCostPerMile,
SUM(t.EndOdometer-t.StartOdometer)/ts.Stops AS AvgMilesPerStop,
(SELECT SUM(fh.TotalCost)/ts.Stops FROM FuelHistory fh WHERE MONTH(fh.FuelingDate)=MONTH(t.TripDate)) AS FuelCostPerStop,
ts.SlabsDeliveredPerStop AS SlabsDeliveredPerStop,
(SELECT (SUM(fh.TotalCost)/ts.Stops)/(SUM(ts.SlabsDelivered)/ts.Stops) FROM FuelHistory fh WHERE MONTH(fh.FuelingDate)=MONTH(t.TripDate)) AS FuelCostPerSlab
FROM 
Trips t,@Stops ts,Locations l
WHERE
t.LocationID=l.LocationID
AND
MONTH(t.TripDate)=ts.TMonth
AND
MONTH(t.TripDate)=4
GROUP BY l.City,MONTH(t.TripDate),YEAR(t.TripDate),ts.Stops,ts.SlabsDelivered,ts.SlabsDeliveredPerStop