
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
	  ON s.neighborhood = n.neighborhood;
	  
-- update most of the neighborhood incomes
    WITH nIncome
	  AS
	   (
		  SELECT n.neighborhood_id,
				 s.median_income
			FROM neighborhood n INNER JOIN neighborhood_income_staging s
			  ON n.neighborhood = UPPER(s.neighborhood)
	   )
  UPDATE neighborhood
     SET median_income = ni.median_income
    FROM nIncome ni
   WHERE neighborhood.neighborhood_id = ni.neighborhood_id;
   
  --hard code the few that don't match	  
  UPDATE neighborhood SET median_income = 755 WHERE neighborhood = 'ANTÔNIO HONÓRIO';
  UPDATE neighborhood SET median_income = 1500 WHERE neighborhood = 'JARDIM CAMBURI';
  UPDATE neighborhood SET median_income = 510 WHERE neighborhood = 'JOANA D´ARC';
  UPDATE neighborhood SET median_income = 1100 WHERE neighborhood = 'MORADA DE CAMBURI';
  UPDATE neighborhood SET median_income = 800 WHERE neighborhood = 'PONTAL DE CAMBURI';
  UPDATE neighborhood SET median_income = 510 WHERE neighborhood = 'SÃO CRISTÓVÃO';
  

	