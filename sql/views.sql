
DROP VIEW IF EXISTS medical_noshow_data;


CREATE VIEW medical_noshow_data
AS 
  SELECT apt.appointment_id,
  		 apt.patient_id,
		 CASE WHEN apt.gender = 'M' THEN 1 ELSE 0 END AS gender_yn,
		 apt.scheduled_day,
		 apt.appointment_day,
		 -- if the appointment is for the day after a holiday, then mark 1
		 CASE WHEN h.holiday IS NOT NULL THEN 1 ELSE 0 END AS day_after_holiday_yn,
		 -- age bins here
		 
		 -- welfare bins here
		 apt.hypertension,
		 apt.diabetes,
		 apt.alcoholism,
		 --handicap bins here
		 -- what we will be solving for
		 CASE WHEN no_show = 'Yes' THEN 1 ELSE 0 END AS no_show_yn
    FROM appointments apt LEFT OUTER JOIN holiday h
	  ON apt.appointment_day = h.holiday_date + 1
