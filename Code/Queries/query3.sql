WITH Vessels_over_30 AS (
	SELECT type, vessel_id 
	FROM Positions AS p 
	INNER JOIN Vessels AS v ON p.vessel_id=v.id
	WHERE speed>30
	GROUP BY type, vessel_id
	)
SELECT type, COUNT(*) 
FROM Vessels_over_30
GROUP BY type