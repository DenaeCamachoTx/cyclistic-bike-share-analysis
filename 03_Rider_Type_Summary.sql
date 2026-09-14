SELECT
  member_casual,
  COUNT(*) AS total_rides,
  ROUND(
    100 * COUNT(*) / SUM(COUNT(*)) OVER (),
    2
  ) AS percentage_of_rides,
  ROUND(AVG(ride_length), 2) AS average_ride_length_minutes
FROM
  `inbound-obelisk-505302-s8.cyclistic_capstone.clean_trips`
GROUP BY
  member_casual
ORDER BY
  member_casual;
