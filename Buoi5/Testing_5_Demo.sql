USE testing_system;

-- Question 1: Tạo view có chứa danh sách nhân viên thuộc phòng ban sale
CREATE OR REPLACE VIEW Name_acc_of_sale AS
SELECT acc.account_id, email, use_name, full_name, department_name, position.position_name
FROM testing_system.account AS acc
INNER JOIN department ON acc.department_id = department.department_id
INNER JOIN position ON acc.position_id = position.position_id
WHERE department.department_name = 'Sales';


-- Question 2: Tạo view có chứa thông tin các account tham gia vào nhiều group nhất
DROP VIEW IF EXISTS SL_group_tham_gia;
CREATE VIEW SL_group_tham_gia AS
	SELECT a.account_id, email, use_name, full_name, COUNT(ga.account_id) AS SL_group_tham_gia
	FROM group_account ga
	JOIN `account` a ON ga.account_id = a.account_id
	GROUP BY ga.account_id
	HAVING COUNT(ga.account_id) = (SELECT MAX(SL_group_tham_gia)
										FROM (SELECT COUNT(account_id) AS SL_group_tham_gia
										FROM group_account
										GROUP BY account_id) AS T);

-- Question 4: Tạo view có chứa danh sách các phòng ban có nhiều nhân viên nhất
DROP VIEW IF EXISTS DS_PHONG_NHIEU_NHAN_VIEN;
CREATE VIEW DS_PHONG_NHIEU_NHAN_VIEN AS
WITH table_m AS( -- create CTE have name is table_m --
				SELECT department_id, COUNT(department_id) AS SL_NHAN_VIEN
				FROM testing_system.account
				GROUP BY department_id)
SELECT table_m.department_id, department_name, SL_NHAN_VIEN
FROM table_m
INNER JOIN testing_system.department as dpm
ON dpm.department_id = table_m.department_id
ORDER BY SL_NHAN_VIEN DESC;



-- Question 3: Tạo view có chứa câu hỏi có những content quá dài (content quá 19 từ được coi là quá dài) và xóa nó đi
-- DROP VIEW IF EXISTS DANH_SACH_CAU_HOI_CO_CONTENT_DAI;
-- CREATE VIEW DANH_SACH_CAU_HOI_CO_CONTENT_DAI 
WITH
delete_if AS(
		SELECT question_id
		FROM  question
		WHERE length(content) > 19)
DELETE FROM question
WHERE question_id = (SELECT question_id FROM delete_if);

-- =================================Question 4====================================
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




    
    
    
    
    
    
    
    