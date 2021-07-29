DROP DATABASE IF EXISTS testing_system_assignment_1;
CREATE DATABASE testing_system_assignment_1;
USE testing_system_assignment_1;

DROP TABLE IF EXISTS department;
CREATE TABLE department(
	department_id			INT,
	department_name			VARCHAR(50)
);

DROP TABLE IF EXISTS `position`;
CREATE TABLE `position`(
	positionid 				INT,
    position_name 			VARCHAR(50)
);

DROP TABLE IF EXISTS `account`;
CREATE TABLE `account`(
	account_id				INT,
    email					VARCHAR(50),
    user_name				VARCHAR(50),
    full_name				VARCHAR(50),
    department_id			INT,
    position_id				INT,
    create_date				DATE
);

DROP TABLE IF EXISTS `group`;
CREATE TABLE `group`(
	group_id 				INT,
    group_name 				VARCHAR(50),
    creator_id 				INT,
    create_date 			VARCHAR(50)
);

DROP TABLE IF EXISTS group_account;
CREATE TABLE group_account(
	group_id 				INT,
    account_id 				INT,
    join_date 				DATE
);

DROP TABLE IF EXISTS type_question;
CREATE TABLE type_question(
	type_id 				INT,
    type_name 				VARCHAR(50)
);

DROP TABLE IF EXISTS category_question;
CREATE TABLE category_question(
	category_id 			INT,
    category_name 			VARCHAR(50)
);

DROP TABLE IF EXISTS question;
CREATE TABLE question(
	question_id 			INT,
    content 				VARCHAR(50),
    category_id 			VARCHAR(50),
    type_id 				INT,
    creator_id 				INT,
    create_date 			DATE
);

DROP TABLE IF EXISTS answer;
CREATE TABLE answer(
	answer_id 				INT,
    content 				VARCHAR(50),
    question_id 			INT,
    is_correct 				BIT
);

DROP TABLE IF EXISTS exam;
 CREATE TABLE exam(
	exam_id 				INT,
    `code` 					INT,
    title 					VARCHAR(50),
    category_id 			INT,
    duration 				INT,
    creator_id 				INT,
    create_date 			DATE
);

DROP TABLE IF EXISTS exam_question;
CREATE TABLE exam_question(
	exam_id 				INT,
    question_id 			INT
);
