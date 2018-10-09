create database PaddyStudio
go

use PaddyStudio
go

create table tbUser
(
	UserID varchar(20) primary key nonclustered,
	FullName nvarchar(40) not null,
	UserPassword varchar(20) not null,
	UserEmail varchar(50) unique not null,
	UserAddress nvarchar(300),
	UserPhone varchar(20)	
);
go

create table tbBrand
(
	BrandName varchar(20) primary key nonclustered,
	BrandDescription nvarchar(200),
	BrandLogo varchar(200) not null
);
go

create table tbProduct
(
	ProductID int identity(1,1) primary key nonclustered,
	ProductName varchar(50) unique not null,
	ProductImage varchar(200) not null,
	ProductDescription nvarchar(500) not null,
	Price int check(Price>=0) default 0,
	WarrantyTime int check(WarrantyTime>=0 and WarrantyTime <=60) not null,
	ManufacturerYear smallint check(ManufacturerYear<=year(getdate()) and ManufacturerYear >1980) default year(getdate()) not null,
	BrandName varchar(20) foreign key references tbBrand(BrandName) not null
);
go

create table tbAdmin
(
	Username varchar(50) primary key nonclustered,
	[Password] varchar(20) not null	
);
go

/*create table tbComment
(
	CommentID int identity(1,1) primary key nonclustered,
	CommentContent nvarchar(500) not null,
	CommentDate datetime check(CommentDate<=getdate()) default getdate() not null,
	CommentUserID varchar(20) foreign key references tbUser(UserID) not null,
	CommentReply nvarchar(500),
	CommentReplyDate datetime,
	CommentUserReplyID varchar(20) foreign key references tbUser(UserID),
	ProductID int foreign key references tbProduct(ProductID) not null
);
go*/

create table tbFeedback
(
	FeedbackID int identity(1,1) primary key nonclustered,
	FeedbackSubject nvarchar(20) not null,
	FeedbackContent nvarchar(500) not null,
	FeedbackDate datetime check(FeedbackDate<=getdate()) default getdate() not null,
	FeedbackMemberID varchar(20) foreign key references tbUser(UserID) not null,
	FeedbackReply nvarchar(500),
	FeedbackReplyDate datetime,
	FeedbackAdminReplyID varchar(50)foreign key references tbAdmin(Username)
);
go

alter table tbFeedback
add check(FeedbackReplyDate>=FeedbackDate and FeedbackReplyDate<=getdate())
go

create table tbEventAndNews
(
	EventID int identity(1,1) primary key nonclustered,
	EventSummary nvarchar(100) not null,
	EventContent nvarchar(max) not null,
	EventDate datetime check(EventDate<=getdate()) default getdate() not null,
	EventDuration nvarchar(100),
	EventImage varchar(200)
);
go

insert tbUser values
('U01',N'Trương Đình Giang','123456','giang.itk10@gmail.com','Ho Chi Minh City','0962502799'),
('U02',N'Đào Thiện Hoàng Huy','123456','huyhoang0@gmail.com','Ho Chi Minh City','0942327885'),
('U03',N'An Tinh','123456','an123@gmail.com','Ho Chi Minh City','0948277065'),
('U04','Kevin Tran','abcd123','kev@gmail.com','New York','0913345678'),
('U05','Sam Winchester','abcd123','sammy@yahoo.com','Texas','0945345623'),
('U06','Calvin Harris','abcd123','calv@gmail.com','Washington','0989345126')
go

insert tbAdmin values
('A01','123abc'),
('A02','123abc')
go

insert tbBrand values
('Dell',N'Dell là một công ty đa quốc gia của Hoa Kỳ về công nghệ máy tính có trụ sở tại Texas, Hoa Kỳ. Dell được thành lập năm 1984 bởi Michael Dell.','dell.jpg'),
('Asus',N'ASUSTeK Computer Incorporated (ASUS) là một tập đoàn đa quốc gia đặt trụ sở tại Đài Loan chuyên sản xuất các mặt hàng điện tử','asus.jpg'),
('HP',N'Hewlett-Packard (viết tắt HP) là tập đoàn công nghệ thông tin lớn nhất thế giới. HP thành lập năm 1939 tại Palo Alto, California, Hoa Kỳ.','hp.jpg'),
('Apple',N'Apple là tập đoàn công nghệ máy tính của Mỹ có trụ sở chính đặt tại San Francisco,California. Apple được thành lập ngày 1/4/1976.','apple.jpg'),
('Acer',N'Acer là tập đoàn đa quốc gia về thiết bị điện tử và phần cứng máy tính của Đài Loan.Các sản phẩm của Acer bao gồm các loại máy tính để bàn,laptop PC, server,...','acer.jpg')
go

insert tbProduct values
('Dell XPS13 9350-6YJ60','01-Dell.jpg',N'- Intel Core i7-6500U (2X2.5GHz) Max Turbo Frequency 3.10GHz - 4MB<br/>
- DDRAM 8GB LPDDR3/1867MHz Onboard (không upgrade)<br/>
- SSD 256G (M.2 2280)<br/>
- Intel HD Graphics 520<br/>
- Realtek high Definition Audio<br/>
- 13.3" UltraSharp QHD Touch (3200x1800) - Webcam<br/>
- Ko Lan - Wifi - Bluetooth<br/>
- Reader - 1x USB Type C port, 2xUSB 3.0, LED_KB<br/>
- Weight 1.29kg - Battery 4Cell<br/>
- OS Windows 10 Home SL 64 bit+ Office Personal 365<br/>','43990000','12','2013','Dell'
),

('Dell XPS15 9550-FYK3F1','02-Dell.jpg','- Intel Core i5 6300HQ 2.3GHz - 6M<br/>
- DDRAM 2x4GB DDR4/2133 (2 slot)<br/>
- HDD 1TB 5400rpm + 32GB SSD<br/>
- NVIDIA GF GTX960M 2GB GDDR5 128bit // Intel HD Graphics 530<br/>
- 15.6" FHD InfinityEdge (1920x1080) - HDMI, Thunderbolt-3 (USB Type-C) - Webcam<br/>
- No DVD<br/>
- No Lan - Wifi AC - Bluetooth<br/>
- Reader - 2xUSB 3.0, LED_KB<br/>
- Weight 1.78Kg - Battery 3 Cell<br/>
- OS Windows 10 Home SL 64bit + Office Personal 365<br/>','39990000','12','2014','Dell'
),

('Dell 7447-MJWKV2','03-Dell.jpg','- Intel Core i7 4720HQ 2.6GHz - 6M<br/>
- DDRAM 2x4GB/DDR3L-1600 (2 slot)<br/>
- HDD 1TB SSHD with 8GB Flash Drive<br/>
- NVIDIA GF GTX 850M 4GB DDR3 128bit  //  Intel HD Graphics 4600<br/>
- 14" IPS FHD Led (1920x1080) - HDMI - Webcam <br/>
- DVDRW <br/>
- Lan 1G - Wifi AC - Bluetooth 4.0<br/>
- Reader - 2xUSB 3.0, USB 2.0, LED KB<br/>
- Weight 2.23Kg - Battery 6 Cell<br/>
- OS Windows 8.1 SL 64 bit<br/>','23300000','12','2012','Dell'
),

('Dell Inspiron 7359-C3I5019W','04-Dell.jpg','- Intel Core i5 6200U 2.3GHz - 3M<br/>
- DDRAM 1x4GB/1600 (1 slot)<br/>
- HDD 500GB 5400rpm<br/>
- Intel HD Graphics 520<br/>
- 13.3" IPS HD Led Touch Xoay 360 độ (1366x768) - HDMI - Webcam<br/>
- No DVD<br/>
- No Lan - Wifi AC - Bluetooth<br/>
- Reader - 3xUSB 3.0<br/>
- Weight 1.66Kg - Battery 3Cell<br/>
- OS Windows 10 Home 64bit with Office 365<br/>','20490000','12','2014','Dell'
),

('Dell Inspiron 5459-WX9KG1','05-Dell.jpg','- Intel Core i5 6200U 2.3GHz - 3M<br/>
- DDRAM 1x4GB/1600 (2 Slot)<br/>
- HDD 500GB 5400rpm<br/>
- AMD Radeon R5 M335 2GB DDR3 32bit // Intel HD Graphics 520<br/>
- 14" HD Led (1366x768) - HDMI - Webcam<br/>
- DVD-RW<br/>
- Lan 10/100 - Wifi AC - Bluetooth<br/>
- Reader - USB 3.0, 2xUSB 2.0, LED_KB<br/>
- Weight 2.0Kg - Battery 4 Cell<br/>
- OS Windows 10 Home SL 64bit + Office Personal 365<br/>','19549000','12','2014','Dell'
),

('Asus G751JY-T7235D','11-Asus.jpg','- Intel Core i7 4720HQ 2.6GHz - 6M<br/>
- DDRAM 2x8GB/1600 (2 slot)<br/>
- HDD 1TB SATA 3 7200rpm with 128GB SATA 3 SSD<br/>
- NVIDIA GF GTX 980M 4GB DDR5<br/>
- Blu-Ray RW<br/>
- Card Reader 2.1 - 4x USB 3.0<br/>
- 17.3" Led back-lit (1920x1080) - HDMI & S/P Display port - Webcam<br/>
- LAN 10/100/1000 - Wireless - Bluetooth 4.0<br/>
- Weight 2.8Kg - 8 cell (88Wh)<br/>
- OS Option<br/>','42990000','24','2015','Asus'
),

('Asus G501JW-CN217','12-Asus.jpg','- Intel Core i7 4720HQ 2.6GHz - 6M<br/>
- DDRAM 8GB onboard + 1x8GB/1600 (1 Slot)<br/>
- HDD 1TB 5400rpm + 128GB SSD<br/>
- NVIDIA GF GTX 960M 4GB DDR5 // Intel HD Graphics 4600<br/>
- 15.6" FHD WV Led (1920x1080) - HDMI, mini Display port - Webcam<br/>
- No DVD<br/>
- Lan 10/100 (USB->Lan) - Wifi AC - Bluetooth<br/>
- Reader - 3x USB 3.0, LED_KB<br/>
- Weight 2.06kg - Battery 4Cell<br/>
- OS Option<br/>','29990000','24','2014','Asus'
),

('Asus Zenbook UX501JW-CN128T','13-Asus.jpg','- Intel Core i7 4720HQ 2.6GHz - 6M<br/>
- DDRAM 4GB onboard + 4GB/1600 (1 slot)<br/>
- HDD 128GB SSD + 1TB 5400rpm<br/>
- NVIDIA GF GTX 960M 2GB GDDR5 128bit // Intel HD Graphics 4600<br/>
- 15.6" IPS FHD Led (1920x1080) - HDMI, mini Display port - Webcam  <br/>
- No Lan - Wifi AC - Bluetooth<br/>
- Reader - 3xUSB 3.0, LED_KB<br/>
- Weight 2.2Kg - Battery 4Cell<br/>
- OS Windows 10 Home SL 64Bit<br/>','26990000','24','2012','Asus'
),

('Asus UX305CA-FC013T','14-Asus.jpg','- Intel Core i5 6200U 2.3GHz - 3M<br/>
- DDRAM 8GB/1600 onboard (Ko upgrade)<br/>
- SSD 256GB M.2<br/>
- Intel HD Graphics 520<br/>
- 13.3" FHD WV Led (1920x1080) - micro HDMI -  Webcam<br/>
- No DVD<br/>
- Lan 10/100 (USB->Lan) - Wifi - Bluetooth<br/>
- Reader - 3xUSB 3.0, USB 2.0<br/>
- Weight 1.3Kg - Battery 3Cell<br/>
- OS Windows 10 Home SL 64bit<br/>','42990000','24','2013','Asus'
),

('Asus UX303UA-R4039T','15-Asus.jpg','- Intel Core i5 6200U 2.3GHz - 3M<br/>
- DDRAM 4GB/1600 onboard (1 slot)<br/>
- SSD 128GB<br/>
- Intel HD Graphics 520<br/>
- 13.3" IPS FHD Led (1920x1080) - HDMI, mini Display port - Webcam<br/>
- No DVD<br/>
- No LAN -  Wifi AC - Bluetooth<br/>
- Reader - 3.0, 1xmini SSD, LED_KB<br/>
- Weight 1.45 Kg - Battery 3 Cell<br/>
- OS Windows 10 Home SL 64 bit<br/>','19500000','24','2014','Asus'
),

('HP 14-ac180TU','21-hp.jpg','- Intel Core i7 6500U  2.5GHz - 4M<br/>
- DDRAM 8GB/1600<br/>
- HDD 1TB 5400rpm<br/>
- NVIDIA GF 940M 2GB // Intel HD Graphics 520<br/>
- 15.6" Led Touch - HDMI - Webcam<br/>
- No DVD<br/>
- Lan - Wifi AC - Bluetooth<br/>
- Reader - USB 3.0, 2xUSB 2.0<br/>
- Weight 2Kg - Battery 4Cell<br/>
- OS Windows 10 64bit<br/>','24990000','12','2014','HP'
),

('HP Envy 15 ae130TX','22-hp.jpg','- Intel Core i7 6500U 2.5GHz - 4M<br/>
 - DDRAM 2x4GB/1600 (2 slot)<br/>
- HDD 1TB 5400rpm<br/>
- AMD Radeon R7 M340 2GB // Intel HD Graphics 520<br/>
- 15.6" HD WLed (1366x768) - HDMI, VGA - Webcam<br/>
- DVD-RW<br/>
- Lan 1G - Wifi - Bluetooth<br/>
- Reader - 2xUSB 3.0, 2xUSB 2.0, M.2 2280, Finger Print<br/>
- Weight 2.23Kg - Battery 4Cell<br/>
- OS Option<br/>','19990000','12','2015','HP'
),

('HP Probook 450 G3-T1A16PA','23-hp.jpg','- Intel Core i5 6200U 2.3GHz - 3M<br/>
- DDRAM 1x8GB/1600 (2 slot)<br/>
- HDD 1TB 5400rpm<br/>
- AMD Radeon R7 M340 2GB // Intel HD Graphics 520<br/>
- 15.6" HD WLed (1366x768) - HDMI, VGA - Webcam<br/>
- DVD-RW<br/>
- Lan 1G - Wifi - Bluetooth<br/>
- Reader - 2xUSB 3.0, 2xUSB 2.0, Finger Print<br/>
- Weight 2.07Kg - Battery 4Cell<br/>
- OS Option<br/>','16690000','12','2013','HP'
),

('HP Probook 450-T9S21PA','24-hp.jpg','- Intel Core i5 6200U 2.3GHz - 3M<br/>
- DDRAM 1x4GB/1600 (2 slot)<br/>
- HDD 500GB 5400rpm<br/>
- AMD Radeon R5 M330 2GB // Intel HD Graphics 520<br/>
- 15.6" HD WLed (1366x768) - HDMI - Webcam  <br/>
- DVD-RW<br/>
- Lan 10/100 - Wifi - Bluetooth<br/>
- Reader - 2xUSB 3.0, USB 2.0<br/>
- Weight 2.23Kg - Battery 4Cell<br/>
- OS Windows 10 Home SL 64bit<br/>','14690000','12','2012','HP'
),

('HP 15-ac605TX','25-hp.jpg','- Intel Core i5 6200U 2.3GHz - 3MB<br/>
- DDRAM 1x4GB/1600 (2 slots)<br/>
- HDD 500GB 5400rpm<br/>
- Intel HD Graphics 520-WIN10x64:2110MB<br/>
- 14.0" HD WLed (1366 x 768) - HDMI, VGA - Webcam<br/>
- DVD-RW<br/>
- Lan 10/100 - Wifi - Bluetooth<br/>
- Reader - USB 3.0, 2xUSB 2.0<br/>
- Weight 1.94kg - Battery 4Cell<br/>
- OS Winndows 10 Home SL 64 bit <br/>','12690000','12','2012','HP'
),

('MacBook Pro MF841','31-mac.jpg','- Intel Core i5  2.9GHz - 3M<br/>
- Ram 8GB<br/>
- SSD 512GB<br/>
- Intel Iris Pro Graphics<br/>
- 13.3" Retina -  Webcam <br/>
- Wifi, Bluetooth<br/>
- USB 3.0<br/>
- Mac OS X<br/>','40200000','12','2014','Apple'
),

('Macbook Pro MF840ZP','32-mac.jpg','- Intel Core i5 5257U 2.7GHz - 3M<br/>
- SDRAM 8GB/1600<br/>
- HDD 256GB PCIe<br/>
- Intel Iris Pro Graphic 6100<br/>
- No DVD<br/>
- 13.3" Retina - HDMI - Thunderbolt<br/>
- USB 3.0 - Magsafe 2 - Card Reader<br/>
- LAN Dongle - Wireless AC - Bluetooth 4.0<br/>
- Weight 1.58kg - Battery 71.8Whr<br/>
- OS OS X<br/>','33600000','12','2014','Apple'
),

('MacBook 12 MK4M2X','33-mac.jpg','- Intel Core M-5Y31 1.1GHz - 4M<br/>
- Ram 8GB<br/>
- SSD 256GB<br/>
- Intel HD Graphics 5300<br/>
- 12" - Webcam <br/>
- Wifi - Bluetooth<br/>
- USB C<br/>
- Mac OS X<br/>','30200000','12','2013','Apple'
),

('Macbook Pro MF839ZP','34-mac.jpg','- Intel Core i5 5257U 2.7GHz - 3M<br/>
- SDRAM 8GB/1600<br/>
- HDD 128GB Flash<br/>
- Intel Iris Pro Graphic 6100<br/>
- No DVD<br/>
- 13.3" Retina - HDMI - Thunderbolt<br/>
- USB 3.0 - Magsafe 2 - Card Reader<br/>
- LAN Dongle - Wireless AC - Bluetooth 4.0<br/>
- Weight 1.58kg - Battery 71.8Whr<br/>
- OS OS X<br/>','28750000','12','2013','Apple'
),

('MacBook Air MJVM2ZA','35-mac.jpg','- Intel Core i5 5250U 1.6GHz - 3M<br/>
- DDRAM 4GB/1600 onboard<br/>
- 128GB Flash<br/>
- Intel HD Graphics 6000 <br/>
- 11.6" (1366x768) - Webcam <br/>
- Wifi AC - Bluetooth <br/>
- Weight 1.08Kg <br/>
- Mac OS X Lion<br/>','20750000','12','2015','Apple'
),

('Acer S7-393-55208G12ews','41-acer.jpg','- Intel Core i5 5200U 2.2GHz - 3M<br/>
- DDRAM 1x8GB/1600 onboard (Ko upgrade)<br/>
- SSD 128GB (RAID 0)<br/>
- Intel HD Graphics 5500<br/>
- 13.3" IPS FHD Led Touch (1920x1080) - HDMI, mini Display port - Webcam<br/>
- No DVD<br/>
- Lan 10/100 (USB->Lan) - Wifi AC - Bluetooth<br/>
- Reader - 2xUSB 3.0, LED KB<br/>
- Weight 1.3Kg - Battery 4Cell<br/>
- OS Windows 10 Home SL 64bit<br/>','29000000','24','2015','Acer'
),

('Acer Nitro VN7-592G-77DU','42-acer.jpg','- Intel Core i7 6700HQ 2.6GHz - 6M<br/>
- DDRAM 1x8GB DDR4/2133 (2 slot)<br/>
- SSHD 1TB 5400rpm with 8GB SSD Flash<br/>
- NVIDIA GF GTX 960M 4GB GDDR5 128bit // Intel HD Graphics 530<br/>
- 15.6" IPS FHD Led (1920x1080) - HDMI - Webcam<br/>
- No DVD<br/>
- Lan 1G - Wifi AC - Bluetooth<br/>
- Reader - 2xUSB 3.0, USB 2.0, 1xType C port, LED_KB<br/>
- Weight 2.3Kg - Battery 3Cell<br/>
- OS Linpus Linux<br/>','26500000','24','2014','Acer'
),

('Acer Nitro VN7-571G-58CT','43-acer.jpg','- Intel Core i5-5200U 2.20GHz - 3M<br/>
- DDRAM 1x4GB/DDR3L-1600 (2 slot)<br/>
- HDD 1TB 5400rpm<br/>
- NVIDIA GF 850M 4GB VDDR3 // Intel HD 5500<br/>
- 15.6" IPS FHD Led (1920x1080) - HDMI<br/>
- DVD-RW<br/>
- Card Reader - 3x USB 3.0<br/>
- Lan 10/100/1000 - Wireless N - Bluetooth 4.0<br/>
- Weight 2.4Kg - Battery 4605mAh<br/>
- OS Linux<br/>','17490000','24','2014','Acer'
),

('Acer E5-573G-784L','44-acer.jpg','- Intel Core i7 4510U 2.0GHz - 4M<br/>
- DDRAM 1x4GB/1600 (2 slot)<br/>
- HDD 500GB 5400rpm<br/>
- NVIDIA GF 920M 2GB // Intel HD Graphics 4400<br/>
- 15.6" HD Led (1366x768) - VGA, HDMI - Webcam<br/>
- DVD-RW<br/>
- Lan 1G - Wifi AC - Bluetooth<br/>
- Reader - USB 3.0, USB 2.0<br/>
- Weight 2.4Kg - Battery 4Cell<br/>
- OS Windows 10 Home SL 64bit<br/>','14490000','24','2014','Acer'
),

('Acer E5-573G-557P','45-acer.jpg',N'- Intel Core i5 5200U 2.2GHz - 3M<br/>
- DDRAM 4GB DDR3L (còn 1 slot trống)<br/>
- HDD 500GB<br/>
- NVDIA GF 920M 2GB // Intel HD Graphics 5500<br/>
- 15.6" HD(1366x768) - VGA, HDMI -  Webcam<br/>
- DVD-RW<br/>
- Lan 1G - Wifi - Bluetooth<br/>
- Reader - USB 3.0<br/>
- Battery 4 Cell<br/>
- OS Windows 10 Home SL 64bit<br/>','13490000','24','2015','Acer'
)
go

/*insert tbComment values
(N'Cho em hỏi laptop Acer E5 557P giá hiện tại là bao nhiêu','2015-08-03','U01',N'Giá 13.490.000 nhé bạn','2015-08-04','A02','25'),
(N'Nếu theo ngành thiết kế đồ họa, em nên chọn Asus G751JY hay Asus UX303UA ?','2015-08-05','U02',N'Chiếc Asus G7 phù hợp hơn, vì có hỗ trợ card rời','2015-08-07','A04','20'),
(N'Giữa MacBook Pro và Air, cái nào thuận lợi cho việc di chuyển hơn ?','2015-09-02','U03',N'Khuyến khích anh chọn MacBook Air, vì độ dày của máy chỉ bằng 1/2 so với bản Pro','2015-09-03','A01','25'),
(N'Có thể cài Windows 10 trên Macbook được không ?','2015-10-31','U03',N'Được, bạn có thể cài Windows 10 thêm hoặc chạy song song với OSX','2015-11-01','A03','25'),
(N'Cho mình hỏi vỏ laptop có bền không, có cần mua case thêm không','2015-07-02','U02',N'Máy đã qua các bài test của Nhà sản suất. Bạn có thể yên tâm sử dụng nhé','2015-09-02','A01','25')
go*/

insert tbFeedback values
(N'Website có ích',N'Website có ích trong việc lựa chọn các mẫu laptop, các admin tư vấn phù hợp với nhu cầu','2015-10-24','U01',N'Cám ơn bạn. Chúng tôi sẽ cố gắng hoàn thiện trang web hơn','2015-10-24','A02'),
(N'Góp ý',N'Mong các admin trong tương lai cố gắng hồi đáp nhanh hơn những thắc mắc, nhu cầu tư vấn của mem nhé','2016-01-22','U03',N'Cám ơn bạn đã góp ý. Hiện nay đội ngũ admin còn hạn chế, nhưng chúng tôi sẽ cố gắng phản hồi nhanh hơn','2016-01-22','A01'),
(N'Thêm Sản Phẩm',N'Website cần có nhiều sản phẩm hơn','2016-01-22','U02',N'Cám ơn bạn đã góp ý. Chúng tôi sẽ bổ sung thêm sản phẩm trong tương lai','2016-01-22','A01'),
(N'Giao diện website',N'Mong các anh cải tiến giao diện trang web để dễ sử dụng hơn nhé','2016-02-24','U01',N'Cám ơn bạn đã góp ý','2016-02-24','A01'),
(N'Vấn đề đường truyền',N'Chả hiểu sao em vào web load rất chậm, mong admin nâng cấp đường truyền','2016-01-02','U03',N'Cá mập cắn cáp, vài tuần tới chúng tôi sẽ ổn định hơn','2016-01-31','A02')
go

insert tbEventAndNews values
(N'Dock Continuum biến HP Elite x3 thành laptop: không đơn giản như bạn nghĩ',
N'HP Elite x3 là một chiếc điện thoại Windows 10 Mobile có thiết kế khá ấn tượng vừa ra mắt ở MWC 2016, nhưng đó chưa phải là điểm đáng chú ý nhất của nó. Elite x3 có khả năng chạy Continuum, nhưng không chỉ gắn ra màn hình ngoài như Lumia 950, 950 XL mà còn có thể gắn cáp vào một cái dock 12,5" để chạy như laptop. Dock này mang tên Mobile Extender, nó mỏng, nhẹ, thiết kế đẹp mắt, lại có thêm pin riêng trong đó và có thêm 3 cổng USB-C nữa để bạn chép dữ liệu hay đọc file chứa trong ổ USB. Máy có trọng lượng chỉ 1kg và mỏng 13.8 mm. So với việc chạy Continuum với desktop thì kiểu của Elite x3 sẽ tạo ra sự linh hoạt cao hơn, nhất là trong môi trường doanh nghiệp, nhóm khách hàng mà HP hướng tới cho sản phẩm này.<br/><br/>
<b>Lý do xuất hiện của Mobile Extender?</b><br/><br/>
Câu hỏi đầu tiên mà bạn sẽ nghĩ đến là: Ủa giải pháp này có ý nghĩa gì? Nó giúp gì được cho người dùng? Hiện tại đi làm, đi học cũng đã xách 2 máy rồi mà, một smartphone, một laptop, đâu có gì lạ?<br/><br/>
Tuy nhiên, chúng ta cần nhớ rằng Elite x3 nhắm đến cách người dùng trong các cơ quan, tổ chức, và ý định của HP ở đây đó là khi bạn từ nhà đi lên công ty, bạn chỉ cần xách theo cái điện thoại thôi là đủ rồi. Lên tới công ty thì dock Mobile Extender sẽ nằm sẵn trên bàn làm việc của bạn, bạn gắn điện thoại vô và bắt đầu làm việc của mình. Tức là về lý thuyết, bạn sẽ bớt được việc mang theo cả một cái máy tính bên mình khi đi làm, đúng với mục tiêu của Continuum.<br/><br/>
Continuum của Lumia 950 và 950 XL cũng làm được chuyện tương tự, nhưng vấn đề là Microsoft chưa bao giờ ra mắt sản phẩm nào tương tự như dock của HP cả nên chúng ta chỉ có thể cắm nó vào màn hình để bàn mà thôi. Nếu ghim vào màn hình máy bàn thì xem như là đang xài desktop rồi, vậy khi bạn cần cầm máy tính của mình đi sang bộ phận khác để bàn chuyện, đem vào phòng họp hay đi ra ngoài gặp đối tác thì không thể được. Bạn có vác theo cái màn hình đi vòng vòng trong cơ quan không?<br/><br/>
Đây chính là vấn đề mà Mobile Extender được sinh ra để giải quyết. Khi bạn kết nối Elite x3 vào Mobile Extender, bạn đã có một cái laptop trong tay. Giờ thì bạn muốn mang nó đi đâu thì tùy ý bạn. Nó có pin trong đó, có loa trong đó, có cả 3 cổng USB-C và 1 cổng microHDMI nên bạn hoàn toàn có thể dùng chiếc "laptop" này để chép dữ liệu hay xuất hình ra máy chiếu trong những trường hợp cần di động.<br/><br/>
Ngay cả khi bạn không thường đi tới đi lui thì Mobile Extender cũng có những lợi ích lớn về mặt không gian. Chiếc laptop này rõ ràng nhỏ gọn hơn so với việc bố trí một cái bàn phím, con chuột và một cái màn hình mấy chục inch trên bàn làm việc. Với bạn thì có thể đây không là vấn đề, nhưng với bộ phận nhân sự trong các cơ quan thì nó quan trọng vì việc thu gọn diện tích của mỗi người giúp họ có thể bố trí chỗ ngồi tốt hơn.<br/><br/>
Bộ phận IT của cơ quan cũng sẽ rất "khỏe" nếu Mobile Extender có thể được tích hợp vào quy trình làm việc của công ty. Lý do là vì bây giờ họ chỉ cần phải bảo trì và quản lý những chiếc điện thoại Elite x3 mà thôi, không cần phải vừa bảo trì điện thoại vừa bảo trì laptop như trước. Chi phí để bảo trì những cái Mobile Extender thì sẽ thấp hơn so với việc phải bảo trì cả một cái máy tính có RAM, có CPU, có ổ cứng và tùm lum thứ khác trong đó.<br/><br/>
Trong các công ty cỡ vừa và lớn, chi phí bảo trì, bảo dưỡng thiết bị thường rất lớn, nhiều khi lên đến cả trăm triệu, thậm chí là nhiều tỉ đồng mỗi tháng, đó là chưa tính đến tiền lương trả cho nhân viên bảo trì. Chính vì vậy mà ban lãnh đạo của những công ty lúc nào cũng tìm cách cắt giảm chi phí để tăng lợi nhuận, và giải pháp nào giúp họ làm được điều đó thì họ sẽ mạnh tay đầu tư.<br/><br/>
HP cũng rất khôn ngoan khi đưa ra HP Mobile Extender và các giải pháp ảo hóa để chạy ứng dụng (sẽ nói kĩ hơn bên dưới). Bằng cách này, công ty vừa có thể thu tiền phần cứng 1 lần, vừa có thể thu thêm các khoản dịch vụ khác như cài đặt, thiết lập, triển khai, sửa chữa. HP từ trước đến nay vẫn rất nổi tiếng về mảng dịch vụ doanh nghiệp rồi, và khoản tiền này béo bở hơn rất rất nhiều so với việc bán thiết bị. Tất nhiên, công ty sẽ có chính sách giá phù hợp để các doanh nghiệp chịu đầu tư, chứ nếu chi phí cao hơn so với việc trang bị laptop riêng thì tại sao các doanh nghiệp phải bỏ tiền ra đúng không nào?<br/><br/>
Hiện không rõ nếu dùng Lumia 950, 950 XL và gắn vào HP Mobile Extender thì có được hay không hay phụ kiện này chỉ tương thích với Elite x3 mà thôi.<br/><br/>
Xét ở góc độ người dùng cá nhân như mình và bạn, Mobile Extender cũng có những lợi ích nhất định so với việc đem smartphone + laptop như hiện nay. Giả sử như Continuum có thể đáp ứng toàn bộ các phần mềm bạn cần thì lúc này tiền mua Mobile Extender sẽ rẻ hơn tiền mua laptop đầy đủ. Nó cũng có trọng lượng nhẹ nhàng, mỏng, thiết kế đẹp nên dễ đem đi đây đó. Đáng tiếc là vẫn chưa có giá cụ thể cho Mobile Extender.<br/><br/>
<b>Cấu hình của Mobile Extender</b><br/><br/>
Như đã nói ở trên, dock này chẳng có RAM, chẳng có bộ nhớ lưu trữ, chẳng có CPU gì luôn. Nó sẽ lấy những thứ này từ chiếc HP Elite x3. Nói cách khác, HP Elite x3 khi đó sẽ trở thành trái tim và bộ não cho cái vỏ Mobile Extender. Chi tiết hơn, nó có:<br/><br/>
- Màn hình: 12,5" đèn nền LED, viền rất mỏng<br/>
- CPU: lấy từ điện thoại (Snapdragon 820)<br/>
- GPU: lấy từ điện thoại (Adreno 530)<br/>
- RAM: lấy từ điện thoại (4GB)<br/>
- Pin: 4-cell 45W<br/>
- Hệ điều hành: Windows 10 Mobile, lấy từ điện thoại<br/>
- Bàn phím: chống tràn nước, có đèn nền, có Touchpad<br/>
- Kết nối: 3 cổng USB Type-C, 1 cổng microHDMI, một jack tai nghe<br/>
- Mobile Extender kết nối với Elite x3 bằng cáp USB-C (đã được xác nhận là có) hoặc Mircast (không dây, nhưng chưa được xác nhận bởi HP)<br/>
- Âm thanh: loa Bang & Olufsen, microphone khử nhiễu<br/>
- Kích thước: 289 x 199 x 13.8 mm<br/>
- Trọng lượng: 1kg<br/><br/>
<b>Khả năng chạy ứng dụng: không chỉ dừng ở universal app</b><br/><br/>
Hạn chế lớn nhất tính đến thời điểm hiện tại của Continuum chính là việc chỉ chạy được ứng dụng universal viết cho Windows 10. Thậm chí app cho Windows 8.1 hay Windows Phone 8.1 thời trước cũng không hoạt động được. Trong khi đó, số lượng app universal chưa nhiều, thiếu nhiều app quan trọng, lại bị hạn chế về khả năng chạy đa nhiệm nữa (tính đến lúc viết bài này, Continuum chỉ cho chạy 1 ứng dụng cùng lúc trên màn hình).<br/><br/>
Đọc tới đây chắc bạn sẽ nghĩ là thôi tèo HP rồi, Continuum hạn chế tùm lum thứ như vậy thì ai mà mua, nhất là doanh nghiệp, những người cần xài các phần mềm đặc thù và không có bản cho mobile. Bạn nghĩ hoàn toàn đúng, có điều HP cũng đã tính đến chuyện đó và đã đưa ra một giải pháp rất tốt: ảo hóa.<br/><br/>
Giải pháp ảo hóa HP Workspace sẽ tạo cho mỗi nhân viên một "không gian làm việc" riêng của họ trên máy chủ công ty hoặc máy chủ cloud, trong đó cài sẵn các ứng dụng Windows / Linux cần thiết. Khi xài HP Elite x3 + Mobile Extender, người nhân viên chỉ đơn giản là bấm vào icon của ứng dụng rồi chạy nó lên mà thôi. Lúc này phần mềm thực chất đang hoạt động trên server, Elite x3 chỉ đóng vai trò nhận hình ảnh của app và ghi nhận các thao tác click chuột hay gõ phím của bạn. Mô hình như thế này gọi là fat server - thin client. Fat server là vì server giờ sẽ đảm nhận phần xử lý nhiều hơn nên "mập" hơn, còn client (chính là Elite x3 + Mobile Extender) thì không cần làm nhiều việc nên "ốm" hơn.<br/><br/>
Nếu không dùng HP Workspace, HP Elite x3 cũng có thể chạy các phần mềm điều khiển từ xa, ví dụ như Microsoft Remote Desktop (đã có bản cho Windows 10 Mobile), để kết nối thẳng vào desktop ảo trên máy chủ luôn cũng được. Lúc này mỗi nhân viên sẽ có một cái máy tính Windows / Linux đầy đủ, nhưng khi đó năng lực xử lý của server sẽ phải lớn hơn so với việc chỉ ảo hóa app.<br/><br/>
Ngoài ra, nhiều phần mềm quản lý dùng trong doanh nghiệp giờ cũng dần di chuyển lên nền web chứ không còn là dạng phần mềm cài đặt truyền thống nữa. Điều này có nghĩa là bạn chỉ cần thiết bị nào đó với trình duyệt là đã có thể truy cập vào hệ thống, nếu có màn hình to nữa thì tốt hơn. Bộ đôi Elite x3 + Mobile Extender thì hoàn toàn có thể làm chuyện đó. HP mới đây cũng đã hợp tác với Salesforce, một trong những công ty cung cấp giải pháp quản lý khách hàng và bán hàng lớn nổi tiếng, để tối ưu hóa các dịch vụ đám mây.<br/><br/>
Những thứ ảo hóa nói trên sẽ không có tác dụng với người dùng cá nhân như chúng ta vì không ai lại đi duy trì cả một cái server trong nhà cả. Bạn mua luôn một cái laptop xài cho khỏe, và rẻ hơn rất nhiều so với việc sắm một con server rồi. Chưa kể còn tiền điện, tiền làm máy cho nó nữa. Nói chung, giải pháp ảo hóa này chỉ dành cho doanh nghiệp, đó là lý do vì sao HP lại nhắm đến những khách hàng này.<br/><br/>','2016-01-29',null,'01-news.jpg'),
(N'Sky X9E Extreme Edition: 17,3 4K, RAM 64GB, hỗ trợ VR',
N'Thiết bị này do hãng Eurocom sản xuất. Họ gọi nó là "desktop laptop" để chỉ rằng đây là một cái máy tính xách tay nhưng vẫn có sức mạnh như máy bàn. Đáng chú ý, máy dùng CPU i7 của máy bàn với hệ số nhân được mở khóa để ép xung, còn card đồ họa GTX 980 là bản cho laptop nhưng nó vẫn mạnh gần bằng với 980 dùng cho máy bàn bình thường. Với cấu hình như thế này thì Sky X9E Extreme Edition có thể được dùng để chơi game hạng nặng. Nhà sản xuất còn tuyên bố rằng chiếc laptop của họ đã sẵn sàng cho các ứng dụng thực tế ảo vì "cấu hình của nó cao hơn yêu cầu tối thiểu của các game và 360 độ dùng với kính Oculus Rift hoặc HTC Vive". Giá bán của Sky X9E Extreme Edition bắt đầu từ 3500$.<br/><br/>
<b>Các tùy chọn CPU</b><br/><br/>
- 4GHz (up to 4.2GHz) Intel Core i7-6700K; 4C/8T; 8MB L3; Skylake-S; 14nm; LGA1151; 91W<br/>
- 3.5GHz (up to 3.9GHz) Intel Core i5-6600K; 4C/4T; 6MB L3; Skylake-S; 14nm; LGA1151; 91W<br/>
- 3.4GHz (up to 4GHz) Intel Core i7-6700; 4C/8T; 8MB L3; Skylake-S; 14nm; LGA1151; 65W<br/><br/>
<b>Các tùy chọn RAM</b><br/><br/>
- 16GB; 2x 8GB; DDR4; 2400Hz; CL14; 260-pin; 1.2V; Kingston HyperX Impact; 2 SODIMMs<br/>
- 24GB; 3x 8GB; DDR4; 2400Hz; CL14; 260-pin;1.2V; Kingston HyperX Impact; 3 SODIMMs<br/>
- 32GB; 4x 8GB; DDR4; PC4-2133; CL15; 260-pin; Micron; 1.2V; 4 SODIMMs<br/>
- 32GB; 4x 8GB; DDR4; 2400Hz; CL14; 260-pin;1.2V; Kingston HyperX Impact; 4 SODIMMs<br/>
- 48GB; 3x 16GB; DDR4; PC4-2133; CL15; 260-pin; Micron; 1.2V; 3 SODIMMs<br/>
- 64GB; 4x 16GB; DDR4; PC4-2133; CL15; 260-pin; Micron; 1.2V; 4 SODIMMs<br/><br/>
<b>Các tùy chọn GPU</b><br/><br/>
- 8GB GDDR5; NVIDIA GTX 980 (desktop) (N16E-GXX); MXM 3.0 107.6x115mm; 200W<br/>
- SLI 2x 8GB GDDR5; NVIDIA GTX 980M (N16E-GX); 1536 CUDA; GPU/VRAM Clock 1038MHz/2500MHz; Maxwell (28nm); MXM 3.0b; 2x 103W<br/><br/>
<b>Các tùy chọn màn hình</b><br/><br/>
- 17.3-inch (43.9cm); FHD IPS 1920x1080; MATTE (Non-Glare); 300nts; 700:1; 72% NTSC; eDP 30pin;LP173WF4 SPD1<br/>
- 17.3-inch (43.9cm); 4K UHD 3840x2160; MATTE IPS; eDP; 1000:1; Adobe RBG 100%; 400nts; AUO B173ZAN01.0<br/><br/>
<b>Thông tin khác</b><br/><br/>
- Ổ lưu trữ: 4 khay, 2 HDD / SSD dùng SATA 3 + 2x M.2 PCIe, hỗ trợ chạy RAID<br/>
- Trọng lượng: 4.8kg; kích thước 428 x 308 x 45mm<br/><br/>','2016-02-05',null,'02-news.jpg'),
(N'Mua laptop Dell tích hợp Windows bản quyền nhận quà tặng hấp dẫn',
N'MAXSPEED xin thông báo đến khách hàng Chương trình Khuyến mãi dành cho các sản phẩm máy tính xách tay Dell mua tại hệ thống LAPTOP-SHOPPER từ ngày 26/2 đến 8/3 có cài sẵn HĐH Win 8.1 hoặc Win 10 bản quyền.<br/><br/>
- Khi khách hàng mua bất kỳ sản phẩm máy tính chính hãng Dell có cài sẵn HĐH Windows 8.1 hoặc Windows 10 bản quyền sẽ được sở hữu ngay 01 (một) chuột không dây thời trang trị giá 399.000 đồng.<br/><br/>
- Ngoài ra, đối với những máy có cài sẵn phần mềm Microsoft Office 365 sẽ được tặng thêm: 01 (một) thẻ cào điện thoại trị giá 500.000 đồng.<br/><br/>','2016-02-26',N'Từ ngày 26/02 đến 08/03/2016','01-event.jpg'),
(N'Đánh giá chi tiết chiếc laptop 4k đầu tiên của ASUS tại thị trường Việt Nam – ASUS K501UX',
N'Ở thời điểm hiện tại thị trường máy tính xách tay tại Việt Nam đang trở nên rất sôi động với hàng loạt các dòng sản phẩm trải dài trên mọi phân khúc. Tuy nhiên các dòng sản phẩm với cấu hình phần cứng thực sự cao cấp vẫn còn khá hạn chế. Đặc biệt các dòng sản phẩm với màn hình độ phân giải cao dành cho những khách hàng thiết kế đồ họa cũng như những người yêu cầu chất lượng hình ảnh cao lại càng hiếm thấy.<br/><br/>
Nắm bắt được xu thế đó ASUS đã cho ra mắt dòng sản phẩm máy tính xách tay tầm trung K501UX mới với độ phân giải màn hình siêu cao lên đến 4K nhằm đáp ứng tốt nhất cho nhu cầu của người dùng nhưng chỉ với mức giá tầm trung.<br/><br/>
<b>Về thiết kế bên ngoài:</b><br/><br/>
Mặt trước của K501UX được thiết kế bằng nhôm nguyên tấm mang đến cảm giác sang trọng và cứng cáp hơn so với vật liệu nhựa thường thấy trên các máy tính tầm trung. Tuy nhiên nhược điểm nhỏ của chất liệu nhôm này là khá dễ bám dấu vân tay. Nếu là một người sạch sẽ chắc chắn bạn sẽ cần đến một chiếc khăn lau đi kèm theo.<br/><br/>
Máy nhìn từ phía trước máy nhìn khá mỏng, lí do là các viền máy được thiết kế theo kiểu vát mỏng. Mang đến cảm giác máy mỏng hơn khá nhiều so với thực tế. Có thể phân biệt rõ ràng ba phần riêng biệt là màn hình, thân máy và nắp lưng dưới.<br/><br/>
Mặt sau là được thiết kế theo dạng nguyên tấm, vì thế nếu bạn muốn nâng cấp ram hoặc thay ổ cứng thì bắt buộc bạn phải mở toàn bộ nắp lưng sau của máy ra. Điều đó được cho là một nhược điểm khi việc tháo lắp nguyên cả nắp lưng sau ra nếu không cẩn thận thì sẽ dễ dàng gây hiện tượng gãy các chốt. Tuy nhiên việc tháo mở nắp lưng ra là một điều khá ít làm và tốt nhất hãy để những người có chuyên môn xử lí nếu bạn không chắc.<br/><br/>
Mặt sau cũng là nơi đặt cặp loa ngoài của máy. Việc thiết kế cặp loa nằm ở phía dưới máy nhằm mục đích tăng cường âm thanh xuất ra từ loa ngoài.<br/><br/>
Bàn phím chiclet đi kèm theo máy có chất lượng khá tốt, khoảng cách giữa các phím với nhau là khá hợp lí, độ sâu của các phím cũng ở mức vừa phải mang đến chất lượng gõ khá tốt, tiếng ồn phát ra ở mức chấp nhận được. Máy cũng được trang bị đèn bàn phím hỗ trợ cho người dùng khi sử dụng máy trong điều kiện thiếu sáng. Các mức sáng hỗ trợ bàn phím cũng có thể được chỉnh một các lịnh động tùy vào điều kiện ánh sáng bên ngoài.<br/><br/>
Với kích thước 15’6 inch nên bàn phím trên K501UX vẫn được trang bị thêm bàn phím số bên cạnh giúp cho việc nhập số liệu trở nên nhanh chóng hơn.<br/><br/>
Màn hình, đây là một điểm cần đáng nói đến nhất trên K501UX. Ở các thế hệ trước các màn hình ASUS trang bị cho dòng K chỉ đa phần nằm ở độ phân giải HD. Tuy nhiên đến thế hệ 2016 này cụ thể là trên dòng K501UX. ASUS đã trang bị cho K501UX màn hình với độ phân giải lên đến 4K (4 lần Full HD). Cùng với đó là việc trang bị tấm nền IPS mang đến khả năng hiển thị màu sắc chính xác cho hình ảnh.<br/><br/>
Tuy không phải là hãng mang đến tùy chọn màn hình 4K đầu tiên tại thị trường Việt Nam nhưng ASUS K501UX chính là một trong những mẫu sản phẩm được trang bị màn hình 4K đầu tiên trong phân khúc tầm trung tại thị trường Việt Nam. Tuy nhiê ở các thời điềm một vài năm trước việc trang bị màn hình 4K trên laptop là điều khá khó khăn khi các phiên bản hệ điều hành Windows thời đó vẫn chưa thực sự hỗ trợ tốt ở độ phân giải siêu cao. Với việc trang bị màn hình 4K cùng với Windows 10 hỗ trợ tốt hơn cho các màn hình độ phân giải siêu cao cũng là lí do hợp lí.<br/><br/>
Viền màn hình tuy vẫn còn khá dày và chưa thực sự đẹp nhưng nếu là một người sử dụng bình thường thì hoàn toàn không có vấn đề gì hết.<br/><br/>
Touchpad trên K501UX được thiết kế với kích thước lớn mang đến khả năng sử dụng khá thuận tiện. Chất lượng touchpad cũng được nâng cấp lên rất tốt không còn hiện tượng lỏng lẻo như một dòng trước đây.<br/><br/>
Tuy có kích thước khá mỏng nhưng trên K501UX vẫn được trang bị các cổng kết nối rất đa dạng và đầy đủ. Ở cạnh bên phải của máy là nơi đặt khe cắm thẻ nhớ, hai cổng USB 3.0 và cổng audio 3.5mm. Mặt cạnh bên trái là nơi đặt các cổng nguồn, cổng LAN, cổng HDMI và hai cổng USB. Cùng với đó máy còn được trang bị thêm một phụ kiện rời là cable chuyển đổi USB sang VGA.<br/><br/>
Về cấu hình ASUS K501UX được trang bị bộ vi xử lí Intel Core I5 Skylake thế hệ thứ 6 mang đến khả năng tiết kiệm điện năng, cũng như nhiệt độ thấp hơn các thế hệ trước. Cùng với đó là Ram 4GB, bộ nhớ trong HDD 1TB, màn hình 15’6 inch độ phân giải 4K tấm nền IPS, card đồ họa Intel HD Graphics 520 và card rời NVIDIA GTX 950M 4GB.<br/><br/>
Điều quan tâm ở đây ngoài điểm số mà các bài test đạt được ta còn quan tâm đến thông số bên cạnh được hiển thị là FPS mà hai bài đánh giá đạt được. Có thể thấy được FPS mà hai bài test đạt được chưa thực sự tốt cho lắm. Một phần cũng là do cấu hình chiếc ASUS trong bài đánh giá này sử dụng chip Core i5.<br/><br/>
Với Cinebench kết quả thu được cũng không có quá nhiều sự khác biệt so với 3Dmark Vantage khi FPS thu nhận được cũng nằm trong mức tương ứng với 3Dmark Vantage. Đánh giá tốc độ đọc ghi của ổ cứng. Do chỉ được trang bị ổ cứng HDD tốc độ 5400 nên có lẽ hy vọng quá nhiều về khả năng về tốc độ mà ổ đạt được. Tuy nhiên đối với HDD thì đây là một con số hoàn toàn hợp lí.<br/><br/>
<b>Tổng kết:</b><br/><br/>
Là một chiếc laptop nằm trong phân khúc tầm trung nhưng ASUS K501UX vẫn được ASUS trang bị một cấu hình khá hấp dẫn đặc biệt là việc sử dụng màn hình có độ phân giải siêu cao lên đến 4K cùng tấm nền IPS hứa hẹn mang đến cho người sử dụng chất lượng hiển thị hình ảnh cực kì xuất sắc. Điều mà các màn hình HD bình thường không thể làm được.<br/><br/>','2016-01-15',null,'03-news.jpg'),
(N'Mua Laptop Asus ZenBook UX305 nhận ngay Chuột quang Asus trị giá 450.000 đồng',
N'MAXSPEED gởi đến quý khách hàng thông tin Chương trình khuyến mãi hãng Asus dành cho khách hàng mua laptop Asus ZenBook UX305 được nhận ngay quà tặng trị giá 450.000 đồng:<br/><br/>
- Từ ngày 10/06 đến 30/06/2015, khi mua sản phẩm ASUS ZenBook UX305, người mua sẽ mang các thủ tục đến điểm đổi quà của Asus để được tặng ngay một chuột không dây ASUS cao cấp trị giá 450.000 VNĐ.<br/><br/>
Khách hàng đến nhận quà phải mang theo các chứng từ sau:<br/><br/>
- Bản gốc và bản sao Hóa đơn mua hàng VAT.<br/><br/>
- Bản gốc và bản sao Chứng minh nhân dân.<br/><br/>
- Số S/N của máy P/S: Mỗi hóa đơn mua hàng chỉ nhận được 01 (một) phần quà tương ứng.<br/><br/>
Mỗi khách hàng chỉ nhận được 01 (một) phần quà trong thời gian áp dụng chương trình khuyến mãi.<br/><br/>','2015-06-10',N'Từ ngày 10/06 đến 30/06/2015','02-event.jpg')
go

/*create trigger tgProduct
on tbProduct
instead of delete
as
delete from tbComment where ProductID in (select ProductID from deleted);
delete from tbProduct where ProductID in (select ProductID from deleted);
go*/

/*create trigger tgBrand
on tbBrand
instead of delete
as
delete from tbProduct where BrandName in (select BrandName from deleted);
delete from tbBrand where BrandName in (select BrandName from deleted);
go

create trigger tgUser
on tbUser
instead of delete
as
declare @CommentUserReplyID varchar(20)
select @CommentUserReplyID = UserID from deleted
update tbComment
set CommentReply = null, CommentReplyDate = null, CommentUserReplyID = null
where CommentUserReplyID like @CommentUserReplyID;
delete from tbComment where CommentUserID in (select UserID from deleted);
delete from tbFeedback where FeedbackMemberID in (select UserID from deleted);
delete from tbUser where UserID in (select UserID from deleted);
go*/