-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/c2usl1
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

-- drop tables if they exist
DROP TABLE IF EXISTS staging_table;



DROP TABLE IF EXISTS neighborhood;

-- create the tables

-- staging table to store the raw data
CREATE TABLE "staging_table" (
    "patient_id" bigint   NOT NULL,
    "appointment_id" int   NULL,
	"gender" varchar NULL,
    "scheduled_day" date   NULL,
    "appointment_day" date   NULL,
    "patient_age" int   NULL,
    "neighborhood" varchar   NULL,
    "scholarship" int   NULL,
    "hypertension" int   NULL,
    "diabetes" int   NULL,
    "alcoholism" int   NULL,
    "handicap" int   NULL,
	"sms_received" int NULL,
    "no_show" varchar   NULL
);

-- neighborhood table to store the 
CREATE TABLE "neighborhood" (
    "neighborhood_id" SERIAL PRIMARY KEY,
    "neighborhood" varchar   NOT NULL,
    "longitude" float   NULL,
    "latitude" float   NULL
);
