
--  TRUNCATE TABLE staging_data
-- TRUNCATE TABLE neighborhood

-- load the neighborhood table
  INSERT INTO neighborhood
  		(neighborhood)
  SELECT neighborhood
    FROM staging_data
GROUP BY neighborhood
ORDER BY neighborhood;

-- load appointment table
  INSERT INTO appointments
  SELECT s.appointment_id,
  		 s.patient_id,
		 s.gender,
		 s.scheduled_day,
		 s.appointment_day,
		 s.age,
		 n.neighborhood_id,
		 s.welfare_assistance,
		 s.hypertension,
		 s.diabetes,
		 s.alcoholism,
		 s.handicap,
		 s.no_show
    FROM staging_data s LEFT OUTER JOIN appointments apt
	  ON s.appointment_id = apt.appointment_id INNER JOIN neighborhood n
	  ON s.neighborhood = n.neighborhood
	  
	  
  

	