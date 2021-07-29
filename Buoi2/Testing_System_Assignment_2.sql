DROP DATABASE IF EXISTS testing_system;
CREATE DATABASE testing_system;
USE testing_system;

------------------------------------------------------------------------
-- -------------------- create table department----------------------------
DROP TABLE IF EXISTS department;
CREATE TABLE department (
    department_id 			TINYINT UNSIGNED 		PRIMARY KEY		AUTO_INCREMENT,
    department_name 		VARCHAR(50) 			UNIQUE KEY
);

------------------------------------------------------------------------
-- --------------------- CREATE TABLE position -------------------------
DROP TABLE IF EXISTS `position`;
CREATE TABLE `position`(
	position_id 			TINYINT UNSIGNED 		PRIMARY KEY		AUTO_INCREMENT,
    position_name 			ENUM("Dev", "Test", "Scrum Master", "PM")
);

------------------------------------------------------------------------
-- ----------------------create table account --------------------------
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account` (
	account_id 				INT UNSIGNED 			PRIMARY KEY 	AUTO_INCREMENT,
	email 					VARCHAR(50) 			UNIQUE KEY 		CHECK (length(email) > 6),
	use_name 				VARCHAR(50) 			UNIQUE KEY		CHECK (length(use_name) > 5),
	full_name 				VARCHAR(50) 			CHECK (length(full_name) > 10),
	department_id 			TINYINT UNSIGNED,
	position_id 			TINYINT UNSIGNED,
	create_date 			DATE,
    FOREIGN KEY (department_id) REFERENCES department(department_id),
    FOREIGN KEY (position_id) 	REFERENCES `position`(position_id)
);

-- --------------------------------------------------------------------
-- --------------------create table group -----------------------------
DROP TABLE IF EXISTS `group`;
CREATE TABLE `group`(
	group_id 				TINYINT UNSIGNED	AUTO_INCREMENT,
    group_name 				VARCHAR(50),
    creator_id 				INT	UNSIGNED		NOT NULL,
    create_date 			VARCHAR(50),
    PRIMARY KEY 			(group_id),
    FOREIGN KEY 			(creator_id) 		REFERENCES `account`(account_id)
);

-- --------------------------------------------------------------------
-- ---------------------create table group_account---------------------
DROP TABLE IF EXISTS group_account;
CREATE TABLE group_account(
	group_account_id 		TINYINT UNSIGNED	AUTO_INCREMENT,
	group_id 				TINYINT UNSIGNED,
    account_id 				INT UNSIGNED		NOT NULL,
    join_date 				DATE,
    PRIMARY KEY 			(group_account_id),
    FOREIGN KEY 			(group_id) 			REFERENCES `group`(group_id),
    FOREIGN KEY				(account_id) 		REFERENCES `account`(account_id)
);

-- ---------------------------------------------------------------------
-- ---------------------- create table type_question -------------------
DROP TABLE IF EXISTS type_question;
CREATE TABLE type_question(
	type_id 				TINYINT UNSIGNED		AUTO_INCREMENT,
    type_name 				ENUM ('Essay', 'Multiple-Choice') NOT NULL,
    PRIMARY KEY 			(type_id),
    UNIQUE KEY 				(type_name)
);

-- ---------------------------------------------------------------------
-- ---------------------- create table category_question ---------------
DROP TABLE IF EXISTS category_question;
CREATE TABLE category_question(
	category_id 			SMALLINT UNSIGNED	AUTO_INCREMENT,
    category_name 			VARCHAR(50),
    PRIMARY KEY 			(category_id)
);

-- ---------------------------------------------------------------------
-- ---------------------- create table question ------------------------
DROP TABLE IF EXISTS question;
CREATE TABLE question(
	question_id 			INT	UNSIGNED		AUTO_INCREMENT,
    content 				VARCHAR(500),
    category_id 			SMALLINT UNSIGNED,
    type_id 				TINYINT	UNSIGNED,
    creator_id 				INT	UNSIGNED,
    create_date 			DATE,
    PRIMARY KEY				(question_id),
    FOREIGN KEY				(category_id) 		REFERENCES category_question(category_id),
    FOREIGN KEY				(type_id) 			REFERENCES type_question(type_id),
    FOREIGN KEY				(creator_id) 		REFERENCES `account`(account_id)
);

-- ---------------------------------------------------------------------
-- ---------------------- create table answer ------------------------
DROP TABLE IF EXISTS answer;
CREATE TABLE answer(
	answer_id 				INT	UNSIGNED		AUTO_INCREMENT,
    content 				VARCHAR(50),
    question_id 			INT	UNSIGNED,
    is_correct 				BIT,
    PRIMARY KEY				(answer_id),
    FOREIGN KEY				(question_id) 		REFERENCES question(question_id)
);

-- ---------------------------------------------------------------------
-- ---------------------- create table exam ------------------------
DROP TABLE IF EXISTS exam;
 CREATE TABLE exam(
	exam_id 				INT UNSIGNED 		AUTO_INCREMENT,
    `code` 					VARCHAR(50),
    title 					VARCHAR(50),
    category_id 			SMALLINT UNSIGNED,
    duration 				INT UNSIGNED		CHECK(duration > 0),
    creator_id 				INT UNSIGNED		NOT NULL,
    create_date 			DATE,
    PRIMARY KEY 			(exam_id),
	FOREIGN KEY				(category_id) 		REFERENCES question(category_id),
    FOREIGN KEY				(creator_id) 		REFERENCES `account`(account_id)
);

-- ---------------------------------------------------------------------
-- ---------------------- create table exam_question ------------------------
DROP TABLE IF EXISTS exam_question;
CREATE TABLE exam_question(
	exam_id 				INT	UNSIGNED		PRIMARY KEY,
    question_id 			INT UNSIGNED,
    FOREIGN KEY 			(question_id) 		REFERENCES question(question_id)
);