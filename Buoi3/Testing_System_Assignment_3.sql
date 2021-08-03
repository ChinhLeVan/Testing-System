/* ============= Làm việc với data của các bảng ============= */
-- ======================================================= --
-- Question 1: Thêm ít nhất 10 record vào mỗi bảng ghi ->>>> DONE
-- ->>>>>>>>>>DONE DONE>>>>>>>>>
USE testing_system;

-- Question 2: Lấy ra tất cả các phòng ban
SELECT department_name
FROM testing_system.department;

-- Question 3: Lấy ra Id của phòng ban sale
SELECT department_id
FROM testing_system.department
WHERE department_name = 'Sales';

-- Question 4: Lấy ra thông tin acc có full name dài nhất.
-- Cách 1
SELECT *
FROM testing_system.account
ORDER BY length(full_name) DESC LIMIT 1;-- giới hạn in ra 1 tên

-- giới hạn in ra 1 tên cách 2
SELECT *, length( full_name )
FROM testing_system.account
WHERE length( full_name ) = ( SELECT max( length( full_name ) ) FROM testing_system.account ) LIMIT 1;

-- Không giới hạn 
SELECT *, length( full_name )
FROM testing_system.account
WHERE length( full_name ) = ( SELECT max( length( full_name ) ) FROM testing_system.account );

-- Question 5: Lấy ra acc có full name dài nhất và thuộc phòng ban có Id bằng 3
SELECT *
FROM testing_system.account
WHERE department_id = '3'
ORDER BY length(full_name) DESC LIMIT 1;

-- Question 6: Lấy ra tên group đang tham gia trước ngày 20/12/2019
SELECT group_name
FROM testing_system.group
WHERE create_date < '2019/12/20';

-- Question 7: Lấy ra ID của Question có >= 4 câu trả lời.
SELECT question_id, COUNT(question_id)
FROM testing_system.answer
GROUP BY question_id
HAVING COUNT(question_id) >= '4';

-- Question 8: Lấy ra các mã đề thi có thời gian thi >= 60 phút và được tạo trước ngày 20/12/2019
SELECT code
FROM testing_system.exam
WHERE  duration >= '60' AND create_date < '2019/12/20';

-- Question 9: Lấy ra 5 group được tạo gần đây nhất
SELECT group_name
FROM testing_system.group
ORDER BY create_date ASC LIMIT 5;

-- Question 10: Đếm số nhân viên thuộc department có id = 2
SELECT department_id, COUNT(department_id)
FROM testing_system.account
GROUP BY department_id
HAVING department_id = 2;

-- Question 11: Lấy ra nhân viên có tên bắt đầu bằng chữ "F" và kết thúc bằng "3"
SELECT * 
FROM testing_system.account
WHERE full_name LIKE 'f%3';

-- Question 12: Xóa tất cả các exam được tạo trước ngày 20/12/2019
DELETE 
FROM testing_system.exam
WHERE create_date < '2019/12/20';

-- Question 13: Xóa tất cả các question có nội dung bắt đầu bằng từ "câu hỏi"
SELECT *,question_id
FROM testing_system.question;
DELETE 
FROM testing_system.question
WHERE content LIKE 'Câu hỏi%';

-- Question 14: Update thông tin của account có id = 5 thành tên "Nguyễn Bá Lộc" và email thành loc.nguyenba@vti.com.vn
SELECT * FROM testing_system.account;
UPDATE testing_system.account
SET use_name = 'Nguyễn Bá Lộc',
	email = 'loc.nguyenba@vti.com.vn'
WHERE account_id ='5';

-- Question 15: update account có id = 5 sẽ thuộc group có id = 4
SELECT * FROM testing_system.group_account;
UPDATE testing_system.group_account
SET group_id = '4'
WHERE account_id = '5';
SELECT group_id, account_id FROM testing_system.group_account
WHERE account_id = '5';