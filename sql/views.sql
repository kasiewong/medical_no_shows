
DROP VIEW IF EXISTS medical_noshow_data;

/*

<511	1	56.10%
511-900	2	20.73%
>900	3	23.17%

*/

CREATE VIEW medical_noshow_data
AS 
  SELECT apt.appointment_id,
  		 apt.patient_id,
		 CASE WHEN apt.gender = 'M' THEN 1 ELSE 0 END AS gender_yn,
		 apt.scheduled_day,
		 apt.appointment_day,
		 apt.appointment_day - apt.scheduled_day AS time_between_sch_appt,
		 CASE WHEN apt.appointment_day - apt.scheduled_day = 0 THEN 1 ELSE 0 END AS same_day_appt_yn,
		 CASE WHEN apt.appointment_day - apt.scheduled_day > 0 AND apt.appointment_day - apt.scheduled_day <= 7 THEN 1 ELSE 0 END AS within_week_appt_yn,
		 CASE WHEN apt.appointment_day - apt.scheduled_day > 7 THEN 1 ELSE 0 END AS advanced_appt_yn,
		 -- income groups for neighborhood
		 CASE WHEN n.median_income <511 THEN 1 ELSE 0 END AS neighborhood_income_lower_yn,
		 CASE WHEN n.median_income >= 511 AND n.median_income <= 900 THEN 1 ELSE 0 END AS neighborhood_income_middle_yn,
		 CASE WHEN n.median_income >900 THEN 1 ELSE 0 END AS neigborhood_income_higher_yn,
		 -- if the appointment is for the day after a holiday, then mark 1
		 CASE WHEN h.holiday IS NOT NULL THEN 1 ELSE 0 END AS day_after_holiday_yn,
		 -- age bins here
		 CASE WHEN apt.age < 18 THEN 1 ELSE 0 END AS child_yn,
		 CASE WHEN apt.age >= 18 AND apt.age < 30 THEN 1 ELSE 0 END AS young_adult_yn,
		 CASE WHEN apt.age >= 30 AND apt.age < 60 THEN 1 ELSE 0 END AS adult_yn,
		 CASE WHEN apt.age >= 60 THEN 1 ELSE 0 END AS senior_yn,
		 apt.welfare_assistance,
		 apt.hypertension,
		 apt.diabetes,
		 apt.alcoholism,
		 --handicap bins here
		 CASE WHEN apt.handicap = 0 THEN 0 ELSE 1 END AS handicap_yn,
		 -- what we will be solving for
		 CASE WHEN no_show = 'Yes' THEN 1 ELSE 0 END AS no_show_yn
    FROM appointments apt LEFT OUTER JOIN holiday h
	  ON apt.appointment_day = h.holiday_date + 1 INNER JOIN neighborhood n
	  ON apt.neighborhood_id = n.neighborhood_id
	  
