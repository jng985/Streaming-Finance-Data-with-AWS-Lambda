SELECT upper(name) AS Name, round(high,2) AS High, ts AS Timestamp, hour AS Hour
FROM(
  select db.*, SUBSTRING(ts, 12, 2) AS Hour, ROW_NUMBER() OVER(PARTITION BY name, SUBSTRING(ts, 12, 2) ORDER BY high) AS rn
  FROM "23" db
  WHERE ts between '2020-05-14 09:30:00' AND '2020-05-14 16:00:00'
) db1 WHERE rn=1 ORDER BY name, ts
