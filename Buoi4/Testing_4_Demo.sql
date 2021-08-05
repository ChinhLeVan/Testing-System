-- Exercise 1: JOIN
USE testing_system;

-- Question 1: Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ =====================================
SELECT * FROM testing_system.account;
SELECT acc.full_name, dp.department_name
FROM testing_system.account AS acc 	
INNER JOIN testing_system.department AS dp
ON acc.department_id = dp.department_id;

-- Question 2: Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010 ===================================
SELECT email, use_name, full_name, department_name, position_name, create_date
FROM
	(SELECT email, use_name, full_name, department_name, position_id, create_date
	FROM testing_system.account
    INNER JOIN testing_system.department 
	ON account.department_id = department.department_id
    WHERE create_date > '2010/12/20')AS join_table
INNER JOIN testing_system.position
ON join_table.position_id = position.position_id;

-- Cách 2
SELECT a.email, a.use_name, a.full_name, d.department_name, p.position_name, a.create_date
FROM `account` a
INNER JOIN department d ON a.department_id = d.department_id
INNER JOIN position p ON a.position_id = p.position_id
WHERE create_date > '2010/12/20';

-- Question 3: Viết lệnh để lấy ra tất cả các developer =========================================================
-- Cách 1: tù
SELECT email, use_name, full_name, department_name, position_name, create_date
FROM
	(SELECT email, use_name, full_name, department_name, position_id, create_date
	FROM testing_system.account
    INNER JOIN testing_system.department 
	ON account.department_id = department.department_id)AS join_table
INNER JOIN testing_system.position
ON join_table.position_id = position.position_id
WHERE position_name = 'Dev';

-- Cách 2 hịn
SELECT a.email, a.use_name, a.full_name, d.department_name, p.position_name, a.create_date
FROM `account` a
INNER JOIN department d ON a.department_id = d.department_id
INNER JOIN position p ON a.position_id = p.position_id
WHERE p.position_name = 'Dev';

-- Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >=3 nhân viên========================================
SELECT a.email, a.use_name, a.full_name, d.department_name, a.create_date , COUNT(a.department_id) SoLuongNV
FROM `account` a
INNER JOIN department d
ON a.department_id = d.department_id
GROUP BY a.department_id
HAVING COUNT(a.department_id) >= '3';

-- Question 5: Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất
SELECT q_table.question_id, content, count_q
FROM(
	SELECT * ,COUNT(question_id) as count_q
	FROM exam_question e
	GROUP BY e.question_id) AS q_table
INNER JOIN question q ON q_table.question_id = q.question_id
WHERE count_q = (SELECT MAX(count_q)
							FROM(SELECT COUNT(question_id) as count_q
								FROM exam_question e
								GROUP BY e.question_id)AS T);

-- Question 6: Thông kê mỗi category Question được sử dụng trong bao nhiêu Question
SELECT category_name, COUNT(category_id) AS number_appear FROM(
SELECT question.category_id, category_name FROM question
INNER JOIN category_question
ON	question.category_id = category_question.category_id) AS map_table
GROUP BY category_id;


-- Question 7: Thông kê mỗi Question được sử dụng trong bao nhiêu Exam
SELECT content, exam_appear
FROM(
	SELECT question_id, COUNT(question_id) AS exam_appear
	FROM testing_system.exam_question
	GROUP BY question_id) AS seven_table
INNER JOIN question
ON question.question_id = seven_table.question_id;


-- Question 8: Lấy ra Question có nhiều câu trả lời nhất
SELECT content,	MAX(answer_appear) AS answer_appear
FROM(
	SELECT question_id, COUNT(question_id) AS answer_appear FROM testing_system.answer
	GROUP BY question_id) AS eight_tabe
INNER JOIN question ON eight_tabe.question_id = question.question_id;


-- Question 9: Thống kê số lượng account trong mỗi group 
SELECT group_name, group_appear AS account_number
FROM(
	SELECT group_id, COUNT(group_id) AS group_appear FROM testing_system.group_account
	GROUP BY group_id) AS nine_table
INNER JOIN testing_system.group AS tsg
ON nine_table.group_id = tsg.group_id;


-- Question 10: Tìm chức vụ có ít người nhất
SELECT position.position_name, COUNT(ac.position_id) AS number_workers
	FROM testing_system.account AS ac
    INNER JOIN position ON position.position_id = ac.position_id
	GROUP BY ac.position_id
    HAVING number_workers = (
								SELECT MIN(count_position)
								FROM(
									SELECT position_id, COUNT(position_id) AS count_position
									FROM testing_system.account
									GROUP BY position_id) AS ten_table);


-- Question 11: Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM
SELECT ac.department_id, department_name, position_name, COUNT(ac.position_id)
FROM testing_system.account AS ac
INNER JOIN department ON ac.department_id = department.department_id
INNER JOIN position ON  ac.position_id = position.position_id
GROUP BY ac.department_id, position.position_id;


-- Question 12: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, …
SELECT content, category_name, type_name, use_name AS use_name_creator, full_name AS full_name_creator
FROM(
	SELECT content, category_name, type_name, creator_id
	FROM
		(SELECT question.content, category_name, type_id, question.creator_id
		FROM testing_system.question
		INNER JOIN category_question ON question.category_id = category_question.category_id) AS table_have_categoty
	INNER JOIN type_question ON type_question.type_id = table_have_categoty.type_id) AS table_two
INNER JOIN testing_system.account ON table_two.creator_id = testing_system.account.account_id;
-- CHƯA XONG


-- Question 13: Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm
SELECT question.type_id, type_name,  COUNT(question.type_id) AS SL
FROM testing_system.question
INNER JOIN type_question 
ON question.type_id = type_question.type_id
GROUP BY question.type_id;


-- Question 14: Lấy ra group không có account nào===================================================================
SELECT group_name AS group_dont_have_acc
FROM group_account g_a
RIGHT JOIN `group`  g
ON g_a.group_id = g.group_id
WHERE g_a.group_id IS NULL;
-- Cách 2
SELECT group_name AS group_dont_have_acc
FROM `group` g
WHERE g.group_id NOT IN (SELECT group_id
								FROM group_account);
                                
-- Question 15: Lấy ra account không có group nào====================================================================
SELECT use_name AS acc_dont_have_group
FROM `account` a
WHERE a.account_id NOT IN (SELECT account_id
								FROM group_account);

-- Question 16: Lấy ra question không có answer nào===================================================================
-- Cách 1
SELECT q.content AS question_dont_have_answer
FROM question q
LEFT JOIN answer a
ON q.question_id = a.question_id
WHERE a.question_id IS NULL;
-- Cách 2
SELECT content AS question_dont_have_answer
FROM question q
WHERE q.question_id NOT IN (SELECT question_id
							FROM answer);

-- Question thêm....: lấy ra thông tin group có acc và in ra thông tin acc và group đó.
SELECT a.use_name, g.group_name
FROM group_account g_a
RIGHT JOIN `group` g ON g_a.group_id = g.group_id
JOIN `account` a	 ON a.account_id = g_a.account_id;


-- ==========================================================================================================================
--                                                   Exercise 2: UNION
-- ==========================================================================================================================
-- Question 17: 
-- a) Lấy các account thuộc nhóm thứ 1
SELECT *
FROM `account`
WHERE department_id = 1;

-- b) Lấy các account thuộc nhóm thứ 2
SELECT *
FROM `account`
WHERE department_id = 2;

-- c) Ghép 2 kết quả từ câu a) và câu b) sao cho không có record nào trùng nhau
SELECT *
FROM `account`
WHERE department_id = 1
UNION
SELECT *
FROM `account`
WHERE department_id = 2;

-- Question 18: =============================================================================================================
-- a) Lấy các group có lớn hơn hoặc bằng 3 thành viên
SELECT *
FROM `group`
WHERE group_id IN (SELECT table_t.group_id
							FROM(SELECT group_id, COUNT(group_id) AS SO_LUONG
							FROM group_account
							GROUP BY group_id
							HAVING SO_LUONG >= '3') AS table_t);
                            
-- b) Lấy các group có nhỏ hơn 5 thành viên
SELECT *
FROM `group`
WHERE group_id IN (SELECT table_t.group_id
							FROM(SELECT group_id, COUNT(group_id) AS SO_LUONG
							FROM group_account
							GROUP BY group_id
							HAVING SO_LUONG < '5') AS table_t);
                            
-- c) Ghép 2 kết quả từ câu a) và câu b
SELECT *
FROM `group`
WHERE group_id IN (SELECT table_t.group_id
							FROM(SELECT group_id, COUNT(group_id) AS SO_LUONG
							FROM group_account
							GROUP BY group_id
							HAVING SO_LUONG >= '3') AS table_t)
UNION
SELECT *
FROM `group`
WHERE group_id IN (SELECT table_t.group_id
							FROM(SELECT group_id, COUNT(group_id) AS SO_LUONG
							FROM group_account
							GROUP BY group_id
							HAVING SO_LUONG < '5') AS table_t);

-- Question 18: 
-- cach 2 -- a) Lấy các group có lớn hơn hoặc bằng 3 thành viên
SELECT g.group_id, g.group_name, g.creator_id, g.create_date, COUNT(g.group_id) AS SO_LUONG
FROM group_account ga
JOIN `group` g ON g.group_id = ga.group_id
GROUP BY g.group_id
HAVING SO_LUONG >= '3';

-- b) Lấy các group có nhỏ hơn 5 thành viên
SELECT g.group_id, g.group_name, g.creator_id, g.create_date, COUNT(g.group_id) AS SO_LUONG
FROM group_account ga
JOIN `group` g ON g.group_id = ga.group_id
GROUP BY g.group_id
HAVING SO_LUONG < '5';

-- c) Ghép 2 kết quả từ câu a) và câu b
SELECT g.group_id, g.group_name, g.creator_id, g.create_date, COUNT(g.group_id) AS SO_LUONG
FROM group_account ga
JOIN `group` g ON g.group_id = ga.group_id
GROUP BY g.group_id
HAVING SO_LUONG >= '3'
UNION
SELECT g.group_id, g.group_name, g.creator_id, g.create_date, COUNT(g.group_id) AS SO_LUONG
FROM group_account ga
JOIN `group` g ON g.group_id = ga.group_id
GROUP BY g.group_id
HAVING SO_LUONG < '5';