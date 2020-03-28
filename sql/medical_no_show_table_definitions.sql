-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/c2usl1
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

-- drop tables if they exist
DROP TABLE IF EXISTS staging_data;


DROP TABLE IF EXISTS appointments;
DROP TABLE IF EXISTS neighborhood;

-- create the tables

-- creating holiday table
CREATE TABLE holiday (
	holiday_date date NOT NULL,
	holiday varchar,
	CONSTRAINT "pk_holiday" PRIMARY KEY (
        holiday_date
     )	
	);
	
-- load our 3 known holidays
INSERT INTO holiday VALUES
	('2016-05-01', 'May Day'),
	('2016-05-08', 'Mothers Day'),
	('2016-05-26', 'Chorpus Christi Day');

-- staging table to store the raw data
CREATE TABLE staging_data (
    patient_id bigint   NOT NULL,
    appointment_id int   NULL,
	gender varchar NULL,
    scheduled_day date   NULL,
    appointment_day date   NULL,
    age int   NULL,
    neighborhood varchar   NULL,
    welfare_assistance int   NULL,
    hypertension int   NULL,
    diabetes int NULL,
    alcoholism int NULL,
    handicap int   NULL,
	sms_received int NULL,
    no_show varchar NULL,
	appointment_day_of_week varchar NULL,
	advance_booking_days int NULL,
	same_day_appt int Null
);

-- neighborhood table to store the 
CREATE TABLE neighborhood (
    neighborhood_id SERIAL PRIMARY KEY,
    neighborhood varchar   NOT NULL,
    longitude float   NULL,
    latitude float   NULL
);

-- appointment table
CREATE TABLE appointments (
    appointment_id int   NOT NULL,
    patient_id bigint   NOT NULL,
	gender varchar NULL,	
    scheduled_day date   NULL,
    appointment_day date   NULL,
    age int   NULL,
    neighborhood_id int   NULL,
    welfare_assistance int   NULL,
    hypertension int   NULL,
    diabetes int   NULL,
    alcoholism int   NULL,
    handicap int   NULL,
    no_show varchar   NULL,
    CONSTRAINT "pk_appointments" PRIMARY KEY (
        appointment_id
     )
);

ALTER TABLE appointments ADD CONSTRAINT "fk_appointments_neighborhood_id" FOREIGN KEY(neighborhood_id)
REFERENCES neighborhood (neighborhood_id);

