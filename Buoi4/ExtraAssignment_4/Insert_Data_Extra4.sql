USE management_employee;

INSERT INTO department(department_name)
	VALUES 				('Senior developer'),
						('Technical leader'),
						('software'),
						('CTO'),
						('Team leader'),
						('Project manager'),
						('Manager'),
						('Freelance'),
						('Architect'),
						('Upwork');
                                
							
INSERT INTO employee_table(employee_name, department_number)
	VALUES 					('TRAN THAI HOANG',		1),
							('NGUYEN VAN THANG', 	2),
							('PHAM THI NGA',		4),
							('VU MINH TUAN', 		3),
							('PHAM THE PHUONG',		5),
							('TRAN TIEN KHANG',		4),
							('HOANG VAN MANH',		4),
							('LE VAN CHINH',		4),
							('NGUYEN MANH CUONG',	6),
							('NGUYEN TUYET MAI',	10);		

INSERT INTO Employee_skill_table(Employee_number, Skill_code, Date_registered)
VALUES 							(1, 	'JAVA',		'2020/02/07'),
								(1, 	'ML', 		'2020/03/08'),
								(2, 	'AI',		'2020/03/08'),
								(1, 	'JS', 		'2020/02/08'),
								(3, 	'NODEJS',	'2020/04/04'),
								(4, 	'C#',		'2020/03/10'),
								(2, 	'C++',		'2020/05/07'),
								(5, 	'HTML',		'2020/01/02'),
								(6, 	'PHP',		'2020/02/09'),
								(7, 	'RUBY',		'2020/04/06');		