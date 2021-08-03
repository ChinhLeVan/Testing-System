USE extra_assignments_2;

/*============ Add data for table department==============*/
INSERT INTO Trainee(full_name, 				birth_date, 	gender, et_iq, et_gmath, et_english, training_class, evaluation_notes)
VALUE				('Nguyễn Văn Phúc',	 	'04-05-1997', 	'male', '15', '16', '18', 'VTI001', 'good'),
					('Nguyễn Hoàng Quân', 	'08-10-1999', 	'male', '18', '15', '17', 'VTI002', 'good'),
                    ('Nguyễn Thành Nam', 	'14-05-1995', 	'male', '14', '16', '19', 'VTI003', 'good'),
                    ('Phạm Thành Long', 	'04-09-1997', 	'male', '19', '16', '18', 'VTI007', 'excellent'),
                    ('Trần Tiểu Hý', 		'04-12-1997', 	'female', '17', '19', '18', 'VTI004', 'excellent'),
                    ('Nguyễn Bảo Trâm', 	'04-11-1997', 	'female', '17', '14', '17', 'VTI007', 'good'),
                    ('Hoang Minh Trang', 	'15-09-1996', 	'female', '18', '16', '18', 'VTI005', 'excellent'),
                    ('Nguyễn Văn Trọng', 	'24-09-1995', 	'male', '19', '12', '15', 'VTI009', 'good'),
                    ('Đinh Trường Giang', 	'14-07-1996', 	'male', '15', '16', '18', 'VTI006', 'good'),
                    ('Vương Quốc Bảo', 		'17-04-1995', 	'male', '19', '18', '18', 'VTI006', 'excellent');

SELECT * 
FROM Trainee;