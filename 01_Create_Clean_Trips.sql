CREATE OR REPLACE TABLE
  `inbound-obelisk-505302-s8.cyclistic_capstone.clean_trips`
PARTITION BY DATE(started_at)
CLUSTER BY member_casual AS

WITH prepared AS (
  SELECT
    *,
    TIMESTAMP_DIFF(ended_at, started_at, MILLISECOND) / 60000.0
      AS ride_length,
    EXTRACT(DAYOFWEEK FROM started_at)
      AS day_of_week,
    FORMAT_TIMESTAMP('%A', started_at)
      AS day_name,
    FORMAT_TIMESTAMP('%Y-%m', started_at)
      AS ride_month,
    EXTRACT(HOUR FROM started_at)
      AS start_hour,
    ROW_NUMBER() OVER (
      PARTITION BY ride_id
      ORDER BY started_at, ended_at
    ) AS duplicate_rank
  FROM
    `inbound-obelisk-505302-s8.cyclistic_capstone.raw_trips`
  WHERE
    ride_id IS NOT NULL
    AND started_at IS NOT NULL
    AND ended_at IS NOT NULL
    AND member_casual IN ('member', 'casual')
)

SELECT
  * EXCEPT (duplicate_rank)
FROM
  prepared
WHERE
  duplicate_rank = 1
  AND ride_length BETWEEN 1 AND 1440
  AND started_at >= TIMESTAMP('2025-09-01')
  AND started_at < TIMESTAMP('2026-09-01');