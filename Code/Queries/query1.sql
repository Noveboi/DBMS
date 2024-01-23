SELECT DATE(t) AS date, lon, lat, count(*) AS count 
FROM positions 
GROUP BY date, lon, lat
ORDER BY count DESC;