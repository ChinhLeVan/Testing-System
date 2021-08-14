USE testing_system;

/* Question 1: Tạo trigger không cho phép người dùng nhập vào Group có ngày tạo trước 1 năm trước */
BEGIN WORK;
DROP TRIGGER IF EXISTS trigger_create_time;
DELIMITER $$
	CREATE TRIGGER trigger_create_time
    BEFORE INSERT ON `group`
    FOR EACH ROW
    BEGIN
		IF NEW.`create_date` < DATE_SUB(NOW(), INTERVAL 1 YEAR) THEN
        SIGNAL SQLSTATE '12345'  -- disallow insert this record
        SET MESSAGE_TEXT = "field create_date must be less than now";
        END IF;
	END $$
DELIMITER ;

INSERT INTO `group`(group_name, creator_id, create_date) 
VALUES       ('group insert',		'5',	'2021-04-05');
SELECT * FROM `group`;
ROLLBACK;
COMMIT;

/* Question 2: Tạo trigger Không cho phép người dùng thêm bất kỳ user nào vào 
 department "Sale" nữa, khi thêm thì hiện ra thông báo "Department
 "Sale" cannot add more user" */
BEGIN WORK;
DROP TRIGGER IF EXISTS triggrt_create_user;
DELIMITER $$
	CREATE TRIGGER triggrt_create_user
    BEFORE INSERT ON `account`
    FOR EACH ROW
    BEGIN
		IF NEW.`department_id` = (SELECT department_id FROM `department` WHERE department_name = 'Sales') THEN
        SIGNAL SQLSTATE '12345'  -- disallow insert this record
        SET MESSAGE_TEXT = "Department Sale cannot add more user";
        END IF;
	END $$
DELIMITER ;

INSERT INTO `account`(email,						 use_name,				 full_name, 	department_id, position_id, create_date) 
VALUES				('accountnew@gmail.com',		'accountnew', 		'New account', 		'2', 			'1', 	'2021-03-05');
SELECT * FROM `account`;
ROLLBACK;
COMMIT;

/* Question 3: Cấu hình 1 group có nhiều nhất là 5 user */
BEGIN WORK;
DROP TRIGGER IF EXISTS triggrt_config_group;
DELIMITER $$
	CREATE TRIGGER triggrt_config_group
    BEFORE INSERT ON `group_account`
    FOR EACH ROW
    BEGIN
		IF 5 = (SELECT COUNT(group_id) 
							FROM `group_account` 
                            WHERE group_id = NEW.`group_id`
                            GROUP BY group_id) THEN
        SIGNAL SQLSTATE '12345'  -- disallow insert this record
        SET MESSAGE_TEXT = "This group cannot add more user";
        END IF;
	END $$
DELIMITER ;

INSERT INTO `group_account`(group_id, account_id) 
VALUES							('2',	'3');
SELECT * FROM `group_account`;
ROLLBACK;
COMMIT;

/* Question 4: Cấu hình 1 bài thi có nhiều nhất là 10 Question */
BEGIN WORK;
DROP TRIGGER IF EXISTS triggrt_config_exam;
DELIMITER $$
	CREATE TRIGGER triggrt_config_exam
    BEFORE INSERT ON `exam_question`
    FOR EACH ROW
    BEGIN
		IF 10 = (SELECT COUNT(exam_id) 
							FROM `exam_question` 
                            WHERE exam_id = NEW.`exam_id`
                            GROUP BY exam_id) THEN
        SIGNAL SQLSTATE '12345'  -- disallow insert this record
        SET MESSAGE_TEXT = "This exam cannot add more question";
        END IF;
	END $$
DELIMITER ;

INSERT INTO exam_question(exam_id, question_id) 
VALUES						('3',		'6');
SELECT * FROM `exam_question`;
ROLLBACK;
COMMIT;

/* Question 5: Tạo trigger không cho phép người dùng xóa tài khoản có email là 
 admin@gmail.com (đây là tài khoản admin, không cho phép user xóa), 
 còn lại các tài khoản khác thì sẽ cho phép xóa và sẽ xóa tất cả các thông 
 tin liên quan tới user đó */
 
 BEGIN WORK;
DROP TRIGGER IF EXISTS trigger_delete_acc;
DELIMITER $$
	CREATE TRIGGER trigger_delete_acc
    BEFORE DELETE ON `account`
    FOR EACH ROW
    BEGIN
		IF (SELECT email FROM `account` WHERE account_id = OLD.account_id) = 'admin@gmail.com' THEN 
        SIGNAL SQLSTATE '12345'  -- disallow insert this record
        SET MESSAGE_TEXT = "Đây là tài khoản admin, không cho phép user xóa";
        END IF;
	END $$
DELIMITER ;

DELETE FROM `account` WHERE account_id = '1';
SELECT * FROM `exam_question`;
ROLLBACK;
COMMIT;

/* Câu hỏi trên lớp:  Delete Question which has id = 6 (without using on delete cascade) */
DROP TRIGGER IF EXISTS trigger_delete_que;
DELIMITER $$
	CREATE TRIGGER trigger_delete_que
    BEFORE DELETE ON `question`
    FOR EACH ROW
    BEGIN
		DELETE FROM `answer`
        WHERE question_id = NEW.question_id;
        DELETE FROM exam_question
        WHERE question_id = NEW.question_id;
	END $$
DELIMITER ;
DELETE FROM `question`
WHERE question_id = '10';

/* Question 6: Không sử dụng cấu hình default cho field DepartmentID của table 
 Account, hãy tạo trigger cho phép người dùng khi tạo account không điền 
 vào departmentID thì sẽ được phân vào phòng ban "waiting Department" */
 
 
/* Question 12: Lấy ra thông tin exam trong đó:
Duration <= 30 thì sẽ đổi thành giá trị "Short time"
30 < Duration <= 60 thì sẽ đổi thành giá trị "Medium time"
Duration > 60 thì sẽ đổi thành giá trị "Long time" */

SELECT `code`, title, 	CASE
							WHEN duration <= 30 THEN "Short time"
                            WHEN duration <= 60 THEN "Medium time"
                            ELSE "Long time" 
						END AS Duration , create_date
FROM exam;
                            

