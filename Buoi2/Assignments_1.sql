DROP DATABASE IF EXISTS Fresher_Training_Management;
CREATE DATABASE Fresher_Training_Management;
USE Fresher_Training_Management;

DROP TABLE IF EXISTS Trainee;
CREATE TABLE Trainee(
	id					INT,
    full_name			VARCHAR(50),
    birth_date			DATE,
    gender				ENUM("male", "female", "unknown"),
    et_iq				TINYINT,
    et_gmath			TINYINT,
    et_english			TINYINT,
    training_class		VARCHAR(50),
    evaluation_notes	VARCHAR(50)
);