USE extra_assignments_2;

/*============ Add data for table department==============*/
INSERT INTO Trainee(full_name, 				birth_date, 	gender, et_iq, et_gmath, et_english, training_class, evaluation_notes)
VALUE				('Nguyễn Văn Phúc',	 	'1997-04-05', 	'male', '15', '16', '18', 'VTI001', 'good'),
					('Nguyễn Hoàng Quân', 	'1999-08-10', 	'male', '18', '15', '17', 'VTI002', 'good'),
                    ('Nguyễn Thành Nam', 	'1995-04-05', 	'male', '14', '16', '19', 'VTI003', 'good'),
                    ('Phạm Thành Long', 	'1997-04-26', 	'male', '19', '16', '18', 'VTI007', 'excellent'),
                    ('Trần Tiểu Hý', 		'1997-04-12', 	'female', '17', '19', '18', 'VTI004', 'excellent'),
                    ('Nguyễn Bảo Trâm', 	'1997-04-11', 	'female', '17', '14', '17', 'VTI007', 'good'),
                    ('Hoang Minh Trang', 	'1996-05-29', 	'female', '18', '16', '18', 'VTI005', 'excellent'),
                    ('Nguyễn Văn Trọng', 	'1995-09-19', 	'male', '19', '12', '15', 'VTI009', 'good'),
                    ('Đinh Trường Giang', 	'1996-12-17', 	'male', '15', '16', '18', 'VTI006', 'good'),
                    ('Vương Quốc Bảo', 		'1995-11-14', 	'male', '19', '18', '18', 'VTI006', 'excellent');

SELECT * 
FROM Trainee;