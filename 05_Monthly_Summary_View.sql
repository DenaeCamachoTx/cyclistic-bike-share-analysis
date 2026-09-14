CREATE OR REPLACE VIEW
  `inbound-obelisk-505302-s8.cyclistic_capstone.summary_monthly` AS

SELECT
  ride_month,
  member_casual,
  COUNT(*) AS total_rides,
  ROUND(AVG(ride_length), 2) AS average_ride_length_minutes
FROM
  `inbound-obelisk-505302-s8.cyclistic_capstone.clean_trips`
GROUP BY
  ride_month,
  member_casual;
