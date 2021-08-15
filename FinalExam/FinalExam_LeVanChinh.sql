DROP DATABASE IF EXISTS ThucTap;
CREATE DATABASE ThucTap;
USE ThucTap;

-- ----------------------------------------------------------------------
-- -------------------- create table GiangVien--------------------------
DROP TABLE IF EXISTS GiangVien;
CREATE TABLE GiangVien (
	magv			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    hoten			NVARCHAR(50) NOT NULL,
    luong			FLOAT UNSIGNED
);

-- ----------------------------------------------------------------------
-- -------------------- create table SinhVien--------------------------
DROP TABLE IF EXISTS SinhVien;
CREATE TABLE SinhVien (
	masv			INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    hoten			NVARCHAR(50) 	NOT NULL,
    namsinh			DATE			NOT NULL,
    quequan			NVARCHAR(50) 	NOT NULL
);

-- ----------------------------------------------------------------------
-- -------------------- create table DeTai--------------------------
DROP TABLE IF EXISTS DeTai;
CREATE TABLE DeTai (
	madt			NVARCHAR(20) NOT NULL PRIMARY KEY,
    tendt			NVARCHAR(50) NOT NULL UNIQUE KEY,
    kinhphi			FLOAT UNSIGNED,
    noithuctap		NVARCHAR(50) NOT NULL
);

-- ----------------------------------------------------------------------
-- -------------------- create table HuongDan--------------------------
DROP TABLE IF EXISTS HuongDan;
CREATE TABLE HuongDan (
	id				INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    masv			INT UNSIGNED,
    madt			NVARCHAR(20) NOT NULL,
    magv			TINYINT UNSIGNED NOT NULL,
    ketqua			ENUM("Tốt", "Khá", "Trung Bình", "Yếu"),
    -- FOREIGN KEY (masv) REFERENCES SinhVien(masv) 		,
    FOREIGN KEY (madt) REFERENCES DeTai(madt)			,
    FOREIGN KEY (magv) REFERENCES GiangVien(magv)		
);
ALTER TABLE HuongDan
ADD CONSTRAINT FK_masv
FOREIGN KEY (masv) REFERENCES SinhVien(masv);

/*============ Add data for table GiangVien=================*/
INSERT INTO `GiangVien`(hoten, luong) 
VALUES					('Trần Thị Linh', 10),
						('Trần Quang Thành', 12.5),
                        ('Hoàng Thị Thu', 15.2);

 /*============ Add data for table SinhVien=================*/
INSERT INTO `SinhVien`(hoten, namsinh, quequan) 
VALUES				('Trần Thị Tâm', '1994-03-06', 'Hà Nội'),
					('Trần Quang Thành', '1996-05-09', 'Nghệ An'),
					('Hoàng Thị Thu', '1995-07-04', 'Thái Bình');
                       
 /*============ Add data for table DeTai=================*/
INSERT INTO `DeTai`(madt, tendt, kinhphi, noithuctap) 
VALUES				('DT01', 'Công Nghệ Sinh Học', '100', 'Hà Nội'),
					('DT02', 'Máy trộn cám ngô', '200','Thái Nguyên'),
					('DT03', 'Máy gieo hạt tiêu', '400','Long AN');

 /*============ Add data for table HuongDan=================*/
INSERT INTO `HuongDan`(masv, madt, magv, ketqua) 
VALUES				('1', 'DT01', '2', 'Khá'),
					('2', 'DT01', '3','Tốt'),
					('1', 'DT03', '1','Trung Bình');
                    
/* 2. Viết lệnh để
a) Lấy tất cả các sinh viên chưa có đề tài hướng dẫn
 */               

SELECT *
FROM SinhVien
WHERE masv NOT IN (SELECT masv
					FROM HuongDan);
                    
/* b) Lấy ra số sinh viên làm đề tài ‘CONG NGHE SINH HOC */
SELECT COUNT(madt) AS SL_SV
FROM HuongDan
WHERE madt IN (SELECT madt FROM DeTai WHERE tendt = 'Công Nghệ Sinh Học');

/* 3. Tạo view có tên là "SinhVienInfo" lấy các thông tin về học sinh bao gồm: 
mã số, họ tên và tên đề tài
(Nếu sinh viên chưa có đề tài thì column tên đề tài sẽ in ra "Chưa có") */

DROP VIEW IF EXISTS SinhVienInfo;
CREATE VIEW SinhVienInfo AS
SELECT s.masv, s.hoten, CASE 
							WHEN d.tendt IS NULL THEN "Chưa có"
							ELSE d.tendt
							END AS tendt
FROM HuongDan h
INNER JOIN DeTai d ON d.madt = h.madt
RIGHT JOIN SinhVien s ON s.masv = h.masv;

/* 4. Tạo trigger cho table SinhVien khi insert sinh viên có năm sinh <= 1900 
thì hiện ra thông báo "năm sinh phải > 1900" */
DROP TRIGGER IF EXISTS trigger_insert_sv;
DELIMITER $$
	CREATE TRIGGER trigger_insert_sv
    BEFORE INSERT ON `SinhVien`
    FOR EACH ROW
    BEGIN
		IF YEAR(NEW.`namsinh`) <= 1900 THEN
        SIGNAL SQLSTATE '12345'  -- disallow insert this record
        SET MESSAGE_TEXT = "năm sinh phải > 1990";
        END IF;
	END $$
DELIMITER ;

INSERT INTO `SinhVien`(hoten, namsinh, quequan) 
VALUES					('Trần Thị Tâm', '1910-07-03', 'Hà Nội');
SELECT * FROM `SinhVien`;

/*5. Hãy cấu hình table sao cho khi xóa 1 sinh viên nào đó thì sẽ tất cả thông 
tin trong table HuongDan liên quan tới sinh viên đó sẽ bị xóa đi*/

ALTER TABLE HuongDan
DROP FOREIGN KEY FK_masv;
ALTER TABLE HuongDan
ADD CONSTRAINT FK_masv
FOREIGN KEY (masv) REFERENCES SinhVien(masv) 		ON DELETE CASCADE;

DELETE FROM SinhVien
WHERE masv = '2';
SELECT* FROM  HuongDan;
SELECT* FROM  SinhVien;