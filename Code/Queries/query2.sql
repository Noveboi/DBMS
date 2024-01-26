SELECT type, COUNT(*) 
FROM Vessels 
WHERE flag='Greece' 
GROUP BY type