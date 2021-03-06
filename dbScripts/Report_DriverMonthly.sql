ALTER PROCEDURE [dbo].[KRV_Report_GetDriverMonthlySheet]
AS

DECLARE @Stops TABLE
(
[TMonth][INT],
[DriverID][INT],
[Stops][INT],
[SlabsDelivered][DECIMAL](18,2),
[SlabsReturned][DECIMAL](18,2),
[TotalSlabs][DECIMAL](18,2),
[PercentReturns][DECIMAL](18,2)
)

INSERT INTO @Stops
SELECT 
MONTH(t.TripDate),
t.DriverID,
COUNT(ts.StopID),
SUM(ts.SlabsDelivered),
SUM(ts.SlabsPickedUp),
SUM(ts.SlabsDelivered+ts.SlabsPickedUp),
0
FROM TripStops ts,Trips t WHERE t.TripID=ts.TripID GROUP BY MONTH(t.TripDate),t.DriverID

update @Stops
set PercentReturns = (SlabsReturned/SlabsDelivered)

SELECT
l.City,
DATENAME(MONTH,CAST(MONTH(t.TripDate) AS VARCHAR) + '/01/1900') AS TripMonth,
YEAR(t.TripDate) AS TripYear,
d.DriverName,
SUM(t.EndOdometer-t.StartOdometer) AS Miles,
SUM(DATEDIFF(HH,t.TripStart,t.TripEnd)) AS HrsLogged,
ts.Stops,
ts.SlabsDelivered,
ts.SlabsReturned,
ts.TotalSlabs,
ts.PercentReturns
FROM
Trips t,
Drivers d,
@Stops ts,
Locations l
WHERE
t.LocationID=l.LocationID
AND
MONTH(t.TripDate)=ts.TMonth
AND
ts.DriverID=t.DriverID
AND
t.DriverID=d.DriverID
GROUP BY 
MONTH(t.TripDate),
YEAR(t.TripDate),
d.DriverName,
ts.Stops,
ts.SlabsDelivered,
ts.SlabsReturned,
ts.TotalSlabs,
ts.PercentReturns,
l.City