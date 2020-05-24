SELECT * FROM (SELECT A.name, A.hour, A.ts, B.max_high FROM (SELECT name, high, ts, SUBSTRING(ts, 12, 2) AS hour  FROM "23" db) A
INNER JOIN (SELECT name, SUBSTRING(ts, 12, 2) AS hour, MAX(high) AS max_high FROM "23" GROUP BY name, SUBSTRING(ts, 12, 2)) B
ON A.name = B.name AND A.hour = B.hour AND A.high = B.max_high)
ORDER BY name, hour
