DROP DATABASE IF EXISTS extra_assignments_2;
CREATE DATABASE extra_assignments_2;
USE extra_assignments_2;

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
    evaluation_notes	VARCHAR(50),
    vti_account			VARCHAR(50) 	NOT NULL	UNIQUE
);

DROP TABLE IF EXISTS Exercise2;
CREATE TABLE Exercise2(
	id					INT 			AUTO_INCREMENT 		PRIMARY KEY,
    `name`				VARCHAR(50),
    `code`				CHAR(5)			UNIQUE 				NOT NULL,
    modified_date		DATETIME 		DEFAULT NOW()
);

DROP TABLE IF EXISTS Exercise3;
CREATE TABLE Exercise3(
	id					INT 			AUTO_INCREMENT 		PRIMARY KEY,
    `name`				VARCHAR(50)		NOT NULL,
    birth_date			DATE			NOT NULL,
    gender				TINYINT,
    is_deleted_flag		BIT
);