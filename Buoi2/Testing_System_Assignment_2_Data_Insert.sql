USE testing_system;

/*=============== Add data for Database testing_system=========*/
-- =========================================================== --

/*============ Add data for table department==============*/
INSERT INTO department(department_name)
VALUES 					('No person'),
						('Sales'),
                        ('Sercurity'),
                        ('Nhân sự'),
                        ('Kỹ thuật'),
                        ('Tài chính'),
						('Phó giám đốc'),
                        ('Giám đốc'),
                        ('Thư kí'),
                        ('Marketing'),
                        ('Bán hàng');
                        
/*============ Add data for table position=================*/
INSERT INTO `position`(position_name) 
VALUES					('Dev'),
						('Test'),
                        ('Scrum Master'),
                        ('PM');
                        
/*============ Add data for table `account`================*/
INSERT INTO `account`(email,						 use_name,				 full_name, 	department_id, position_id, create_date) 
VALUES
					('vanphucnguyen@gmail.com',		'vanphuc99', 		'Nguyễn Văn Phúc', 		'5', 			'1', 	'2021-03-05'),
					('giangdt@gmail.com',		 	'truonggiang23', 	'Đinh Trường Giang', 	'1', 			'2', 	'2021-03-05'),
					('thanhnam1206@gmail.com',		'thanhnam32', 		'Nguyễn Thành Nam', 	'2', 			'2', 	'2020-07-07'),
					('longpham99@gmail.com', 		'longthanh95', 		'Phạm Thành Long', 		'3', 			'4', 	'2021-07-08'),
					('lvp1234@gmail.com', 			'phongluu1233', 	'Lưu Văn Phong', 		'3', 			'4', 	'2021-03-10'),
					('tieuhyticktok@gmail.com', 	'hyticktok', 		'Trần Tiểu Hý', 		'6', 			'3', 	'2021-07-05'),
					('tramnguyen@gmail.com', 		'baotrammtp', 		'Nguyễn Bảo Trâm', 		'2', 			'2', 	'2020-04-07'),
					('tranghoang666@gmail.com', 	'tranghoang23', 	'Hoang Minh Trang', 	'3', 			'1', 	'2021-06-07'),
					('trong2232@gmail.com', 		'trangvan96', 		'Nguyễn Văn Trọng', 	'2', 			'2', 	'2021-04-09'),
					('baoquocvuong@gmail.com',		'baovuong34',		'Vương Quốc Bảo',		'1', 			'1', 	'2021-05-05');      

/*============== Add data for table `group`=================*/
INSERT INTO `group`(group_name, creator_id, create_date) 
VALUES
			('Testing System',		'5',	'2021-03-05'),
            ('Development',			'6',	'2021-03-07'),
            ('VTI Sale 01',			'5',	'2021-05-09'),
            ('VTI Sale 02',			'8',	'2021-03-10'),
            ('VTI Sale 03',			'1',	'2021-03-28'),
            ('VTI Creator',			'9',	'2021-04-06'),
            ('VTI Marketing 01',	'7',	'2021-05-07'),
            ('Management',			'2',	'2021-04-08'),
            ('Chat with love',		'1',	'2021-04-09'),
            ('Vi Ti Ai',			'5',	'2021-09-10');

/*=============== Add data for table `group_account`=============*/
INSERT INTO `group_account`(group_id, account_id, join_date) 
VALUES
							('1',	'1',	'2021-03-05'),
							('1',	'2',	'2021-03-05'),
							('3',	'3',	'2021-03-05'),
							('3',	'1',	'2021-03-05'),
							('5',	'4',	'2021-03-05'),
							('1',	'1',	'2021-03-05'),
							('1',	'5',	'2021-03-05'),
							('8',	'8',	'2021-03-05'),
							('1',	'6',	'2021-12-25'),
							('3',	'9',	'2021-12-25');

/*=============== Add data for table type_question=======================*/
INSERT INTO type_question(type_name) 
VALUES
						('Essay'),
						('Multiple-Choice');

/*=============== Add data for table category_question====================*/
INSERT INTO category_question(category_name) 
VALUES
							('Java'),
                            ('ASP.NET'),
                            ('ADO.NET'),
                            ('SQL'),
                            ('Postman'),
                            ('Ruby'),
                            ('Python'),
                            ('C++'),
                            ('C Sharp'),
                            ('PHP');

/*================== Add data for table question===========================*/
INSERT INTO question(content,			category_id, type_id, creator_id, create_date) 
VALUES
					('Các câu hỏi về Java', 	'1', 	'1', 	'2',	'2019-04-05'),
                    ('Các câu hỏi về PHP', 		'10',	'2', 	'2', 	'2021-07-05'),
                    ('Hỏi về C#', 				'9', 	'2', 	'3', 	'2020-04-06'),
                    ('Hỏi về Ruby', 			'6', 	'1', 	'4', 	'2019-07-06'),
                    ('Hỏi về Postman', 			'5', 	'1', 	'5', 	'2021-07-06'),
                    ('Hỏi về ADO.NET', 			'3', 	'2', 	'6', 	'2020-04-06'),
                    ('Hỏi về ASP.NET', 			'2', 	'1', 	'7', 	'2020-04-07'),
                    ('Hỏi về C++', 				'8', 	'1', 	'8', 	'2021-07-07'),
                    ('Hỏi về SQL', 				'4', 	'2', 	'9', 	'2020-04-07'),
                    ('Hỏi về Python', 			'7', 	'1', 	'10', 	'2019-04-07');

/*===================== Add data for table answer======================*/
INSERT INTO answer(content, question_id, is_correct) 
VALUES
				('Trả lời 1', '1', 			b'0'),
                ('Trả lời 2', '1', 			b'1'),
                ('Trả lời 3', '1', 			b'0'),
                ('Trả lời 4', '1', 			b'1'),
                ('Trả lời 5', '2', 			b'1'),
                ('Trả lời 6', '3', 			b'1'),
                ('Trả lời 7', '4', 			b'0'),
                ('Trả lời 8', '8', 			b'0'),
                ('Trả lời 9', '9', 			b'1'),
                ('Trả lời 10', '10', 		b'1');

/*======================== Add data for table exam===========================*/
INSERT INTO exam(`code`, title, category_id, duration, creator_id, create_date) 
VALUES
				('VTIQ001',	 'Đề thi C#', 		'1', '80', '1', '2019-12-25'),
                ('VTIQ002',	 'Đề thi PHP', 		'2', '70', '2', '2020-04-05'),
                ('VTIQ003',	 'Đề thi C++', 		'1', '60', '7', '2019-04-05'),
                ('VTIQ004',	 'Đề thi Java', 	'4', '50', '9', '2021-05-05'),
                ('VTIQ005',	 'Đề thi Ruby', 	'5', '60', '10','2020-04-05'),
                ('VTIQ006',	 'Đề thi Postman',	'2', '60', '6', '2019-04-05'),
                ('VTIQ007',	 'Đề thi SQL', 		'6', '90', '5', '2019-12-25'),
                ('VTIQ008',	 'Đề thi Pythol', 	'8', '55', '3', '2020-04-05'),
                ('VTIQ009',	 'Đề thi ADO.NET', 	'1', '65', '2', '2021-04-05'),
                ('VTIQ0010', 'Đề thi ASP.NET', 	'7', '75', '8', '2018-04-05');

/*============================ Add data for table exam_question==============*/                        
INSERT INTO exam_question(exam_id, question_id) 
VALUES
						('1','5'),
                        ('2','10'),
                        ('3','4'),
                        ('4','3'),
                        ('5','7'),
                        ('6','10'),
                        ('7','2'),
                        ('8','9'),
                        ('9','9'),
                        ('10','8');
                