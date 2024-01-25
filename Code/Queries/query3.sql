WITH Vessels_over_30 AS (
	SELECT DISTINCT type, vessel_id FROM Positions AS p 
	INNER JOIN Vessels AS v ON p.vessel_id=v.id
	WHERE speed>30)
SELECT count(*), type FROM Vessels_over_30
GROUP BY type