# medical_no_shows
## by Kasie Wong
### Assisted by Michael Dowlin
## 3/24/20

### Description

### Steps to Create Environment
|Step # |Step Description                                                                                   |
|-------|---------------------------------------------------------------------------------------------------|
|1.     |Clone the repository to your computer.                                                             |
|2.     |Start a session of PostgresSQL administrator                                                       |
|3.     |Create a database called "medical_no_show_db"                                                               |
|4.     |Run the sql script "medical_no_show_table_definitions.sql", this will create all of the tables, keys/indexes.|
|5.     |Make sure you have a googlemaps api key in a file called "config.py".  The file should have a variable called "gkey", set your key there| 
|6.     |Run the notebook "import_data.ipynb", this will load the data, geocode it, and load it into SQL |
|7.     |(more to come)|

### Images
!['ERD Image not available'](images/medical_no_show_db_ERD.png)\
*Database (medical_no_show_db) ERD*

### Contents
| File                        | Description                                                                                     |
|-----------------------------|-------------------------------------------------------------------------------------------------|
|data\rawData\Brasil_medical_noshow_V2-May-2016.csv|The raw data file|
|notebooks\cleanMedicalNoShows.ipynb|Cleaning the data|
|notebooks\import_data.ipynb|Geocodes the neighborhoods and loads them into PostgreSQL|
|sql\medical_no_show_table_definitions.sql|Script to create the tables in PostgreSQL|
