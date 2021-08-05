USE testing_system;
-- ========== Exercise 1: Tiếp tục với Database Testing System (Sử dụng subquery hoặc CTE) ==========
-- ==================================================================================================
-- Question 1: Tạo view có chứa danh sách nhân viên thuộc phòng ban sale
DROP VIEW IF EXISTS Name_acc_of_sale;
CREATE VIEW Name_acc_of_sale AS
SELECT acc.account_id, email, use_name, full_name, department_name, position.position_name
FROM testing_system.account AS acc
INNER JOIN department ON acc.department_id = department.department_id
INNER JOIN position ON acc.position_id = position.position_id
WHERE department.department_name = 'Sales';

-- Question 2: Tạo view có chứa thông tin các account tham gia vào nhiều group nhất
CREATE OR REPLACE VIEW SL_group_tham_gia AS
WITH
group_join AS (SELECT COUNT(account_id) AS SL_group_tham_gia
				FROM group_account
				GROUP BY account_id),
max_group_join AS (SELECT MAX(SL_group_tham_gia) AS SL
					FROM group_join)
SELECT a.account_id, email, use_name, full_name, COUNT(ga.account_id)
FROM group_account ga
JOIN `account` a ON ga.account_id = a.account_id
GROUP BY ga.account_id
HAVING ga.account_id = (SELECT SL
						FROM max_group_join);

-- Question 3: Tạo view có chứa câu hỏi có những content quá dài (content quá 19 từ được coi là quá dài) và xóa nó đi
DROP VIEW IF EXISTS DANH_SACH_CAU_HOI_CO_CONTENT_DAI;
CREATE VIEW DANH_SACH_CAU_HOI_CO_CONTENT_DAI AS
SELECT *
FROM testing_system.question
WHERE length(content) > '19';
DELETE FROM question
WHERE question_id = (SELECT question_id FROM DANH_SACH_CAU_HOI_CO_CONTENT_DAI);

-- Question 4: Tạo view có chứa danh sách các phòng ban có nhiều nhân viên nhất
CREATE VIEW DS_PHONG_NHIEU_NHAN_VIEN AS
WITH 
sl_nhan_vien AS(
	SELECT department_id, COUNT(department_id) AS SL_NHAN_VIEN
	FROM `account`
	GROUP BY department_id),
max_slnv AS(
	SELECT MAX(SL_NHAN_VIEN) as max_count
	FROM sl_nhan_vien)
SELECT *, COUNT(department_id)
FROM `account`
GROUP BY department_id
HAVING COUNT(department_id) = ( SELECT max_count
								FROM max_slnv);
      
      
-- Question 5: Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo
DROP VIEW IF EXISTS USER_CREATED_BY_NGUYEN;
CREATE VIEW USER_CREATED_BY_NGUYEN AS
WITH
user_nguyen AS (SELECT account_id
				FROM testing_system.account
				WHERE full_name LIKE 'Nguyễn%')
                
SELECT content, full_name AS creator, question.create_date
FROM testing_system.question
INNER JOIN testing_system.account AS acc
ON question.creator_id = acc.account_id
WHERE creator_id IN (SELECT account_id
					FROM user_nguyen);


