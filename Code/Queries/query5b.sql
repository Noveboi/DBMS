WITH sum_speed AS (
	SELECT DISTINCT vessel_id, sum(speed)
	FROM Positions 
	WHERE t >= '2019-08-12 00:00:00' AND t <= '2019-08-19 23:59:59'
	GROUP BY vessel_id
	HAVING sum(speed) <= 1.5
)
SELECT vessel_id, description 
FROM sum_speed AS s
INNER JOIN Vessels AS v ON s.vessel_id = v.id
INNER JOIN VesselTypes AS vt ON v.type = vt.code
WHERE description LIKE 'Cargo%'