USE testing_system;

-- Question 1: Tạo store để người dùng nhập vào tên phòng ban và in ra tất cả các account thuộc phòng ban đó
DROP PROCEDURE IF EXISTS account_department;
DELIMITER $$
CREATE PROCEDURE account_department (IN indepartment_name VARCHAR(50) )
	BEGIN
		SELECT acc.account_id, acc.use_name, acc.email, acc.full_name
        FROM testing_system.account AS acc
        INNER JOIN department ON department.department_id = acc.department_id
        WHERE department.department_name = indepartment_name;
	END$$
DELIMITER ;


-- Question 2: Tạo store để in ra số lượng account trong mỗi group
DROP PROCEDURE IF EXISTS number_acc_of_group;
DELIMITER $$
CREATE PROCEDURE number_acc_of_group (IN name_group VARCHAR(50))
	BEGIN
		WITH count_group_id AS
							(SELECT group_id, COUNT(group_id) AS so_luong_acc
							FROM group_account
							GROUP BY group_id)
        SELECT gr.group_name, so_luong_acc
        FROM count_group_id
        INNER JOIN testing_system.group AS gr ON gr.group_id = count_group_id.group_id
        WHERE gr.group_name = name_group;
    END$$
DELIMITER ;
call testing_system.number_acc_of_group('Management');


-- Question 3: Tạo store để thống kê mỗi type question có bao nhiêu question được tạo trong tháng hiện tại
SELECT * FROM testing_system.question;

DROP PROCEDURE IF EXISTS q3_number_question_created_this_month;
DELIMITER $$
CREATE PROCEDURE q3_number_question_created_this_month(IN question_type_name VARCHAR(50))
	BEGIN
		SELECT qc.type_id, type_name, COUNT(qc.type_id) AS number_question, create_date
        FROM testing_system.question AS qc
        INNER JOIN type_question ON type_question.type_id = qc.type_id
        WHERE MONTH(create_date) = MONTH(CURRENT_DATE()) AND YEAR(create_date) = YEAR(CURRENT_DATE()) AND type_name = question_type_name
        GROUP BY qc.type_id;
    END$$
DELIMITER ;

CALL q3_number_question_created_this_month('Essay');

-- Question 4: Tạo store để trả ra id của type question có nhiều câu hỏi nhất
-- in ra type_question có nhiều câu hỏi nhất
DROP PROCEDURE IF EXISTS sp_get_count_ques_from_type;
DELIMITER $$
CREATE PROCEDURE sp_get_count_ques_from_type()
	BEGIN
		WITH CTE_count_type_id AS (
									SELECT type_id, COUNT(type_id) AS SL
									FROM question
									GROUP BY  type_id)
        SELECT type_name, max(SL) AS SL_max
        FROM CTE_count_type_id
        INNER JOIN type_question ON type_question.type_id = CTE_count_type_id.type_id;
    END$$
DELIMITER ;

-- Lam voi function
DROP FUNCTION IF EXISTS sp_get_count_ques_from_type;
SET GLOBAL log_bin_trust_function_creators = 1;
DELIMITER $$
CREATE FUNCTION sp_get_count_ques_from_type() RETURNS INT
	BEGIN
		DECLARE id_max_return INT;
		WITH CTE_count_type_id AS (
									SELECT type_id, COUNT(type_id) AS SL
									FROM question
									GROUP BY  type_id)
        SELECT type_id INTO id_max_return
        FROM CTE_count_type_id
        WHERE SL = (SELECT max(SL)
					FROM CTE_count_type_id);
        RETURN id_max_return;
    END$$
DELIMITER ;

SELECT sp_get_count_ques_from_type();

-- trả ra id của type question có nhiều câu hỏi nhất
DROP PROCEDURE IF EXISTS sp_get_idmax_count_ques_from_type;
DELIMITER $$
CREATE PROCEDURE sp_get_idmax_count_ques_from_type(OUT v_id INT)
	BEGIN
		WITH CTE_count_type_id AS (
									SELECT type_id, COUNT(type_id) AS SL
									FROM question
									GROUP BY  type_id)
        SELECT type_id INTO v_id
        FROM CTE_count_type_id
        WHERE SL = (SELECT MAX(SL) FROM CTE_count_type_id);
    END$$
DELIMITER ;
SET @id = 0;
Call sp_get_idmax_count_ques_from_type(@id);
SELECT @id AS idmax_count_ques_from_type;

-- Question 5: Sử dụng store ở question 4 để tìm ra tên của type question
SET @id = 0;
CALL sp_get_idmax_count_ques_from_type(@id);
SELECT *
FROM type_question
WHERE type_id = @id;

-- Question 6: Viết 1 store cho phép người dùng nhập vào 1 chuỗi và trả về group có tên chứa chuỗi của người dùng nhập vào hoặc trả về user có username chứa chuỗi của người dùng nhập vào
DROP PROCEDURE IF EXISTS sp_set_string_and_return_group_have_that;
DELIMITER $$
CREATE PROCEDURE sp_set_string_and_return_group_have_that(IN in_set_string VARCHAR(50))
	BEGIN
		SELECT group_name
        FROM testing_system.group
        WHERE group_name LIKE CONCAT("%",in_set_string,"%");
    END$$
DELIMITER ;

/* Question 7: Viết 1 store cho phép người dùng nhập vào thông tin fullName, email và trong store sẽ tự động gán:
username sẽ giống email nhưng bỏ phần @..mail đi
positionID: sẽ có default là developer
departmentID: sẽ được cho vào 1 phòng chờ
 Sau đó in ra kết quả tạo thành công */
 
 BEGIN WORK;
 DROP PROCEDURE IF EXISTS add_acc_with_fullname_mail;
 DELIMITER $$
 CREATE PROCEDURE add_acc_with_fullname_mail (IN fullname VARCHAR(50), IN email VARCHAR(50))
		BEGIN
			DECLARE use_name VARCHAR(50);
            SELECT SUBSTRING_INDEX(email, "@", 1) INTO use_name;
			INSERT INTO `account`(email, use_name,full_name, department_id, position_id) 
			VALUES		(email , use_name, fullname, 10, 1);
        END$$
DELIMITER ;
call testing_system.add_acc_with_fullname_mail('Lê Văn Chính', 'lechinh22920@gmail.com');
ROLLBACK;
COMMIT;

SELECT * FROM `account`;
 
-- Question 8: Viết 1 store cho phép người dùng nhập vào Essay hoặc Multiple-Choice để thống kê câu hỏi essay hoặc multiple-choice nào có content dài nhất
 BEGIN WORK;
 DROP FUNCTION IF EXISTS statistic_max_lenght_content;
 DELIMITER $$
 CREATE FUNCTION statistic_max_lenght_content(type_name VARCHAR(50)) RETURNS VARCHAR(50)
		BEGIN
			DECLARE content_max VARCHAR(50);
            WITH CTE_question AS ( SELECT q.content, tq.type_name, length(content) AS lc
									FROM `question` q
                                    JOIN `type_question` tq ON q.type_id = tq.type_id
                                    WHERE tq.type_name = type_name)
			SELECT `content` INTO content_max
            FROM `CTE_question`
            WHERE lc = (SELECT MAX(lc) FROM CTE_question);
			RETURN content_max;
        END$$
DELIMITER ;
ROLLBACK;
COMMIT;
SELECT statistic_max_lenght_content('Essay');
-- Question 9: Viết 1 store cho phép người dùng xóa exam dựa vào ID
 BEGIN WORK;
 DROP PROCEDURE IF EXISTS delete_exam_by_id;
 DELIMITER $$
 CREATE PROCEDURE delete_exam_by_id(IN id_input TINYINT)
		BEGIN
			DELETE FROM exam
            WHERE exam_id = id_input;
        END$$
DELIMITER ;
CALL delete_exam_by_id(3);
ROLLBACK;
COMMIT;


/*Question 10: Tìm ra các exam được tạo từ 3 năm trước và xóa các exam đó đi (sử 
 dụng store ở câu 9 để xóa)
 Sau đó in số lượng record đã remove từ các table liên quan trong khi 
 removing*/
 WITH
 CTE_exam_by_time AS (SELECT exam_id
					FROM `exam`
                    WHERE YEAR(create_date) = YEAR(NOW()) -3)
 SELECT * FROM CTE_exam_by_time;
 
/*Question 11: Viết store cho phép người dùng xóa phòng ban bằng cách người dùng 
 nhập vào tên phòng ban và các account thuộc phòng ban đó sẽ được 
 chuyển về phòng ban default là phòng ban chờ việc*/
 BEGIN WORK;
 DROP PROCEDURE IF EXISTS delete_department_by_name;
 DELIMITER $$
 CREATE PROCEDURE delete_department_by_name(IN d_name VARCHAR(50))
		BEGIN
			WITH
            CTE_find_dbn AS (SELECT department_id
							FROM `department`
							WHERE department_name = d_name
							)
			UPDATE `account`
            SET department_id = DEFAULT
            WHERE department_id = (SELECT department_id FROM CTE_find_dbn);
            DELETE FROM `department`
            WHERE department_name = d_name;
        END$$
DELIMITER ;
CALL delete_department_by_name('Sales');
ROLLBACK;
COMMIT;

 
-- Question 12: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong năm nay
BEGIN WORK;
 DROP PROCEDURE IF EXISTS print_num_q_create_this_y;
 DELIMITER $$
 CREATE PROCEDURE print_num_q_create_this_y()
		BEGIN
			SELECT *, COUNT(MONTH(create_date)) AS SL_Cau_Hoi
            FROM `question`
            WHERE YEAR(create_date) = YEAR(NOW())
            GROUP BY MONTH(create_date);
        END$$
DELIMITER ;
CALL print_num_q_create_this_y();
ROLLBACK;
COMMIT;

/*Question 13: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong 6 
 tháng gần đây nhất
 (Nếu tháng nào không có thì sẽ in ra là "không có câu hỏi nào trong tháng")*/

BEGIN WORK;
 DROP PROCEDURE IF EXISTS print_num_q_create_this_y;
 DELIMITER $$
 CREATE PROCEDURE print_num_q_create_this_y()
		BEGIN
		WITH CTE_list_six_month_before AS (
										SELECT MONTH(NOW()) AS MONTH, YEAR(NOW()) AS `Year`
                                        UNION
										SELECT MONTH(DATE_SUB(NOW(), INTERVAL 1 MONTH)) AS `Month`, YEAR(DATE_SUB(NOW(), INTERVAL 1 MONTH)) AS `Year`
										UNION
										SELECT MONTH(DATE_SUB(NOW(), INTERVAL 2 MONTH)) AS `Month`, YEAR(DATE_SUB(NOW(), INTERVAL 2 MONTH)) AS `Year`
										UNION
										SELECT MONTH(DATE_SUB(NOW(), INTERVAL 3 MONTH)) AS `Month`, YEAR(DATE_SUB(NOW(), INTERVAL 3 MONTH)) AS `Year`
										UNION
										SELECT MONTH(DATE_SUB(NOW(), INTERVAL 4 MONTH)) AS `Month`, YEAR(DATE_SUB(NOW(), INTERVAL 4 MONTH)) AS `Year`
										UNION
										SELECT MONTH(DATE_SUB(NOW(), INTERVAL 5 MONTH)) AS `Month`, YEAR(DATE_SUB(NOW(), INTERVAL 5 MONTH)) AS `Year`	
                                        UNION
										SELECT MONTH(DATE_SUB(NOW(), INTERVAL 6 MONTH)) AS `Month`, YEAR(DATE_SUB(NOW(), INTERVAL 6 MONTH)) AS `Year`
                                        UNION
										SELECT MONTH(DATE_SUB(NOW(), INTERVAL 7 MONTH)) AS `Month`, YEAR(DATE_SUB(NOW(), INTERVAL 7 MONTH)) AS `Year`
                                        UNION
										SELECT MONTH(DATE_SUB(NOW(), INTERVAL 8 MONTH)) AS `Month`, YEAR(DATE_SUB(NOW(), INTERVAL 8 MONTH)) AS `Year`
                                        UNION
										SELECT MONTH(DATE_SUB(NOW(), INTERVAL 9 MONTH)) AS `Month`, YEAR(DATE_SUB(NOW(), INTERVAL 9 MONTH)) AS `Year`
										),
			CTE_data_six_month_before AS (SELECT MONTH(create_date) AS `Month`,  YEAR(create_date) AS `Year`, COUNT(create_date) AS SL
											FROM `question`
											WHERE create_date > DATE_SUB(NOW(), INTERVAL 10 MONTH) AND create_date < NOW()
											GROUP BY MONTH(create_date))

			SELECT CTE_l.`Month`, CTE_l.`Year`, CASE WHEN CTE_D.SL IS NULL THEN 'không có câu hỏi nào trong tháng' 
                                                ELSE CTE_D.SL END AS SL_Cau_Hoi_Duoc_Tao
			FROM CTE_list_six_month_before CTE_l
			LEFT JOIN CTE_data_six_month_before CTE_D ON CTE_D.`Month` = CTE_l.`Month` AND  CTE_l.`Year` =  CTE_D.`Year`;
        END$$
DELIMITER ;
CALL print_num_q_create_this_y();
ROLLBACK;
COMMIT;


