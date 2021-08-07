DROP DATABASE IF EXISTS management_employee;
CREATE DATABASE management_employee;
USE management_employee;

DROP TABLE IF EXISTS department;
CREATE TABLE department(
	department_number		TINYINT 	UNSIGNED 	AUTO_INCREMENT 	PRIMARY KEY,
    department_name			VARCHAR(50) UNIQUE KEY 	NOT NULL
);

DROP TABLE IF EXISTS employee_table;
CREATE TABLE employee_table(
	employee_number			TINYINT 	UNSIGNED 	AUTO_INCREMENT 	PRIMARY KEY,
    employee_name			VARCHAR(50),
    department_number		TINYINT 	UNSIGNED 	NOT NULL,
    FOREIGN KEY (department_number) REFERENCES department (department_number)
);

DROP TABLE IF EXISTS employee_skill_table;
CREATE TABLE employee_skill_table(
	id						TINYINT 	UNSIGNED 	AUTO_INCREMENT 	PRIMARY KEY,
	employee_number			TINYINT 	UNSIGNED 	NOT NULL,
    skill_code				VARCHAR(50) NOT NULL,
    date_registered			DATETIME DEFAULT NOW(),
	FOREIGN KEY (employee_number) REFERENCES employee_table (employee_number)
);