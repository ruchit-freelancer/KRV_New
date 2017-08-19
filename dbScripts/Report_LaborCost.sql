CREATE PROCEDURE dbo.Report_GetLaborCost
AS

DECLARE @Drivers TABLE
(
[DriverID][INT],
[Salary][DECIMAL](18,2),
[DMonth][INT]
)

INSERT INTO @Drivers
SELECT DISTINCT t.DriverID, d.Salary,MONTH(t.TripDate) AS TripMonth from Trips t,Drivers d WHERE t.DriverID=d.DriverID ORDER BY MONTH(t.TripDate)

--SELECT
--d.DMonth,
--COUNT(DISTINCT t.DriverID) as 'Drivers',
--(SELECT SUM(d1.Salary) FROM @Drivers d1 WHERE d1.DMonth=MONTH(t.TripDate))
--FROM
--Trips t,@Drivers d
--WHERE
--t.DriverID=d.DriverID
--AND
--d.DMonth=MONTH(t.TripDate)
--GROUP BY d.DMonth,MONTH(t.TripDate)

DECLARE @Stops TABLE
(
[LocationID][INT],
[TMonth][INT],
[Stops][INT],
[SlabsDelivered][DECIMAL](18,2),
[SlabsDeliveredPerStop][DECIMAL](18,2),
[SlabsReturned][INT]
)

INSERT INTO @Stops
SELECT l.LocationID,MONTH(t.TripDate),COUNT(ts.StopID),
(1.00*SUM(ts.SlabsDelivered)),
(1.00*(SUM(ts.SlabsDelivered)/COUNT(ts.StopID))),
(1.00*SUM(ts.SlabsPickedUp))
FROM TripStops ts,Trips t,Locations l WHERE t.LocationID=l.LocationID AND t.TripID=ts.TripID GROUP BY MONTH(t.TripDate),l.LocationID


SELECT
l.City,
DATENAME(MONTH,CAST(d.DMonth AS VARCHAR) + '/01/1900') AS TripMonth,
YEAR(t.TripDate) AS TripYear,
COUNT(DISTINCT t.TruckID) as 'Trucks',
COUNT(DISTINCT t.DriverID) as 'Drivers',
(SELECT SUM(d1.Salary) FROM @Drivers d1 WHERE d1.DMonth=MONTH(t.TripDate)) AS FixedLaborCostForMonth,
SUM(DATEDIFF(HH,t.TripStart,t.TripEnd)) AS DriverHoursWorked,
SUM(t.EndOdometer-t.StartOdometer) AS Miles,
((SELECT SUM(d1.Salary) FROM @Drivers d1 WHERE d1.DMonth=MONTH(t.TripDate))/(SUM(t.EndOdometer-t.StartOdometer))) AS LaborCostPerMile,
s.Stops,
s.SlabsDelivered AS SlabsOut,
((SELECT SUM(d1.Salary) FROM @Drivers d1 WHERE d1.DMonth=MONTH(t.TripDate))/(s.Stops)) AS LaborCostPerStopByMileage,
s.SlabsDeliveredPerStop,
(((SELECT SUM(d1.Salary) FROM @Drivers d1 WHERE d1.DMonth=MONTH(t.TripDate))/(s.Stops))/(s.SlabsDeliveredPerStop)) AS LaborCostPerSlab
FROM
Trips t,@Drivers d,@Stops s,Locations l
WHERE
l.LocationID=t.LocationID
AND
t.LocationID=s.LocationID
AND
s.TMonth=MONTH(t.TripDate)
AND
t.DriverID=d.DriverID
AND
d.DMonth=MONTH(t.TripDate)
GROUP BY l.City,d.DMonth,t.LocationID,MONTH(t.TripDate),YEAR(t.TripDate),s.Stops,s.SlabsDelivered,s.SlabsDeliveredPerStop
