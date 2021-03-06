USE [KRV]
GO
/****** Object:  StoredProcedure [dbo].[KRV_Report_GetDriverProductivity]    Script Date: 07/01/2012 13:47:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[KRV_Report_GetDriverProductivity]
AS

DECLARE @Stops TABLE
(
[TMonth][INT],
[Stops][INT],
[SlabsDelivered][DECIMAL](18,2),
[SlabsDeliveredPerStop][DECIMAL](18,2),
[SlabsReturned][INT]
)

INSERT INTO @Stops
SELECT MONTH(t.TripDate),COUNT(ts.StopID),(1.00*SUM(ts.SlabsDelivered)),(1.00*(SUM(ts.SlabsDelivered)/COUNT(ts.StopID))),(1.00*SUM(ts.SlabsPickedUp))
FROM TripStops ts,Trips t WHERE t.TripID=ts.TripID GROUP BY MONTH(t.TripDate)

SELECT 
l.City,
DATENAME(MONTH,CAST(MONTH(t.TripDate) AS VARCHAR) + '/01/1900') AS TripMonth,
YEAR(t.TripDate) AS TripYear,
COUNT(DISTINCT t.TruckID) as 'Trucks',
COUNT(DISTINCT t.DriverID) as 'Drivers',
SUM(DATEDIFF(d,t.TripStart,t.TripEnd))+1 AS DeliveryDaysforMonth,
SUM(t.EndOdometer-t.StartOdometer) AS Miles,
SUM(DATEDIFF(HH,t.TripStart,t.TripEnd)) AS TotalHoursOnDuty,
ts.Stops AS Stops,
ts.SlabsDelivered AS SlabsDelivered,
(1.00*(ts.SlabsDelivered/(SUM(DATEDIFF(d,t.TripStart,t.TripEnd))+1))) AS SlabsDeliveredPerDay,
(ts.SlabsDelivered/(SUM(DATEDIFF(d,t.TripStart,t.TripEnd))+1))/(COUNT(DISTINCT t.DriverID)) AS SlabsDeliveredPerDriver,
ts.SlabsDeliveredPerStop,
(ts.Stops)/(SUM(DATEDIFF(d,t.TripStart,t.TripEnd))+1)/(COUNT(DISTINCT t.DriverID)) AS StopsPerDriverPerDay,
(1.00*(SUM(t.EndOdometer-t.StartOdometer))/(SUM(DATEDIFF(d,t.TripStart,t.TripEnd))+1)/(COUNT(DISTINCT t.DriverID))) AS MilesPerDriverPerDay,
(1.00*(SUM(DATEDIFF(HH,t.TripStart,t.TripEnd)))/(SUM(DATEDIFF(d,t.TripStart,t.TripEnd))+1)/(COUNT(DISTINCT t.DriverID))) AS HoursOnDutyPerDriverPerDay,
ts.SlabsReturned AS SlabsReturn,
(ts.SlabsReturned/ts.SlabsDelivered) AS PercentReturn
FROM 
Trips t,@Stops ts,Locations l
WHERE
t.LocationID=l.LocationID
AND
MONTH(t.TripDate)=ts.TMonth
GROUP BY l.City,MONTH(t.TripDate),YEAR(t.TripDate),ts.Stops,ts.SlabsDelivered,ts.SlabsDeliveredPerStop, ts.SlabsReturned
