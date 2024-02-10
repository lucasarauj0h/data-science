CREATE TABLE cap07.covid_mortes (
  `iso_code` text,
  `continent` text,
  `location` text,
  `date` text,
  `population` text,
  `total_cases` text,
  `new_cases` text,
  `new_cases_smoothed` text,
  `total_deaths` text,
  `new_deaths` text,
  `new_deaths_smoothed` text,
  `total_cases_per_million` text,
  `new_cases_per_million` text,
  `new_cases_smoothed_per_million` text,
  `total_deaths_per_million` text,
  `new_deaths_per_million` text,
  `new_deaths_smoothed_per_million` text,
  `reproduction_rate` text,
  `icu_patients` text,
  `icu_patients_per_million` text,
  `hosp_patients` text,
  `hosp_patients_per_million` text,
  `weekly_icu_admissions` text,
  `weekly_icu_admissions_per_million` text,
  `weekly_hosp_admissions` text,
  `weekly_hosp_admissions_per_million` text
);


CREATE TABLE cap07.covid_vacinacao (
  `iso_code` text,
  `continent` text,
  `location` text,
  `date` text,
  `new_tests` text,
  `total_tests` text,
  `total_tests_per_thousand` text,
  `new_tests_per_thousand` text,
  `new_tests_smoothed` text,
  `new_tests_smoothed_per_thousand` text,
  `positive_rate` text,
  `tests_per_case` text,
  `tests_units` text,
  `total_vaccinations` text,
  `people_vaccinated` text,
  `people_fully_vaccinated` text,
  `new_vaccinations` text,
  `new_vaccinations_smoothed` text,
  `total_vaccinations_per_hundred` text,
  `people_vaccinated_per_hundred` text,
  `people_fully_vaccinated_per_hundred` text,
  `new_vaccinations_smoothed_per_million` text,
  `stringency_index` text,
  `population_density` text,
  `median_age` text,
  `aged_65_older` text,
  `aged_70_older` text,
  `gdp_per_capita` text,
  `extreme_poverty` text,
  `cardiovasc_death_rate` text,
  `diabetes_prevalence` text,
  `female_smokers` text,
  `male_smokers` text,
  `handwashing_facilities` text,
  `hospital_beds_per_thousand` text,
  `life_expectancy` text,
  `human_development_index` text,
  `excess_mortality` text
);


# Conecte no MySQL via linha de comando (Mac ou Linux)
/usr/local/mysql/bin/mysql --local-infile=1 -u root -p

# Conecte no MySQL via linha de comando (Windows)
Acesse no prompt de comando: cd C:\Program Files\MySQL\MySQL Server 8.0\bin
# E execute:
mysql.exe --local-infile=1 -u root -p

# Execute:
SET GLOBAL local_infile = true;

# Carrega os dados
LOAD DATA LOCAL INFILE '/Users/dmpm/Dropbox/DSA/SQL-Para-Data-Science/Cap07/EstudoCaso1/covid_mortes.csv' INTO TABLE `cap07`.`covid_mortes` CHARACTER SET UTF8
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

LOAD DATA LOCAL INFILE '/Users/dmpm/Dropbox/DSA/SQL-Para-Data-Science/Cap07/EstudoCaso1/covid_vacinacao.csv' INTO TABLE `cap07`.`covid_vacinacao` CHARACTER SET UTF8
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;


