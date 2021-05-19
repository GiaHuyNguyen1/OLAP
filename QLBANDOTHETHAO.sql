CREATE DATABASE QLCUAHANGTHETHAO
GO
USE QLCUAHANGTHETHAO
GO


CREATE TABLE THANHPHO
(
	MATP CHAR(10) NOT NULL PRIMARY KEY,
	TENTP NVARCHAR(50)
)
GO
CREATE TABLE KHUVUC
(
	MAKV CHAR(10) NOT NULL PRIMARY KEY,
	TENKV NVARCHAR(50),
	MATP CHAR(10),
	CONSTRAINT FK_KV_TP FOREIGN KEY (MATP) REFERENCES THANHPHO(MATP)

)
GO
CREATE TABLE QLCUAHANG
(
	MAQL CHAR(10) NOT NULL PRIMARY KEY,
	TENQL NVARCHAR(50),
	SDT CHAR(10),
	DIACHI NVARCHAR(50),
	NGAYVAOLAM DATE,
	HESOLUONG FLOAT
)
GO
CREATE TABLE CUAHANG
(
	MACH CHAR(10) NOT NULL PRIMARY KEY,
	TENCH NVARCHAR(50),
	DIACHI NVARCHAR(50),
	SDT CHAR(10),
	MAKV CHAR(10),
	MAQL CHAR(10),
	CONSTRAINT FK_CH_QL FOREIGN KEY (MAQL) REFERENCES QLCUAHANG(MAQL),
	CONSTRAINT FK_CH_KV FOREIGN KEY (MAKV) REFERENCES KHUVUC(MAKV)
)
GO
CREATE TABLE MONTHETHAO
(
	MAMON CHAR(10) NOT NULL PRIMARY KEY,
	TENMON NVARCHAR(50)
)
GO
CREATE TABLE LOAISP
(
	MALOAISP CHAR(10) NOT NULL PRIMARY KEY,
	TENLOAISP NVARCHAR(50),
	MAMON CHAR(10),
	CONSTRAINT FK_LOAISP_MONTHETHAO FOREIGN KEY (MAMON) REFERENCES MONTHETHAO(MAMON)

)
GO
CREATE TABLE SANPHAM
(
	MASP CHAR(10) NOT NULL PRIMARY KEY,
	TENSP NVARCHAR(50),
	GIABAN FLOAT,
	UUDAITHEM NVARCHAR(100),
	HINH CHAR(10),
	DACDIEM NVARCHAR(1000),
	MOTA NVARCHAR(1000),
	HDSD NVARCHAR(100),
	MALOAISP CHAR(10),
	CONSTRAINT FK_SP_LOAISP FOREIGN KEY (MALOAISP) REFERENCES LOAISP(MALOAISP)
)



CREATE TABLE LOAIKHACH
(
	MALOAIKHACH CHAR(10) NOT NULL PRIMARY KEY,
	TENLOAIKHACH CHAR(20),
	UUDAI FLOAT
)
GO

CREATE TABLE KHACHHANG
(	
	MAKHACH CHAR(10) NOT NULL PRIMARY KEY,
	TENKHACH NVARCHAR(50),
	GIOITINH NCHAR(10),
	NGAYSINH DATE,
	DIACHI NVARCHAR(50),
	SDT CHAR(10),
	DAMUA FLOAT,
	MALOAIKHACH CHAR(10),
	CONSTRAINT FK_KH_LOAIKHACH FOREIGN KEY (MALOAIKHACH) REFERENCES LOAIKHACH(MALOAIKHACH)
)
GO
CREATE TABLE KHO
(
	MAKHO CHAR(10) NOT NULL PRIMARY KEY,
	TENKHO NVARCHAR(50),
	NGUOIDAIDIEN NVARCHAR(50),
	SDT CHAR(10),
	DIACHI NVARCHAR(50),
	MAKV CHAR(10),
	CONSTRAINT FK_KHO_KV FOREIGN KEY (MAKV) REFERENCES KHUVUC(MAKV)
)
GO
CREATE TABLE CHITIETKHO
(
	MAKHO CHAR(10) NOT NULL,
	MASP CHAR(10) NOT NULL,
	SOLUONGTON INT,
	CONSTRAINT PK_CTK PRIMARY KEY(MAKHO,MASP),
	CONSTRAINT FK_CTK_KHO FOREIGN KEY (MAKHO) REFERENCES KHO(MAKHO),
	CONSTRAINT FK_CTK_SP FOREIGN KEY (MASP) REFERENCES SANPHAM(MASP)
)
GO


CREATE TABLE NHAPHANG
(
	MANH CHAR(10) NOT NULL PRIMARY KEY,
	NGAYNHAP DATE,
	MAKHO CHAR(10),
	TONGTIENNHAP FLOAT,
	GHICHU NVARCHAR(500),
	CONSTRAINT FK_NH_KHO FOREIGN KEY (MAKHO) REFERENCES KHO(MAKHO)
)
GO
CREATE TABLE CHITIETNHAPHANG
(
	MANH CHAR(10) NOT NULL,
	MASP CHAR(10) NOT NULL,
	DONGIANHAP FLOAT,
	SOLUONG INT,
	CONSTRAINT PK_CTNH PRIMARY KEY (MANH,MASP),
	CONSTRAINT FK_CTNH_NH FOREIGN KEY (MANH) REFERENCES NHAPHANG(MANH),
	CONSTRAINT FK_CTNN_SP FOREIGN KEY (MASP) REFERENCES SANPHAM(MASP)
)
GO

CREATE TABLE HOADON
(
	MAHD CHAR(10) NOT NULL PRIMARY KEY,
	NGAYIN DATE,
	MAKHACH CHAR(10),
	TRANGTHAI NCHAR(20),
	TONGTIEN FLOAT,
	CHUTHICH NVARCHAR(500),
	MAKHO CHAR(10),
	CONSTRAINT FK_HD_KHACH FOREIGN KEY (MAKHACH) REFERENCES KHACHHANG(MAKHACH),
	CONSTRAINT FK_HD_KHO FOREIGN KEY (MAKHO) REFERENCES KHO(MAKHO)
)

CREATE TABLE CTHD
(
	MAHD CHAR(10) NOT NULL ,
	MASP CHAR(10) NOT NULL,
	SOLUONG INT,
	DONGIA FLOAT,
	MAKHO CHAR(10),
	MACH CHAR(10),
	CONSTRAINT PK_CTHD PRIMARY KEY (MAHD,MASP),
	CONSTRAINT FK_CTHD_HD FOREIGN KEY(MAHD) REFERENCES HOADON(MAHD),
	CONSTRAINT FK_CTHD_KHO FOREIGN KEY (MAKHO) REFERENCES KHO(MAKHO),
	CONSTRAINT FK_CTHD_CH FOREIGN KEY (MACH) REFERENCES CUAHANG(MACH)
)


CREATE TABLE CHUONGTRINHKHUYENMAI
(
	MAKM CHAR(10) NOT NULL PRIMARY KEY,
	TENKM NVARCHAR(100),
	HOANTIEN FLOAT,
	MALOAIKHACH CHAR(10),
	CONSTRAINT FK_KM_LOAIKHACH FOREIGN KEY (MALOAIKHACH) REFERENCES LOAIKHACH(MALOAIKHACH)
)
GO


INSERT INTO THANHPHO
VALUES
('TP01','TPHCM'),
('TP02','HANOI'),
('TP03','DANANG')



INSERT INTO KHUVUC
VALUES
('KV01',N'Đống Đa','TP02'),
('KV02',N'Tân Phú','TP01'),
('KV03',N'Gò Vấp','TP01'),
('KV05',N'Hội An','TP03')

SET DATEFORMAT DMY 
INSERT INTO QLCUAHANG
VALUES 
('QL01',N'NGUYỄN TRUNG NAM',093828174,N'18 NGUYỄN VĂN LINH','13/02/2000',2),
('QL02',N'NGUYỄN TẤN MINH',093838172,N'20 PHẠM VĂN ĐỒNG','11/09/2001',1),
('QL03',N'ĐOÀN TRUNG QUÂN',093528166,N'13 NGUYỄN LỮ','13/03/2001',1),
('QL04',N'TRẦN TẤN LỘC',093622274,N'101 NGUYỄN TRUNG CHÁNH','23/08/2000',2),
('QL05',N'TRƯƠNG MINH ĐẠT',0571748411,N'PHẠM NGŨ LÃO','16/04/2001',1)


INSERT INTO CUAHANG
VALUES 
('CH01',N'YOUSPORT1',N'101 CÁCH MẠNG THÁNG 8',18006749,'KV01','QL01'),
('CH02',N'YOUSPORT2',N'20 PHẠM NGŨ LÃO',18006749,'KV01','QL02'),
('CH03',N'YOUSPORT3',N'45 NGÔ QUYỀN',18006749,'KV02','QL03'),
('CH04',N'YOUSPORT4',N'90 NGUYỄN TRUNG TRỰC',18006749,'KV03','QL04'),
('CH05',N'YOUSPORT5',N'50 XÔ VIẾT NGHỆ TĨNH',18006749,'KV02','QL05')

INSERT INTO MONTHETHAO
VALUES
('MON01',N'BÓNG ĐÁ'),
('MON02',N'BÓNG CHUYỀN'),
('MON03',N'CẦU LÔNG'),
('MON04',N'BƠI')


INSERT INTO LOAISP
VALUES 
('LOAI01',N'ÁO QUẦN','MON01'),
('LOAI02',N'ÁO QUẦN','MON02'),
('LOAI03',N'ÁO QUẦN','MON03'),
('LOAI04',N'ÁO QUẦN','MON04'),
('LOAI05',N'BAO TAY','MON01'),
('LOAI06',N'NÓN','MON04'),
('LOAI07',N'GIÀY','MON01'),
('LOAI08',N'CẦU','MON03'),
('LOAI09',N'GIÀY','MON02'),
('LOAI10',N'GIÀY','MON03'),
('LOAI11',N'VỢT','MON03'),
('LOAI12',N'BÓNG','MON01'),
('LOAI13',N'BÓNG','MON02')


INSERT INTO SANPHAM
VALUES 
('SP01',N'GIÀY Pan Vigor X Nagoya LTD IC',2100000,N'BẢO HÀNH KEO TRỌN ĐỜI','sp1',N'Upper làm bằng MICRO FIBLER LEATHER',N'Bề mặt 𝐆𝐫𝐢𝐩 𝐓𝐫𝐢𝐚𝐧𝐠𝐥𝐞: Đây là chất liệu được phủ lớp TPU mỏng 0.3 mm giúp tăng khả năng kiểm soát bóng trên toàn bộ phần trước',N'3 NĂM','LOAI07'),
('SP02',N'Giày Pan Impulse Graffiti IC',50000,N'BẢO HÀNH KEO TRỌN ĐỜI','sp1',N'Upper làm bằng Da PVC',N'Mũi giày được dán keo và khâu may chắc chắn, giữ vững ưu thế tuyệt đối của Pan trong các pha chích mũi giày',N'3 NĂM','LOAI07'),
('SP03',N'Giày Jogarbola 9019 TF',60000,N'BẢO HÀNH KEO TRỌN ĐỜI','sp1',N'Chất liệu microfiber',N'Lưỡi gà dạng truyền thống ',N'3 NĂM','LOAI07'),
('SP04',N'Giày Mizuno Monarcida Neo 2 Select AS',1200000,N'Giảm 20% quần áo bóng đá mua kèm giày','sp1',N'Sử dụng đinh TF chuyên dụng cho sân cỏ nhân tạo',N'Lưỡi gà được thiết kế mềm mỏng',N'3 NĂM','LOAI07'),
('SP05',N'Giày Mizuno Monarcida NEO Select AS',900000,N'Giảm 20% quần áo bóng đá mua kèm giày','sp1',N'Da PU, Lưỡi gà rời, Công nghệ định hình gót',N' Công nghệ Pivot Point',N'3 NĂM','LOAI07'),
('SP06',N'Giày adidas Copa Sense.3',1620000,N'Giảm 30% phụ kiện mua kèm giày','sp1',N'Upper: Chất liệu da mềm mại, các đường rãnh sóng tạo khối cho cảm giác bóng tuyệt vời.',N'Với cổ giày co giãn, đôi giày đá bóng adidas này giúp bạn dễ dàng xỏ vào và ôm chân vừa vặn',N'3 NĂM','LOAI07'),
('SP07',N'Giày adidas X Ghosted.3 TF',1620000,N'Giảm 30% phụ kiện mua kèm giày','sp1',N'Upper: làm bằng vải lưới siêu nhẹ, bề mặt được phủ lớp bóng dễ vệ sinh',N'Thân thủ phi phàm không gì cản bước. Khi thần tốc vẫn là chưa đủ nhanh trên sân đấu, hãy lựa chọn X Ghosted',N'3 NĂM','LOAI07'),
('SP08',N'Giày adidas Predator Freak.3',1980000 ,N'Giảm 30% phụ kiện mua kèm giày','sp1',N'Upper: Làm bằng chất liệu vải dệt, có lớp phủ dễ vệ sinh. Các chi tiết "Demonscale" in 3D tạo bề mặt tiếp xúc bóng tốt',N'Trên sân đấu, bạn nắm quyền kiểm soát. Hãy khai phá tối đa sức mạnh của bạn với Predator Freak.',N'3 NĂM','LOAI07'),
('SP09',N'NIKE MERCURIAL VAPOR 13 PRO TF',2550000,N'Tặng kèm vớ dệt kim và ba lô chống thấm đựng giày cho mỗi đơn hàng Giày đá banh trên 1 triệu','sp1',N'Đế giày: Được làm từ chất liệu cao su cao cấp.',N'Thiết kế upper liền với thân giày với cấu tạo là những sợi dệt cao cấp 2 chiều',N'3 NĂM','LOAI07'),
('SP10',N'NIKE TIEMPO PREMIER II SALA',1950000,N'Tặng kèm vớ dệt kim và ba lô chống thấm đựng giày cho mỗi đơn hàng Giày đá banh trên 1 triệu','sp1',N'Với upper da lộn , kết hợp với tấm lưới thoáng khí tản nhiệt cho bàn chân khi thi đấu ở cường độ cao cho cảm giác mềm và êm, tăng khả năng khống chế cũng như kiểm soát bóng',N' Nike đem lại cho Tiempo Premier II Sala khả năng đàn hồi tốt, cho cảm giác thoải mái, bổ trợ cho những pha bật nhảy, tăng tốc',N'3 NĂM','LOAI07'),
('SP11',N'ADIDAS X GHOSTED.1 IN',2450000,N'Tặng kèm vớ dệt kim và ba lô chống thấm đựng giày cho mỗi đơn hàng Giày đá banh trên 1 triệu','sp1',N'Đế giày: Được làm từ chất liệu cao su cao cấp.',N'Dòng sản phẩm dành cho bề mặt sân bóng đá trong nhà futsal Đế IC',N'3 NĂM','LOAI07'),
('SP12',N'NIKE MERCURIAL SUPERFLY 7 ELITE IC',2550000,N'Tặng kèm vớ dệt kim và ba lô chống thấm đựng giày cho mỗi đơn hàng Giày đá banh trên 1 triệu','sp1',N'Đế giày: Được làm từ chất liệu cao su cao cấp.',N'Flyknit - upper cao cấp nhất tính đến thời điểm hiện tại của Nike - Đây là tổ hợp các loại sợi đặc biệt được đan một cách khoa học tạo nên một miếng vật liệu liền mạch mềm như len ',N'3 NĂM','LOAI07'),


('SP13',N'Quần Áo Juventus',120000,N'Đặt 7 - 9 bộ tặng băng đội trưởng hoặc túi đựng giày','sp1',N'Vải mè cực chất, thoáng mát và ít nhăn nhàu',N'Juventus lại có màu cam nổi bật cùng với những hoa văn loang lổ đầy cá tính',N'1 NĂM','LOAI01'),
('SP14',N'Quần Áo Chelsea',99000,N'Đặt 7 - 9 bộ tặng băng đội trưởng hoặc túi đựng giày','sp1',N'Vải thun lạnh 100% polyester, đặt dệt độc quyền mềm và mịn',N'Chelsea sân khách 2020-2021 là chiếc áo màu xanh ngọc với các họa tiết trông khá bắt mắt',N'1 NĂM','LOAI01'),
('SP15',N'Quần Áo Man City',99000,N'Đặt 7 - 9 bộ tặng băng đội trưởng hoặc túi đựng giày','sp1',N'Vải thun lạnh 100% polyester, đặt dệt độc quyền mềm và mịn.',N'Man City sân nhà 2019 - 2020 được lấy cảm hứng từ những bức tranh khảm xuất hiện trên khắp các đường phố Manchester',N'1 NĂM','LOAI01'),
('SP16',N'Quần áo Liverpool',99000,N'Đặt 7 - 9 bộ tặng băng đội trưởng hoặc túi đựng giày','sp1',N'Vải thun lạnh 100% polyester',N'Liverpool sân nhà 2020-2021 năm nay có sự thay đổi nhiều về thiết kế và màu sắc',N'1 NĂM','LOAI01'),
('SP17',N'Quần Áo AC Milan',99000,N'Đặt 7 - 9 bộ tặng băng đội trưởng hoặc túi đựng giày','sp1',N'Vải thun lạnh 100% polyester',N'AC Milan sân nhà 2020-2021 năm nay có sự thay đổi nhiều về thiết kế và màu sắc',N'1 NĂM','LOAI01'),
('SP18',N'Quần Áo Wolvehampton',99000,N'Đặt 7 - 9 bộ tặng băng đội trưởng hoặc túi đựng giày','sp1',N'Vải thun lạnh 100% polyester',N'Wolvehampton sân nhà 2020-2021 năm nay có sự thay đổi nhiều về thiết kế và màu sắc',N'1 NĂM','LOAI01'),
('SP19',N'Quần Áo Tottenham',99000,N'Đặt 7 - 9 bộ tặng băng đội trưởng hoặc túi đựng giày','sp1',N'Vải thun lạnh 100% polyester',N'Tottenham sân nhà 2020-2021 năm nay có sự thay đổi nhiều về thiết kế và màu sắc',N'1 NĂM','LOAI01'),
('SP20',N'Quần Áo Ajax',99000,N'Đặt 7 - 9 bộ tặng băng đội trưởng hoặc túi đựng giày','sp1',N'Vải thun lạnh 100% polyester',N'Ajax sân nhà 2020-2021 năm nay có sự thay đổi nhiều về thiết kế và màu sắc',N'1 NĂM','LOAI01'),





('SP21',N'Quả bóng đá Fifa Spectro UHV 2.07',1600000 ,N'Tặng Ba lô thể thao SG II','sp1',N'PU cao cấp + chống thấm',N'Sản phẩm cao cấp của Động Lực Việt Nam',N'3 NĂM','LOAI12'),
('SP22',N'Quả Bóng In Đ UHV 1.02',500000,N'Chương trình khuyến mãi đầu xuân Tân Sửu','sp1',N'Da PU cao cấp',N'sản phẩm cao cấp của Động Lực Việt Nam',N'3 NĂM','LOAI12'),
('SP23',N'Quả Bóng In Sao UHV 2.03',430000 ,N'Chương trình khuyến mãi đầu xuân Tân Sửu','sp1',N'Da PU cao cấp',N'sản phẩm cao cấp của Động Lực Việt Nam',N'3 NĂM','LOAI12'),
('SP24',N'Quả Bóng Số 5 UCV 3.05',250000 ,N'Chương trình khuyến mãi đầu xuân Tân Sửu','sp1',N'Da PU-PVC',N'sản phẩm cao cấp của Động Lực Việt Nam',N'3 NĂM','LOAI12'),



('SP25',N'Găng Tay Thủ Môn H3 GK',549000,N'1 Mua "bó gối thủ môn 1 "Giá 1000','sp1',N'Da tổng hợp PU, Air Mesh',N'H3 thương hiệu Thái Lan được sản xuất tại Pakistan',N'2 NĂM','LOAI05'),
('SP26',N'Găng tay Thủ môn Eepro EG1035',519000 ,N'1 Mua "bó gối thủ môn 1 "Giá 1000','sp1',N'Da tổng hợp PU, Air Mesh',N' găng có trang bị các đường cut lõm trên mút trong lòng bàn tay, giúp các thủ môn có cảm giác bắt bóng tốt hơn',N'2 NĂM','LOAI05'),
('SP27',N'Găng tay Thủ môn H3 ROBO',549000,N'1 Mua "bó gối thủ môn 1 "Giá 1000','sp1',N'Da tổng hợp PU, Air Mesh',N'Thuộc dòng găng tay HYBIRD ROLL rất phù hợp với các thủ môn do ôm chặt lòng bàn tay.',N'3 NĂM','LOAI05'),
('SP28',N'Găng tay thủ môn HO Soccer Intial Flat Arc',490000,N'2 Quần áo thủ môn giá 1000','sp1',N'Da tổng hợp PU, Air Mesh',N'HO thương hiệu Thái Lan được sản xuất tại Pakistan',N'3 NĂM','LOAI05'),



('SP29',N'Vợt Cầu Lông Mizuno JPX Z8-CX', 4060000 ,N'Mua sản phẩm vợt được tặng 1 băng quấn','sp1',N' Khung vợt: Japan HMG T46,Thân vợt: Japan HMG T46',N' Công nghệ tích hợp trên vợt cầu lông cao cấp Mizuno JPX Z8-CX',N'3 NĂM','LOAI11'),
('SP30',N'Vợt cầu lông Yonex Astrox 2', 1599000 ,N'Mua sản phẩm vợt được tặng 1 băng quấn','sp1',N' Khung vợt: Graphite/Tungsten,Thân vợt: Graphite/NANOMESH NEO ',N' Công nghệ được tích hợp trên vợt cầu lông tầm trung Yonex Astrox 2',N'3 NĂM','LOAI11'),
('SP31',N'Vợt cầu lông Lining Aeronaut 9000i', 4700000 ,N'Mua sản phẩm vợt được tặng 1 băng quấn','sp1',N' Khung vợt: Military Grade Carbon Fiber, Thân vợt: Military Grade Carbon Fiber',N'Công nghệ áp dụng lên cây vợt cầu lông Lining mới nhất Aeronaut 9000i Nội Địa',N'3 NĂM','LOAI11'),
('SP32',N'Vợt cầu lông Yonex Astrox 7', 1740000 ,N'Mua sản phẩm vợt được tặng 1 băng quấn','sp1',N' Khung vợt: GRAPHITE + Tungsten,Thân vợt: H.M. GRAPHITE + NANOMESH NEO ',N' Công nghệ được tích hợp trên vợt cầu lông tầm trung Yonex Astrox 7',N'3 NĂM','LOAI11'),
('SP33',N'Vợt cầu lông Proace Titanium 8', 1680000 ,N'Mua sản phẩm vợt được tặng 1 băng quấn','sp1',N' Khung vợt:  Graphite,Thân vợt: Graphite ',N' Công nghệ được tích hợp trên vợt cầu lông tầm trung Proace Titanium 8 ',N'3 NĂM','LOAI11'),
('SP34',N'Vợt cầu lông Yonex Voltric LT 25I',699000 ,N'Mua sản phẩm vợt được tặng 1 băng quấn','sp1',N' Khung vợt: Full Graphite,Thân vợt: Full Graphite ',N' Công nghệ được tích hợp trên vợt cầu lông tầm trung Yonex Voltric LT 25I',N'3 NĂM','LOAI11'),
('SP35',N'Vợt cầu lông Yonex Astrox LT 21I', 699000  ,N'Mua sản phẩm vợt được tặng 1 băng quấn','sp1',N'Khung vợt: Full Graphite,TThân vợt: Full Graphite ',N' Công nghệ được tích hợp trên vợt cầu lông tầm trung Yonex Astrox LT 21I',N'3 NĂM','LOAI11'),



('SP36',N'GIÀY YONEX SHB 65 Z MEN', 2189000 ,N'KHUYẾN MÃI: 01 ĐÔI VỚ TRỊ GIÁ 149.000 ','sp1',N'Cấu trúc mới của POWER CUSHION ＋ cho phép tạo ra một bước chân mới nhanh và nhẹ',N' ToughBrid Light,Power Cushion,Solid E.V.A.,T.P.U.,Power Graphite',N'2 NĂM','LOAI10'),
('SP37',N'GIÀY CẦU LÔNG YONEX COMFORT Z LADIES', 1990000 ,N'KHUYẾN MÃI: 01 ĐÔI VỚ TRỊ GIÁ 149.000 ','sp1',N'Cấu trúc mới của POWER CUSHION ＋ cho phép tạo ra một bước chân mới nhanh và nhẹ',N' ToughBrid Light,Power Cushion,Solid E.V.A.,T.P.U.,Power Graphite',N'2 NĂM','LOAI10'),
('SP38',N'Giày cầu lông Victor A362', 930000 ,N'KHUYẾN MÃI: 01 ĐÔI VỚ TRỊ GIÁ 149.000 ','sp1',N'Cấu trúc mới của POWER CUSHION ＋ cho phép tạo ra một bước chân mới nhanh và nhẹ',N' ToughBrid Light,Power Cushion,Solid E.V.A.,T.P.U.,Power Graphite',N'2 NĂM','LOAI10'),
('SP39',N'Giày cầu lông Yonex 65 X 2 Ladies ', 1839000 ,N'KHUYẾN MÃI: 01 ĐÔI VỚ TRỊ GIÁ 149.000 ','sp1',N'Cấu trúc mới của POWER CUSHION ＋ cho phép tạo ra một bước chân mới nhanh và nhẹ',N' ToughBrid Light,Power Cushion,Solid E.V.A.,T.P.U.,Power Graphite',N'2 NĂM','LOAI10'),
('SP40',N'Giày Cầu Lông Kawasaki 080  ', 649000,N'KHUYẾN MÃI: 01 ĐÔI VỚ TRỊ GIÁ 149.000 ','sp1',N'Cấu trúc mới của POWER CUSHION ＋ cho phép tạo ra một bước chân mới nhanh và nhẹ',N' ToughBrid Light,Power Cushion,Solid E.V.A.,T.P.U.,Power Graphite',N'2 NĂM','LOAI10'),
('SP41',N'Giày cầu lông Kawasaki 526  ', 1070000 ,N'KHUYẾN MÃI: 01 ĐÔI VỚ TRỊ GIÁ 149.000 ','sp1',N'Cấu trúc mới của POWER CUSHION ＋ cho phép tạo ra một bước chân mới nhanh và nhẹ',N' ToughBrid Light,Power Cushion,Solid E.V.A.,T.P.U.,Power Graphite',N'2 NĂM','LOAI10'),
('SP42',N'Giày cầu lông Yonex All England 17', 899000 ,N'KHUYẾN MÃI: 01 ĐÔI VỚ TRỊ GIÁ 149.000 ','sp1',N'Cấu trúc mới của POWER CUSHION ＋ cho phép tạo ra một bước chân mới nhanh và nhẹ',N' ToughBrid Light,Power Cushion,Solid E.V.A.,T.P.U.,Power Graphite',N'2 NĂM','LOAI10'),





('SP43',N'QUẦN BƠI BOXER 100',209000 ,N'Chương trình khuyến mãi mua 2 quần bơi tặng giảm 20k','sp1',N'CHỐNG TIẾP XÚC CLO,THOẢI MÁI VẬN ĐỘNG,Dễ điều chỉnh phần eo nhờ dải rút',N'Dành cho người mới bắt đầu bơi muốn tìm mua quần thoải mái và dễ mặc',N'1 NĂM','LOAI04'),
('SP44',N'Quần Bơi Jammer 100',245000 ,N'Chương trình khuyến mãi mua 2 quần bơi tặng giảm 20k','sp1',N'CHỐNG TIẾP XÚC CLO,THOẢI MÁI VẬN ĐỘNG,Dễ điều chỉnh phần eo nhờ dải rút',N'Dành cho người mới bắt đầu bơi muốn tìm mua quần thoải mái và dễ mặc',N'1 NĂM','LOAI04'),
('SP45',N'Quần Bơi Boxer B-Fit',229000 ,N'Chương trình khuyến mãi mua 2 quần bơi tặng giảm 20k','sp1',N'CHỐNG TIẾP XÚC CLO,THOẢI MÁI VẬN ĐỘNG,Dễ điều chỉnh phần eo nhờ dải rút',N'Dành cho người mới bắt đầu bơi muốn tìm mua quần thoải mái và dễ mặc',N'1 NĂM','LOAI04'),
('SP46',N'Quần Bơi Boxer Lửng',225000 ,N'Chương trình khuyến mãi mua 2 quần bơi tặng giảm 20k','sp1',N'CHỐNG TIẾP XÚC CLO,THOẢI MÁI VẬN ĐỘNG,Dễ điều chỉnh phần eo nhờ dải rút',N'Dành cho người mới bắt đầu bơi muốn tìm mua quần thoải mái và dễ mặc',N'1 NĂM','LOAI04'),




('SP47',N'Áo bóng chuyền Nam Hiwing FIVE – H5',169000  ,N'MIỄN PHÍ VẬN CHUYỂN ','sp1',N'Chất liệu: Sợi Tencel Siêu nhẹ',N'Được thiết kế theo phong cách trẻ trung & màu sắc tinh tế, với đặc tính nổi trội như mềm mại, độ bền cao',N'1 NĂM','LOAI02'),
('SP48',N'Áo bóng chuyền nam Hiwing Volverine H3',139000 ,N'MIỄN PHÍ VẬN CHUYỂN ','sp1',N'Chất liệu: Sợi Tencel Siêu nhẹ',N'Được thiết kế theo phong cách trẻ trung & màu sắc tinh tế, với đặc tính nổi trội như mềm mại, độ bền cao',N'1 NĂM','LOAI02'),
('SP49',N'Áo bóng chuyền Nữ Hiwing FIVE',169000  ,N'MIỄN PHÍ VẬN CHUYỂN ','sp1',N'Chất liệu: Sợi Tencel Siêu nhẹ',N'Được thiết kế theo phong cách trẻ trung & màu sắc tinh tế, với đặc tính nổi trội như mềm mại, độ bền cao',N'1 NĂM','LOAI02'),
('SP50',N'Áo bóng chuyền nam nữ K3(Đỏ)',139000  ,N'MIỄN PHÍ VẬN CHUYỂN ','sp1',N'Chất liệu: Sợi Tencel Siêu nhẹ',N'Được thiết kế theo phong cách trẻ trung & màu sắc tinh tế, với đặc tính nổi trội như mềm mại, độ bền cao',N'1 NĂM','LOAI02'),
('SP51',N'Áo bóng chuyền nam nữ K3(Trắng)',139000  ,N'MIỄN PHÍ VẬN CHUYỂN ','sp1',N'Chất liệu: Sợi Tencel Siêu nhẹ',N'Được thiết kế theo phong cách trẻ trung & màu sắc tinh tế, với đặc tính nổi trội như mềm mại, độ bền cao',N'1 NĂM','LOAI02'),
('SP52',N'Áo bóng chuyền nam nữ K3(Vàng)',139000  ,N'MIỄN PHÍ VẬN CHUYỂN ','sp1',N'Chất liệu: Sợi Tencel Siêu nhẹ',N'Được thiết kế theo phong cách trẻ trung & màu sắc tinh tế, với đặc tính nổi trội như mềm mại, độ bền cao',N'1 NĂM','LOAI02'),
('SP53',N'Áo bóng chuyền nam nữ K3(Xanh)',139000  ,N'MIỄN PHÍ VẬN CHUYỂN ','sp1',N'Chất liệu: Sợi Tencel Siêu nhẹ',N'Được thiết kế theo phong cách trẻ trung & màu sắc tinh tế, với đặc tính nổi trội như mềm mại, độ bền cao',N'1 NĂM','LOAI02'),
('SP54',N'Áo bóng chuyền nam nữ K3(Đen)',139000  ,N'MIỄN PHÍ VẬN CHUYỂN ','sp1',N'Chất liệu: Sợi Tencel Siêu nhẹ',N'Được thiết kế theo phong cách trẻ trung & màu sắc tinh tế, với đặc tính nổi trội như mềm mại, độ bền cao',N'1 NĂM','LOAI02'),


('SP55',N'Giày thể thao bóng chuyền Asics', 1200000 ,N'Chương trình khuyến mãi tặng vớ trị giá 50.000','sp1',N'Công nghệ đỉnh cao của Asics giúp tăng độ đàn hồi, chống sốc khi di chuyển cũng như bật nhảy',N'Giày thể thao bóng chuyền Asics chính hãng màu đen',N'3 NĂM','LOAI09'),
('SP56',N'Giày thể thao bóng chuyền Asics(Xanh biển)', 1200000 ,N'Chương trình khuyến mãi tặng vớ trị giá 50.000','sp1',N'Công nghệ đỉnh cao của Asics giúp tăng độ đàn hồi, chống sốc khi di chuyển cũng như bật nhảy',N'Giày thể thao bóng chuyền Asics chính hãng màu đen',N'3 NĂM','LOAI09'),
('SP57',N'Giày bóng chuyền Mizuno(Xanh)', 590000 ,N'Chương trình khuyến mãi tặng vớ trị giá 50.000','sp1',N'Công nghệ đỉnh cao của Mizuno giúp tăng độ đàn hồi, chống sốc khi di chuyển cũng như bật nhảy',N'Giày thể thao bóng chuyền Mizuno chính hãng màu đen',N'3 NĂM','LOAI09'),
('SP58',N'Giày bóng chuyền Mizuno(Vàng)', 590000 ,N'Chương trình khuyến mãi tặng vớ trị giá 50.000','sp1',N'Công nghệ đỉnh cao của Mizuno giúp tăng độ đàn hồi, chống sốc khi di chuyển cũng như bật nhảy',N'Giày thể thao bóng chuyền Mizuno chính hãng màu đen',N'3 NĂM','LOAI09'),
('SP59',N'Giày bóng chuyền Mizuno(Vàng)', 590000 ,N'Chương trình khuyến mãi tặng vớ trị giá 50.000','sp1',N'Công nghệ đỉnh cao của Mizuno giúp tăng độ đàn hồi, chống sốc khi di chuyển cũng như bật nhảy',N'Giày thể thao bóng chuyền Mizuno chính hãng màu đen',N'3 NĂM','LOAI09'),
('SP60',N'Giày bóng chuyền Mizuno(Đỏ)', 590000 ,N'Chương trình khuyến mãi tặng vớ trị giá 50.000','sp1',N'Công nghệ đỉnh cao của Mizuno giúp tăng độ đàn hồi, chống sốc khi di chuyển cũng như bật nhảy',N'Giày thể thao bóng chuyền Mizuno chính hãng màu đen',N'3 NĂM','LOAI09'),
('SP61',N'Giày bóng chuyền Mizuno(Đen)', 590000 ,N'Chương trình khuyến mãi tặng vớ trị giá 50.000','sp1',N'Công nghệ đỉnh cao của Mizuno giúp tăng độ đàn hồi, chống sốc khi di chuyển cũng như bật nhảy',N'Giày thể thao bóng chuyền Mizuno chính hãng màu đen',N'3 NĂM','LOAI09')




INSERT INTO LOAIKHACH
VALUES 
('LK01',N'MEMBER','0'),
('LK02',N'MEMBER SILVER', '5'),
('LK03',N'MEMBER GOLD', '10'),
('LK04',N'MEMBER DIAMOND',' 20')


SET DATEFORMAT DMY
INSERT INTO KHACHHANG
VALUES
('KH01',N'NGUYỄN VŨ',N'NAM','13/09/2000',N'121 TRẦN QUANG ĐẠO',0939281841,10,'LK02'),
('KH02',N'TRẦN QUANG MINH',N'NAM','21/03/2001',N'50 TRẦN DUY HƯNG',0938134842,2,'LK01'),
('KH03',N'NGUYỄN THỤY TÂM ĐAN',N'NỮ','20/07/2003',N'12 TRẦN HƯNG ĐẠO',05858881309,3,'LK01'),
('KH04',N'NGUYỄN TIẾN GIA HUY',N'NAM','08/08/2000',N'52 CÁCH MẠNG THÁNG 8',09381747111,20,'LK03'),
('KH05',N'VŨ ĐỨC DUY',N'NAM','12/8/2003',N'25 TRẦN QUANG KHẢI',0581474711,23,'LK03'),
('KH06',N'NGUYỄN MINH SƠN',N'NAM','21/03/2002',N'1 LÊ VĂN SỸ',07829184741,30,'LK04')


INSERT INTO KHO
VALUES 
('KHO01',N'KHO 1',N'NGUYỄN VĂN A',0931848821,N'1 NGUYỄN BẶC','KV01'),
('KHO02',N'KHO 2',N'NGUYỄN VĂN B',0938917733,N'1 DƯƠNG BÁ TRẠC','KV01'),
('KHO03',N'KHO 3',N'NGUYỄN VĂN C',0581757111,N'3 VÕ VĂN TẦN','KV02'),
('KHO04',N'KHO 4',N'NGUYỄN VĂN D',0194848113,N'42 NGUYỄN BỬU','KV03')

INSERT INTO KHO
VALUES 
('KHO05',N'KHO 5',N'NGUYỄN VĂN K',0194848103,N'42 NGUYỄN BỬU','KV02'),
('KHO06',N'KHO 6',N'NGUYỄN VĂN H',0194848013,N'42 NGUYỄN BỬU','KV03')


INSERT INTO CHITIETKHO
VALUES 
('KHO01','SP01',23),
('KHO02','SP02',17),
('KHO03','SP03',11),
('KHO04','SP04',10),
('KHO04','SP05',11),
('KHO02','SP06',30),
('KHO01','SP07',40),
('KHO03','SP08',16),
('KHO02','SP09',22),
('KHO01','SP11',32),
('KHO02','SP12',33),
('KHO03','SP13',35),
('KHO03','SP14',10),
('KHO04','SP15',2),
('KHO01','SP16',32),
('KHO02','SP17',13),
('KHO02','SP18',12),
('KHO03','SP19',11),
('KHO01','SP20',5)


SET DATEFORMAT DMY
INSERT INTO NHAPHANG
VALUES 
('NH01','13/02/1999','KHO01',100000000,''),
('NH02','11/05/2000','KHO02',300000000,''),
('NH03','13/07/1999','KHO03',300000000,''),
('NH04','22/02/2001','KHO04',200000000,''),
('NH05','12/06/1998','KHO01',200000000,'')


INSERT INTO CHITIETNHAPHANG
VALUES
('NH01','SP01',10000000,35,'KHO01'),
('NH02','SP09',20000000,20,'KHO02'),
('NH03','SP11',1000000,40,'KHO03'),
('NH04','SP04',3000000,35,'KHO04'),
('NH05','SP19',2000000,35,'KHO01')


INSERT INTO HOADON
VALUES 
('HD01','13/02/1999','KH01','',1600000,'','KHO02'),
('HD02','1/02/2005','KH02','',1600000,'','KHO04'),
('HD03','30/04/2004','KH03','',230000000,'','KHO03'),
('HD04','23/02/2021','KH06','',300000000,'','KHO01'),
('HD05','13/02/2011','KH04','',60000000,'','KHO01'),
('HD06','30/04/2004','KH01','',230000000,'','KHO03'),
('HD07','23/02/2021','KH06','',300000000,'','KHO01'),
('HD08','13/02/2011','KH02','',60000000,'','KHO01')
INSERT INTO CTHD
VALUES 
('HD01','SP11',2,30000000,'KHO01','CH01'),
('HD02','SP02',1,30000000,'KHO01','CH01'),
('HD03','SP17',1,40000000,'KHO01','CH01'),
('HD04','SP09',3,170000000,'KHO01','CH02'),
('HD05','SP10',2,35000000,'KHO01','CH02'),
('HD06','SP02',1,45000000,'KHO01','CH03'),
('HD07','SP17',1,10000000,'KHO01','CH03'),
('HD08','SP01',3,170000000,'KHO01','CH04')



INSERT INTO CHUONGTRINHKHUYENMAI
VALUES 
('KM01',N'KHUYẾN MÃI MUA 1 TẶNG 1','','LK01'),
('KM02',N'KHUYẾN MÃI DỊP TẾT 5% MỌI SẢN PHẨM','','LK01'),
('KM04',N'KHUYẾN MÃI NOEL','','LK01'),
('KM05',N'KHUYẾN MÃI TẾT','','LK01'),

('KM06',N'KHUYẾN MÃI MUA 1 TẶNG 1','','LK02'),
('KM08',N'KHUYẾN MÃI NOEL','','LK02'),
('KM09',N'KHUYẾN MÃI TẾT','','LK02'),

('KM10',N'KHUYẾN MÃI MUA 1 TẶNG 1','','LK03'),
('KM11',N'KHUYẾN MÃI NOEL','','LK03'),
('KM12',N'KHUYẾN MÃI TẾT','','LK03'),

('KM13',N'KHUYẾN MÃI MUA 1 TẶNG 1','','LK04'),
('KM14',N'KHUYẾN MÃI NOEL','','LK01'),
('KM15',N'KHUYẾN MÃI TẾT','','LK02')


select * from CTHD,