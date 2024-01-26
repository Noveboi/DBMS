SELECT DISTINCT vessel_id 
FROM Positions AS p
INNER JOIN Vessels AS v ON p.vessel_id=v.id
INNER JOIN VesselTypes AS vt ON v.type=vt.code
WHERE description LIKE 'Cargo%' AND speed = 0 AND t >= '2019-08-15 00:00:00' AND t <= '2019-08-18 23:59:59'