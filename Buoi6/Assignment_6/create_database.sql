DROP DATABASE IF EXISTS Management_Project;
CREATE DATABASE Management_Project;
USE Management_Project;

DROP TABLE IF EXISTS Project_Modules;
CREATE TABLE Project_Modules(
	module_id						TINYINT		UNSIGNED	AUTO_INCREMENT 	NOT NULL 	PRIMARY KEY,
    project_id 						TINYINT 	UNSIGNED 	NOT NULL,
    employee_id 					TINYINT		UNSIGNED	NOT NULL,
    project_modules_date			DATETIME,
    project_modules_compled_on		DATETIME,
    project_modules_description		VARCHAR(200)
);

DROP TABLE IF EXISTS 