SELECT date(t) AS date, COUNT(*) FROM Positions AS p 
INNER JOIN Vessels AS v ON p.vessel_id=v.id
INNER JOIN VesselTypes AS vt ON v.type=vt.code
WHERE description LIKE 'Passenger%' AND t >= '2019-08-14 00:00:00' AND t <= '2019-08-18 23:59:59'
GROUP BY date