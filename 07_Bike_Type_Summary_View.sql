CREATE OR REPLACE VIEW
  `inbound-obelisk-505302-s8.cyclistic_capstone.summary_bike_type` AS

SELECT
  rideable_type,
  member_casual,
  COUNT(*) AS total_rides,
  ROUND(
    100 * COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY member_casual),
    2
  ) AS percentage_within_rider_type
FROM
  `inbound-obelisk-505302-s8.cyclistic_capstone.clean_trips`
GROUP BY
  rideable_type,
  member_casual;
