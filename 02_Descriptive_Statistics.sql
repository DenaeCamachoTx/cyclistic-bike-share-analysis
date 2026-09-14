WITH day_counts AS (
  SELECT
    day_of_week,
    day_name,
    COUNT(*) AS ride_count
  FROM
    `inbound-obelisk-505302-s8.cyclistic_capstone.clean_trips`
  GROUP BY
    day_of_week,
    day_name
),

mode_day AS (
  SELECT
    day_of_week,
    day_name,
    ride_count
  FROM
    day_counts
  ORDER BY
    ride_count DESC
  LIMIT 1
)

SELECT
  ROUND(AVG(ride_length), 2) AS mean_ride_length_minutes,
  ROUND(MAX(ride_length), 2) AS maximum_ride_length_minutes,
  (SELECT day_of_week FROM mode_day) AS mode_day_of_week,
  (SELECT day_name FROM mode_day) AS mode_day_name,
  (SELECT ride_count FROM mode_day) AS mode_day_ride_count
FROM
  `inbound-obelisk-505302-s8.cyclistic_capstone.clean_trips`;
