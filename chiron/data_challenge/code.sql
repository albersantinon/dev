-- DATA CHALLENGE --
-- SVOLGIMENTO --
-- ho installato PostgreSQL 16
-- una volta visti i dati ho capito che sono stati normalizzati
-- il file trips.csv e' la tabella dei fatti mentre le altre tabelle
-- sono lookups. creo le tabelle che andranno a contenere i dati dei csv
-- ho createo un nuovo database chiamato 'challenge' e uno schema chiamato 'trips'

CREATE TABLE TRIPS.POPULATION (

	CODE VARCHAR,
	POPULATION VARCHAR

)

-- ho creato una nuova cartella denominata data e l'ho spostata su tmp perche' ho avuto problemi
-- di accesso da parte dell'utente postsgresql e pgAdmin4, dava errore access denied quando tentavo
-- di usare il comando COPY quindi ho risolto in questo modo
-- poi ho proceduto a caricare il primo csv population
-- e con gli altri csv tenendo presente che travel mode ha come delimiter |
-- mentre urbanization level ha come delimiter ;

CREATE TABLE TRIPS.TRAVEL_MODE (

	CODE VARCHAR,
	MODE VARCHAR,
	DESCRIPTION VARCHAR

);

CREATE TABLE TRIPS.TRAVEL_MOTIVES (

	CODE VARCHAR,
	MOTIVE VARCHAR,
	DESCRIPTION VARCHAR

);

CREATE TABLE TRIPS.URBANIZATION_LEVEL (

	ROW_ID VARCHAR,
	PROVINCES VARCHAR,
	LEVEL_URBANIZATION VARCHAR,
	AREA VARCHAR
);

CREATE TABLE TRIPS.REGION (

	CODE VARCHAR,
	REGION VARCHAR,
	DESCRIPTION VARCHAR

);

CREATE TABLE TRIPS.TRIPS (

	ROW_ID VARCHAR,
	TRAVEL_MOTIVES VARCHAR,
	POPULATION VARCHAR,
	TRAVEL_MODE VARCHAR,
	REGION_CHARACTERISTICS VARCHAR,
	PERIODS VARCHAR,
	TRIP_IN_A_YEAR VARCHAR,
	KM_TRAVELLED_IN_A_YEAR VARCHAR,
	HOURS_TRAVELLED_IN_A_YEAR VARCHAR,
	USER_ID VARCHAR
);

COPY TRIPS.POPULATION FROM '/tmp/data/population.csv' WITH CSV HEADER DELIMITER ',';
COPY TRIPS.REGION FROM '/tmp/data/region.csv' WITH CSV HEADER DELIMITER ',';
COPY TRIPS.TRAVEL_MODE FROM '/tmp/data/travel_mode.csv' WITH CSV HEADER DELIMITER '|';
COPY TRIPS.TRAVEL_MOTIVES FROM '/tmp/data/travel_motives.csv' WITH CSV HEADER DELIMITER ',';
COPY TRIPS.TRIPS FROM '/tmp/data/trips.csv' WITH CSV HEADER DELIMITER ',';
COPY TRIPS.URBANIZATION_LEVEL FROM '/tmp/data/urbanization_level.csv' WITH CSV HEADER DELIMITER ';';


--
-- FIRST ANSWER
--

with base as (
SELECT tr.*, tm.motive, td.mode, ul.level_urbanization, substring(periods,1,4) as years
FROM trips.trips tr
join trips.travel_motives tm on (tr.travel_motives = tm.code)
join trips.travel_mode td on (tr.travel_mode = td.code)
join trips.region re on (tr.region_characteristics = re.code)
join trips.urbanization_level ul on (re.region = ul.provinces)
where motive like '%groceries%')

select years, mode, level_urbanization, count(*)
from base
group by mode, level_urbanization, years
order by 1,4



