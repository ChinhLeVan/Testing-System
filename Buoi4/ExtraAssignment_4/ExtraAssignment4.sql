SELECT et.employee_name, est.skill_code
FROM employee_table et
JOIN employee_skill_table est
ON et.employee_number = est.employee_number
WHERE est.skill_code = 'JAVA';

-- Question 4: Viết lệnh để lấy ra danh sách các phòng ban có > 3 nhân viên
SELECT d.department_name, COUNT(1) AS SLNV
FROM department d
JOIN employee_table et
ON d.department_number = et.department_number
GROUP BY d.department_number
HAVING COUNT(d.department_number) > '3';

-- Question 5: Viết lệnh để lấy ra danh sách nhân viên của mỗi văn phòng ban.
SELECT dt.department_name, et.employee_name
FROM department dt
LEFT JOIN employee_table et ON dt.department_number = et.department_number;

-- Question 6: Viết lệnh để lấy ra danh sách nhân viên có > 1 skills.
SELECT et.employee_name, COUNT(est.skill_code), GROUP_CONCAT(est.skill_code)
FROM employee_table et
JOIN employee_skill_table est ON et.employee_number = est.employee_number
GROUP BY est.employee_number
HAVING COUNT(est.skill_code);