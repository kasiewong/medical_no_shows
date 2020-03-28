-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/c2usl1
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

-- drop tables if they exist
DROP TABLE IF EXISTS staging_table;


DROP TABLE IF EXISTS appointments;
DROP TABLE IF EXISTS neighborhood;

-- create the tables

-- staging table to store the raw data
CREATE TABLE "staging_table" (
    "PatientID" bigint   NOT NULL,
    "AppointmentID" int   NULL,
	"Gender" varchar NULL,
    "ScheduledDay" date   NULL,
    "AppointmentDay" date   NULL,
    "Age" int   NULL,
    "Neighborhood" varchar   NULL,
    "WelfareAssistance" int   NULL,
    "Hypertension" int   NULL,
    "Diabetes" int   NULL,
    "Alcoholism" int   NULL,
    "Handicap" int   NULL,
	"SMS_received" int NULL,
    "No-show" varchar   NULL,
	"AppointmentDayofWeek" varchar NULL,
	"AdvanceBookingDays" int NULL,
	"SameDayAppt" int null
);

-- neighborhood table to store the 
CREATE TABLE "neighborhood" (
    "NeighborhoodID" SERIAL PRIMARY KEY,
    "Neighborhood" varchar   NOT NULL,
    "Longitude" float   NULL,
    "Latitude" float   NULL
);

-- appointment table
CREATE TABLE "appointments" (
    "AppointmentID" int   NOT NULL,
    "PatientID" bigint   NOT NULL,
	"Gender" varchar NULL,	
    "ScheduledDay" date   NULL,
    "AppointmentDay" date   NULL,
    "Age" int   NULL,
    "NeighborhoodID" int   NULL,
    "WelfareAssistance" int   NULL,
    "Hypertension" int   NULL,
    "Diabetes" int   NULL,
    "Alcoholism" int   NULL,
    "Handicap" int   NULL,
    "No-show" varchar   NULL,
    CONSTRAINT "pk_appointments" PRIMARY KEY (
        "AppointmentID"
     )
);

ALTER TABLE "appointments" ADD CONSTRAINT "fk_appointments_NeighborhoodID" FOREIGN KEY("NeighborhoodID")
REFERENCES "neighborhood" ("NeighborhoodID");

