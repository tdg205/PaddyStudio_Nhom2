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
	UserPhone varchar(20),
	UserRole bit default 0 not null
);
go

create table tbBrand
(
	BrandName varchar(20) primary key nonclustered,
	BrandDescription nvarchar(1000),
	BrandLogo varchar(200) not null
);
go

create table tbProduct
(
	ProductID int identity(1,1) primary key nonclustered,
	ProductName varchar(50) unique not null,
	ProductImage varchar(200) not null,
	ProductDescription nvarchar(1000) not null,
	Price varchar(20),
	WarrantyTime int check(WarrantyTime>=0 and WarrantyTime <=60) not null,
	ManufacturerYear smallint check(ManufacturerYear<=year(getdate()) and ManufacturerYear >1980) default year(getdate()) not null,
	BrandName varchar(20) foreign key references tbBrand(BrandName) not null
);
go

create table tbFeedback
(
	FeedbackID int identity(1,1) primary key nonclustered,
	FeedbackSubject nvarchar(20) not null,
	FeedbackContent nvarchar(500) not null,
	FeedbackDate datetime check(FeedbackDate<=getdate()) default getdate() not null,
	FeedbackMemberID varchar(20) foreign key references tbUser(UserID) not null,
	FeedbackReply nvarchar(500),
	FeedbackReplyDate datetime,
	FeedbackAdminReplyID varchar(20) foreign key references tbUser(UserID)
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
('A01',N'Trương Đình Giang','123456','giang.itk10@gmail.com','Ho Chi Minh City','0962502799','1'),
('A02',N'Đào Thiện Hoàng Huy','123456','huyhoang02@gmail.com','Ho Chi Minh City','0942327885','1'),
('A03',N'Lê Gia An','123456','an123@gmail.com','Ho Chi Minh City','0948277065','1'),
('U01','Kevin Tran','abcd123','kev@gmail.com','New York','0913345678','0'),
('U02','Sam Winchester','abcd123','sammy@yahoo.com','Texas','0945345623','0'),
('U03','Calvin Harris','abcd123','calv@gmail.com','Washington','0989345126','0'),
('U04','Join Kenedy','abcd123','joinken@gmail.com','Los Angeles	','0989348826','0'),
('U05','Ray Kroc','abcd123','raykroc@gmail.com','Chicago','0989347726','0'),
('U06','Mark Cuban','abcd123','markcuban@gmail.com','Sandiego','0989345996','0'),
('U07','Walton Jon','abcd123','ưaltonj@gmail.com','Boston','0989115556','0')
go

insert tbBrand values
('Dell',N'Dell là một công ty đa quốc gia của Hoa Kỳ về công nghệ máy tính có trụ sở tại Texas, Hoa Kỳ. Dell được thành lập năm 1984 bởi Michael Dell.','dell.jpg'),
('Asus',N'ASUSTeK Computer Incorporated (ASUS) là một tập đoàn đa quốc gia đặt trụ sở tại Đài Loan chuyên sản xuất các mặt hàng điện tử','asus.jpg'),
('HP',N'Hewlett-Packard (viết tắt HP) là tập đoàn công nghệ thông tin lớn nhất thế giới. HP thành lập năm 1939 tại Palo Alto, California, Hoa Kỳ.','hp.jpg'),
('Apple',N'Apple là tập đoàn công nghệ máy tính của Mỹ có trụ sở chính đặt tại San Francisco,California. Apple được thành lập ngày 1/4/1976.','apple.jpg'),
('Lenovo',N'Lenovo là tập đoàn đa quốc gia về công nghệ máy tính có trụ sở chính ở Bắc Kinh, Trung Quốc và Morrisville, Bắc Carolina, Mỹ. Tập đoàn thiết kế, phát triển, sản xuất và bán các sản phẩm như máy tính cá nhân, máy tính bảng, smartphone, các trạm máy tính, server, thiết bị lưu trữ điện tử, phần mềm quản trị IT và ti vi thông minh.','lenovo.jpg')
go

insert tbProduct values
('Dell XPS 13 9365','Dell01.jpg',
N'- Bộ xử lý: Intel Core i7 7Y75 (2x1.30 GHz), Max Turbo Frequency: 3.60 GHz-4MB<br/>
- RAM: 16GB DDR4/1866MHz onboard<br/>
- Đĩa cứng: SSD (M.2 2280) 512GB (M.2 2280)<br/>
- Đồ họa: Intel HD Graphics 615<br/>
- Âm thanh: 	High Definition (HD) Audio 2.0<br/>
- Màn hình: 13.3" InfinityEdge touch display (3200x1800), không cảm ứng<br/>
- Giao tiếp mạng: Không LAN, wifi: Intel (802.11 ac), Bluetooth 4.2<br/>
- Tính năng mở rộng & cổng giao tiếp: 1xThunderbolt 3 (4 lanes of PCI Express Gen 3) with PowerShare & DC-In ; 1 x DisplayPort over USB-C with PowerShare, DC-In & DisplayPort ; 1 x Headphone/ Microphone combo ; 1 x USB-C to HDMI (2.0) A<br/>
- Trọng lượng 1.24 kg, pin 4 Cell Int (46WHr)<br/>
- Hệ điều hành: Windows 10 Home Single Language 64Bit + Office Personal 365<br/>','54.990.000','24','2017','Dell'
),

('Dell XPS15-Core i7 8750HQ','Dell02.jpg',
N'- Bộ xử lý: Intel Core i7 8750HQ 2.20GHz-9MB cache<br/>
- RAM: 16GB DDR4 2666MHz, 2 khe RAM<br/>
- Đĩa cứng: SSD PCLE 512GB<br/>
- Đồ họa: NVIDIA GEFORCE GTX 1050 4GB GDDR5<br/>
- Âm thanh: 	High Definition (HD) Audio - Power Cord<br/>
- Màn hình: 15.6 inchs -InfinityEdge display( 1920x1080), không cảm ứng<br/>
- Giao tiếp mạng: LAN 10/100/1000, Wifi 802.11ac Dual Band, Bluetooth v4.1<br/>
- Tính năng mở rộng & cổng giao tiếp: USB 3.0, Headset, Finger Print Reader<br/>
- Trọng lượng 1.80 kg, Pin 4 Cell Int (46WHr)<br/>
- Hệ điều hành: Windows 10 Home Plus + Microsoft Office 365 Personal DFO<br/>','53.990.000','24','2017','Dell'
),

('Dell XPS13 9370','Dell03.jpg',N'- Bộ xử lý: Intel Core i7-8550U 1.80 GHz, 8MB Cache<br/>
- RAM: 8GB LPDDR3/1866 MHz, 1 khe RAM<br/>
- Đĩa cứng:	SSD PCIe (M2 2280) 256GB<br/>
- Đồ họa: Intel UHD Graphics 620<br/>
- Âm thanh: Realtek Audio (MaxxAudio Pro), Waves MaxxAudio Pro<br/>
- Màn hình: 	13.3 inchs - FullHD InfinityEdge display(1920x1080), không cảm ứng<br/>
- Giao tiếp mạng: Không LAN, Wifi 802.11ac Dual Band, Bluetooth v4.1<br/>
- Tính năng mở rộng & cổng giao tiếp: 2 x Thunderbolt™ 3 (with PowerShare & DC-In & DisplayPort); 1 x USB-C 3.1 (with PowerShare, DC-In & DisplayPort); 1 x Headphone/ Microphone<br/>
- Trọng lượng 1.21kg, Pin 4 Cell Ext (52Wh) liền<br/>
- Hệ điều hành: Windows 10 Home Single Language 64Bit + Office Personal 365<br/>','45.990.000','12','2018','Dell'
),

('Dell XPS 13 9360-Core i5 7200U','Dell04.jpg',
N'- Bộ xử lý: Intel Core i5-7200U 2.50 GHz, 3MB Cache<br/>
- RAM: DDRAM 8GB LPDDR3/	2133 MHz, onboard RAM<br/>
- Đĩa cứng:	SSD 256GB<br/>
- Đồ họa: Intel HD Graphics 620<br/>
- Âm thanh: High Definition (HD) Audio 2.0<br/>
- Màn hình: 	13.3 inch-FHD (1920 x 1080), Anti-Glare, không cảm ứng<br/>
- Giao tiếp mạng: Không LAN, wifi 802.11ac<br/>
- Tính năng mở rộng & cổng giao tiếp: USB 3.0, USB Type-C, Multi TouchPad<br/>
- Trọng lượng vỏ nhôm 1.23kg - Pin 	4 cell 60WHr liền<br/>
- Hệ điều hành: Windows 10 Home SL + Microsoft Office 365<br/>','35.990.000','12','2018','Dell'
),

('Dell Vostro V5468A','Dell05.jpg',
N'- Bộ xử lý: Intel Core i5-7200U 2.50 GHz, 3MB Cache<br/>
- RAM: 4GB DDR4/	2133MHz, 2 khe RAM<br/>
- Đĩa cứng:	HDD 1TB, có khe ổ cắm SSD<br/>
- Đồ họa: Nvidia GeForce 940M-2GB<br/>
- Màn hình: 	14 inch-	HD LED(1366 x 768), không cảm ứng<br/>
- Âm thanh: High Definition (HD) Audio 2.0<br/>
- Giao tiếp mạng: LAN 10/100Mbps, wifi IEEE 802.11b/g/n<br/>
- Tính năng mở rộng & cổng giao tiếp: 2 x USB 3.0, HDMI, LAN (RJ45), USB 2.0, VGA (D-Sub), Multi TouchPad<br/>
- Trọng lượng kim loai 1.7 kg, Pin 3 cell liền<br/>
- Hệ điều hành: Windows 10 + Microsoft Office 365<br/>','17.990.000','12','2017','Dell'
),

('Macbook Air 13 128GB MQD32SA/A','Macbook01.jpg',
N'- Bộ xử lý: Intel Core i5 1.8Ghz-	Dual Core, 3MB (L3 Cache)<br/>
- RAM: 8GB LPDDR3 1600Mhz<br/>
- Đĩa cứng: SSD 128GB<br/>
- Đồ họa: Intel HD Graphics 6000<br/>
- Màn hình: 	13.3inchs 1440x900 pixels-LED-backlit, không cảm ứng<br/>
- Âm thanh: 	Stereo speakers<br/>
- Tính năng mở rộng & cổng giao tiếp: 2xUSB 3.0, 2xThunderbolt 2, 1xSDXC Card, 1xMagSafe 2, 1xHeadphone<br/>
- Giao tiếp mạng: LAN 802.11ac Wi-Fi wireless networking, Wi-Fi IEEE 802.11a/b/g/n compatible<br/>
- Hệ điều hành: 	Mac Os<br/>
- Pin lithium polymer, trọng lượng 1.35 Kg<br/>','23.999.000','12','2017','Apple'
),

('Macbook Air 13 256GB MQD42SA/A','Macbook02.jpg',
N'- Bộ xử lý: Intel Core i5 1.8Ghz-	Dual Core, 3MB (L3 Cache)<br/>
- RAM: 8GB LPDDR3 1600Mhz<br/>
- Đĩa cứng: SSD 256GB<br/>
- Đồ họa: Intel HD Graphics 6000<br/>
- Màn hình: 	13.3inchs 1440x900 pixels-LED-backlit, không cảm ứng<br/>
- Âm thanh: 	Stereo speakers<br/>
- Tính năng mở rộng & cổng giao tiếp: 2xUSB 3.0, 2xThunderbolt 2, 1xSDXC Card, 1xMagSafe 2, 1xHeadphone<br/>
- Giao tiếp mạng: LAN 802.11ac Wi-Fi wireless networking, Wi-Fi IEEE 802.11a/b/g/n compatible<br/>
- Hệ điều hành: 	Mac Os<br/>
- Pin lithium polymer, trọng lượng 1.35 Kg<br/>','28.999.000','12','2017','Apple'
),

('Macbook 12 256GB','Macbook03.jpg',
N'- Bộ xử lý: Intel Core M3 1.2Ghz-Dual Core, 4MB (L3 Cache)<br/>
- RAM: 8GB LPDDR3 1866 MHz<br/>
- Đĩa cứng: SSD 256GB<br/>
- Đồ họa: Intel HD Graphics 615<br/>
- Màn hình: 	12 inch 2304x1440 Pixels-LED-backlit, không cảm ứng<br/>
- Âm thanh: 	Stereo speakers<br/>
- Tính năng mở rộng & cổng giao tiếp: 1xUSB Type-C, 1x3.5mm headphone jack<br/>
- Giao tiếp mạng: LAN 802.11ac Wi-Fi wireless networking, Wi-Fi IEEE 802.11a/b/g/n compatible<br/>
- Hệ điều hành: 	Mac Os<br/>
- Pin lithium polymer, trọng lượng 0.92 Kg<br/>','33.999.000','12','2017','Apple'
),

('Macbook Pro 13 inch','Macbook04.jpg',
N'- Bộ xử lý: Intel 	Core i5 	2.3 GHz-Dual Core<br/>
- RAM: 8GB LPDDR3 2133MHz<br/>
- Đĩa cứng: SSD 128GB<br/>
- Đồ họa: Intel Iris Plus Graphics 640<br/>
- Màn hình: 	13.3 inch 2560 x 1600 pixels-LED backlit, không cảm ứng<br/>
- Âm thanh: 	Stereo speakers<br/>
- Tính năng mở rộng & cổng giao tiếp: 2xThunderbolt 3(USB-C), 1xHeadphone<br/>
- Giao tiếp mạng: LAN 802.11ac Wifi wireless networking, Wi-Fi IEEE 802.11a/b/g/n compatible<br/>
- Hệ điều hành: 	Mac Os<br/>
- Pin lithium polymer, trọng lượng 1.37kg<br/>','33.999.000','12','2017','Apple'
),

('Macbook Pro 13 Touch Bar','Macbook05.jpg',
N'- Bộ xử lý: Intel 	Core i5 2.3GHz-Quad Core, 8MB<br/>
- RAM: 8GB LPDDR3 2133MHz, 1 khe RAM<br/>
- Đĩa cứng: SSD 512GB<br/>
- Đồ họa: Intel Iris Plus Graphics 655<br/>
- Màn hình: 13.3inch Retina (2560 x 1600 pixels), Công nghệ True Tone, Công nghệ IPS, LED Backlit, không cảm ứng<br/>
- Âm thanh: Stereo speakers with high dynamic range<br/>
- Tính năng mở rộng & cổng giao tiếp: 4 cổng USB-C tích hợp Thunderbolt 3 và 1 cổng tai nghe 3.5<br/>
- Giao tiếp mạng: không có LAN, Wi-Fi 802.11ac Wi-Fi wireless networking; IEEE 802.11a/b/g/n compatible, Bluetooth 5.0 wireless<br/>
- Hệ điều hành: Mac Os High Sierra<br/>
- Pin lithium polymer 58Wh, trọng lượng 1.37kg<br/>','49.999.000','12','2018','Apple'
),

('Asus TUF FX504GE-E4059T','Asus01.jpg',
N'- Bộ xử lý: Intel 	Core i7 	8750H 2.20GHz-Quad Core, 9 MB Smart Cache<br/>
- RAM: 8GB DDR4 2666MHz, 2 khe RAM<br/>
- Đĩa cứng: 	HDD 1TB 5400RPM SATA HDD (FireCuda), có khe cắm ổ SSD<br/>
- Đồ họa: NVIDIA GeForce GTX 1050Ti-	4GB GDDR5 VRAM<br/>
- Màn hình: 	15.6 inch 1920x1080 pixels, 	Anti-Glare IPS, không cảm ứng<br/>
- Âm thanh: 	Công nghệ Bang & Olufsen ICEpower® 2.0<br/>
- Tính năng mở rộng & cổng giao tiếp: 1 x SSD (M2 2280); 2 x USB 3.0 ; 1 x USB 2.0; 1 x HDMI ; 1 x RJ45 ; 1 x Microphone-in/Headphone-out Combo<br/>
- Giao tiếp mạng: LAN 10/100/1000 Mbps, Wi-Fi 802.11 AC (2x2), Bluetooth V4.0<br/>
- Hệ điều hành:	Windows 10 Home SL<br/>
- Pin 4 cell-48 Whrs liền, trọng lượng 2.3 kg nhựa<br/>','25.990.000','24','2017','Asus'
),

('ASUS ZenBook 13 UX331UN','Asus02.jpg',
N'- Bộ xử lý: Intel 	Core i5 8250U 1.60 GHz, 6 MB Cache<br/>
- RAM: 8GB LPDDR3 1866MHz, 1 khe RAM<br/>
- Đĩa cứng: 	SSD 256GB, có khe cắm ổ SSD<br/>
- Đồ họa: NVIDIA GEFORCE MX150 2GB<br/>
- Màn hình:	13.3inchs 1920x1080 pixels, FullHD Anti-Glare, không cảm ứng<br/>
- Âm thanh: 	"Built-in speaker Built-in array microphone Audio by ICEpower® harmon/ kardon"<br/>
- Tính năng mở rộng & cổng giao tiếp: 2 x USB 3.0; 1 x USB 3.1 Type C (Gen 1)<br/>
- Giao tiếp mạng: LAN 10/100/1000 Mbps, Wi-Fi 802.11 AC, Bluetooth 4.2<br/>
- Hệ điều hành:	Windows 10 64bit<br/>
- Pin 50WHrs 4S1P-4 cell Li-ion, trọng lượng 1.12Kg vỏ kim loại<br/>','23.690.000','24','2017','Asus'
),

('Asus UX430UA-GV261T','Asus03.jpg',
N'- Bộ xử lý: Intel 	Core i5 8250U 1.60 GHz, 6MB SmartCache<br/>
- RAM: 8GB DDR4 	2133MHz, 1 khe RAM<br/>
- Đĩa cứng: 	SSD 256GB<br/>
- Đồ họa: Intel UHD Graphics 620<br/>
- Màn hình: 14" FHD 1920x1080 pixels, Anti-Glare, không cảm ứng<br/>
- Âm thanh: 	SonicMaster, Loa 3W Stereo<br/>
- Tính năng mở rộng & cổng giao tiếp: 1 x USB 2.0; 1 x USB 3.0; 1 x USB3.1 Type C (gen 1)<br/>
- Giao tiếp mạng: không LAN, Wi-Fi 802.11 AC, Bluetooth <br/>
- Hệ điều hành:	Windows 10 64bit<br/>
- Pin 50WHrs, 3S1P, 3-cell Li-ion liền, trọng lượng 1.3 Kg nhôm nguyên khối<br/>','21.990.000','24','2017','Asus'
),

('Asus Vivobook S14 S410UA','Asus04.jpg',
N'- Bộ xử lý: Intel 	Core i7 	8550U 1.80 GHz, 8M Cache<br/>
- RAM: 4GB DDR4, 1 khe RAM<br/>
- Đĩa cứng: SSD 256GB, không có khe cắm ổ SSD<br/>
- Đồ họa: Intel UHD Graphics 620<br/>
- Màn hình: 14" FHD 1920x1080 pixels, Anti-Glare, không cảm ứng<br/>
- Âm thanh: Tích hợp Loa 2 W Stereo và microphone, Hỗ trợ Windows 10 Cortana, Công nghệ ASUS SonicMaster<br/>
- Tính năng mở rộng & cổng giao tiếp: 2 x USB 2.0; 1 x USB 3.0; 1 x USB3.1 Type C (Gen 1); 1 x Headphone-out & Audio-in Combo Jack; 1 x HDMI<br/>
- Giao tiếp mạng: không LAN, Wi-Fi 802.11 AC, Bluetooth 4.2 (Dual band) 2*2<br/>
- Hệ điều hành:	Windows 10 64bit<br/>
- Pin 3 cell Li-ion liền, trọng lượng 1.43 Kg nhôm nguyên khối<br/>','19.490.000','24','2018','Asus'
),

('Asus UX430UA GV344-Core i5 7200U','Asus05.jpg',
N'- Bộ xử lý: Intel® Core™ i5 7200U 2.5GHz, 3M Cache <br/>
- RAM: 8GB DDR4 	2133MHz<br/>
- Đĩa cứng: SSD 256GB, có khe cắm ổ SSD<br/>
- Đồ họa: Intel UHD Graphics 620<br/>
- Màn hình: 14 inch 1920x1080 pixels, LED-Anti-glare, không cảm ứng<br/>
- Âm thanh: 	Sonic Master 2.0<br/>
- Tính năng mở rộng & cổng giao tiếp: 1x USB 2.0 1x USB 3.0 1x USB3.1 Type C (gen 1)<br/>
- Giao tiếp mạng: không LAN, Wi-Fi 802.11 AC<br/>
- Hệ điều hành: Free DOS<br/>
- Pin 3 cell Li-ion liền, trọng lượng 1.30 Kg nhôm nguyên khối<br/>','18.990.000','24','2018','Asus'
),

('HP Pavilion Power 15-cx0182TX','HP01.jpg',
N'- Bộ xử lý: Intel® Core™ i7 8750H 2.20GHz, 9 MB Cache <br/>
- Bo mạch: Chipset Intel HM370, Bus 2666MHz, hỗ trợ tối đa 16GB<br/>
- RAM: 8GB DDR4 2666 MHz, 2 khe RAM<br/>
- Đĩa cứng: SSD+HDD 128GB+1TB, không có khe cắm ổ SSD<br/>
- Đồ họa: 	NVIDIA® GeForce® GTX 1050Ti 	4GB<br/>
- Màn hình: 15.6inchs 1920x1080 pixels, 	IPS anti-glare micro-edge WLED-backlit, không cảm ứng<br/>
- Âm thanh: 	B&O PLAY, dual speakers, HP Audio Boost<br/>
- Tính năng mở rộng & cổng giao tiếp:1 HDMI 2.0; 1 headphone/microphone combo; 1 RJ-45; 1 USB 3.1 Type-C™ Gen 1 (Data Transfer up to 5 Gb/s); 3 USB 3.1 Gen 1 (Data transfer only)<br/>
- Giao tiếp mạng: LAN Integrated 10/100/1000 GbE LAN, Wi-Fi 	Intel® Wireless-AC 9560 802.11a/b/g/n/ac(2x2) Wi-Fi® and Bluetooth® 5 Combo<br/>
- Hệ điều hành: 	Windows 10 Home Single Language 64<br/>
- Pin 3-cell 52.5 Wh Li-ion prismatic and polymer liền, trọng lượng 2.17Kg nhựa<br/>','29.990.000','12','2018','HP'
),

('HP Envy 13 ah0027TU-Core i7 8550U','HP02.jpg',
N'- Bộ xử lý: Intel® Core™ i7 8550U 1.8GHz, 8MB Cache<br/>
- Bo mạch: Chipset 8th Generation Intel® Core™ i7 processor, Bus 2400MHz, hỗ trợ tối đa 16GB<br/>
- RAM: 8GB LPDDR3 2400MHz, 2 khe RAM<br/>
- Đĩa cứng: 	SSD 256GB, không có khe cắm ổ SSD<br/>
- Đồ họa: Intel® UHD Graphics 620<br/>
- Màn hình: 	13.3 inchs 1920x1080 pixels, FHD IPS BrightView micro-edge WLED-backlit, không cảm ứng<br/>
- Âm thanh: 	Bang & Olufsen, quad speakers, HP Audio Boost<br/>
- Tính năng mở rộng & cổng giao tiếp: 1 USB 3.1 Type-C™ Gen 1 (Data Transfer up to 5Gb/s, Power Delivery, DisplayPort™ 1.2, HP Sleep and Charge); 2 USB 3.1 Gen 1 (1 HP Sleep and Charge); 1 headphone/microphone combo<br/>
- Giao tiếp mạng: LAN Integrated 10/100/1000 GbE LAN, Wi-Fi 802.11 ac<br/>
- Hệ điều hành: Windows 10 Home<br/>
- Pin HP Long Life 4-cell, 53.2Wh Li-ion polymer liền, trọng lượng 	1.22Kg nhôm nguyên khối<br/>','26.990.000','12','2018','HP'
),

('HP Envy 13-ah0026TU','HP03.jpg',
N'- Bộ xử lý: Intel® Core™ i5 8250U 1.60GHz, 6MB Cache<br/>
- Bo mạch: Chipset intel, Bus 2133MHz, hỗ trợ tối đa 8GB<br/>
- RAM: 8GB LPDDR3 2133MHz, 1 khe RAM<br/>
- Đĩa cứng: 	SSD 256GB, không có khe cắm ổ SSD<br/>
- Đồ họa: Intel® UHD Graphics 620<br/>
- Màn hình: 	13.3 inchs 1920x1080 pixels, FHD IPS BrightView micro-edge WLED-backlit, không cảm ứng<br/>
- Âm thanh: 	Bang & Olufsen, quad speakers, HP Audio Boost<br/>
- Tính năng mở rộng & cổng giao tiếp: 1 USB 3.1 Type-C™ Gen 1 (Data Transfer up to 5 Gb/s, Power Delivery, DisplayPort™ 1.2, HP Sleep and Charge); 2 USB 3.1 Gen 1 (1 HP Sleep and Charge); 1 headphone/microphone combo<br/>
- Giao tiếp mạng: không có LAN, Wi-Fi Intel® Wireless-AC 7265 802.11ac (2x2) Wi-Fi® and Bluetooth® 4.2 Combo<br/>
- Hệ điều hành: Windows 10 Home<br/>
- Pin HP Long Life 4-cell 53.2Wh Li-ion polymer liền, trọng lượng 1.21Kg nhôm nguyên khối<br/>','21.990.000','12','2018','HP'
),

('HP Pavilion 15 cs0104TX-Core i7 8550U','HP04.jpg',
N'- Bộ xử lý: Intel® Core™ i7 8550U 	1.80GHz, 8MB cache<br/>
- Bo mạch: Chipset intel, Bus 4 GT/s OPI, hỗ trợ tối đa 16GB<br/>
- RAM: 4GB DDR4 2400 MHz, 2 khe RAM<br/>
- Đĩa cứng: HDD+SSD Optane™	1TB+16GB, có khe cắm ổ SSD<br/>
- Đồ họa: NVIDIA GeForce MX130 2GB<br/>
- Màn hình: 15.6 inchs 1920x1080 pixels, FHD SVA Anti-glare WLED-backlit, không cảm ứng<br/>
- Âm thanh: B&O PLAY, dual speakers, HP Audio Boost<br/>
- Tính năng mở rộng & cổng giao tiếp: 1 x SSD (M2 2280); 2 x USB 3.1 Gen 1 (Data transfer only); 1 x USB 3.1 Type-C™ Gen 1 (Data Transfer Only); 1 x HDMI; 1 x RJ45; 1 x headphone/microphone combo<br/>
- Giao tiếp mạng: LAN 	10/100/1000 Mbps, Wi-Fi 	Intel® 802.11a/b/g/n/ac (1x1) Wi-Fi®, Bluetooth® 4.2 Combo<br/>
- Hệ điều hành: Windows 10 Home Single Language 64-Bit<br/>
- Pin 3 cell, 41 Wh Li-ion rời, trọng lượng 1.86 Kg vỏ hợp kim<br/>','19.990.000','12','2018','HP'
),

('HP Pavilion x360 14-ba066TU','HP05.jpg',
N'- Bộ xử lý: Intel® Core™ i5 7200U 2.50 GHz, 3MB cache<br/>
- RAM: 4GB DDR4 2133 MHz, 1 khe RAM<br/>
- Đĩa cứng: 	HDD 500GB<br/>
- Đồ họa: Intel HD Graphics 620<br/>
- Màn hình: 14 inch 1920x1080 pixels, FHD IPS WLED-backlit multitouch-enabled edge-to-edge glass, có cảm ứng<br/>
- Âm thanh: B&O PLAY; HP Audio Boost; Dual speakers<br/>
- Tính năng mở rộng & cổng giao tiếp: 1 x HDMI; 1 x headphone/microphone combo; 1 x USB 3.1 Type-C™ Gen 1 (Data up to 5 Gb/s); 2 x USB 3.1 Gen 1 (Data transfer only)<br/>
- Giao tiếp mạng: Không có LAN, Wi-Fi IEEE 802.11a/b/g/n/ac, Bluetooth 4.2<br/>
- Hệ điều hành: Windows 10 Home Single Language 64-Bit<br/>
- Pin 3 cell li ion, trọng lượng 1.63kg nhựa<br/>','16.990.000','12','2018','HP'
),

('Lenovo Legion Y520 15IKBN','Lenovo01.jpg',
N'- Bộ xử lý: Intel® Core™ i5 7300HQ 2.5Ghz, 6MB Cache<br/>
- Bo mạch: Chipset Intel® Chipset Express<br/>
- RAM: 8GB DDR4 	2400MHz, 2 khe RAM<br/>
- Đĩa cứng: HDD+SSD 1000Gb 5400rpm + 128GB PCIe, không có khe cắm ổ SSD<br/>
- Đồ họa: NVIDIA GeForce GTX 1050 4GB GDDR5 + Intel HD Graphics 620 	4GB<br/>
- Màn hình: 	15.6 inch 1920x1080 pixels, FHD IPS, không cảm ứng<br/>
- Âm thanh: Dolby Atmos 2.0<br/>
- Tính năng mở rộng & cổng giao tiếp:2 x USB 3.0 1 x USB 2.0 1 x HDMI™ 1 x USB Type C(USB 3.1) 1 x RJ45 LAN 1<br/>
- Giao tiếp mạng: LAN 10/100/1000M Gigabit Ethernet, Wi-Fi 802.11AC<br/>
- Hệ điều hành: 	Free Dos<br/>
- Pin 3 Cell Pin Li-Polymer liền, trọng lượng 2.4 kg nhựa đen tráng nhôm<br/>','20.490.000','12','2018','Lenovo'
),

('Lenovo ThinkPad Edge E580','Lenovo02.jpg',
N'- Bộ xử lý: Intel® Core™ i5 8250U 1.60 GHz, 6MB SmartCache<br/>
- Bo mạch:	Intel®, bus 2400MHz, hỗ trợ tối đa 16GB<br/>
- RAM: 4GB DDR4 2133MHz, 1 khe RAM<br/>
- Đĩa cứng: HDD 1000Gb, không có khe cắm ổ SSD<br/>
- Đồ họa: Intel® HD Graphics 620<br/>
- Màn hình: 	15.6 inch 1366 x 768 pixels, Anti-Glare LED Backlit, không cảm ứng<br/>
- Âm thanh: Stereo speakers with Dolby® Advanced Audio™<br/>
- Tính năng mở rộng & cổng giao tiếp: 1 x USB 2.0, 2 x USB 3.1 Gen 1 (one Always On), 1 x USB 3.1 Gen 2 Type-C (Power Delivery, DisplayPort, Data transfer) 1 x Smart Card Reader, HDMI<br/>
- Giao tiếp mạng: LAN 10/100/1000Mbps, Wi-Fi Intel® Dual Band Wireless AC<br/>
- Hệ điều hành: Windows 10<br/>
- Pin 3 Cells 42Whrs rời, trọng lượng 1.75 Kg nhựa<br/>','17.490.000','12','2018','Lenovo'
),

('Lenovo ThinkPad Edge E480','Lenovo03.jpg',
N'- Bộ xử lý: Intel® Core™ i5 8250U 1.60GHz, 6MB SmartCache<br/>
- Bo mạch:	Intel®, bus 2400MHz, hỗ trợ tối đa 8GB<br/>
- RAM: 4GB DDR4 	2400MHz, 2 khe RAM<br/>
- Đĩa cứng: HDD 1000Gb, không có khe cắm ổ SSD<br/>
- Đồ họa: Intel® UHD Graphics 620<br/>
- Màn hình: 14.0 inchs 1366 x 768 pixels, HD LED, không cảm ứng<br/>
- Âm thanh: 2.0<br/>
- Tính năng mở rộng & cổng giao tiếp: 1 x USB 2.0 1 x USB 3.0 1 x HDMI Card Reader<br/>
- Giao tiếp mạng: LAN 10/100/1000Mbps, Wi-Fi 11a/b/g/n/ac Wi-Fi wireless<br/>
- Hệ điều hành: 	Windows 10 Home<br/>
- Pin 3 Cells rời, trọng lượng 2.1Kg nhựa<br/>','16.490.000','12','2018','Lenovo'
),

('Lenovo ThinkPad E570','Lenovo04.jpg',
N'- Bộ xử lý: Intel® Core™ i5 7200U 2.50 GHz, 3 MB Cache<br/>
- Bo mạch: Up to 16 GB (2 DIMM) DDR4<br/>
- RAM: 4GB DDR4 2133MHz, 2 khe RAM<br/>
- Đĩa cứng: HDD 500Gb, có khe cắm ổ SSD<br/>
- Đồ họa: NVIDIA Geforce 940M (2GB)<br/>
- Màn hình: 15.6 inchs 1366 x 768 pixels, Anti-Glare LED-Backlit Display, không cảm ứng<br/>
- Âm thanh: 2.0<br/>
- Tính năng mở rộng & cổng giao tiếp: LAN, USB 2.0, USB 3.0, HDMI<br/>
- Giao tiếp mạng: LAN 10/100/1000Mbps, Wi-Fi 802.11ac<br/>
- Hệ điều hành:	Windows 10 Single Language Home<br/>
- Pin 4 Cells rời, trọng lượng 2.30kg nhựa<br/>','15.990.000','12','2017','Lenovo'
),

('Lenovo ThinkPad E470','Lenovo05.jpg',
N'- Bộ xử lý: Intel® Core™ i5 7200U 2.50 GHz, 3MB Cache<br/>
- Bo mạch: Up to 16GB (2 DIMM) DDR4<br/>
- RAM: 4GB DDR4 2133MHz, 2 khe RAM<br/>
- Đĩa cứng: HDD 500Gb, có khe cắm ổ SSD<br/>
- Đồ họa: Intel® HD Graphics 620<br/>
- Màn hình: 14.0 inchs 1366 x 768 pixels, Anti-Glare LED-Backlit Display, không cảm ứng<br/>
- Âm thanh: 2.0<br/>
- Tính năng mở rộng & cổng giao tiếp: HDMI, LAN (RJ45), USB 2.0, USB 3.0<br/>
- Giao tiếp mạng: LAN 10/100/1000Mbps, Wi-Fi 802.11ac<br/>
- Hệ điều hành:	Windows 10 Single Language Home<br/>
- Pin 6 Cells rời, trọng lượng 1.87kg nhôm<br/>','14.990.000','12','2017','Lenovo'
)
go

insert tbFeedback values
(N'Website có ích',N'Website có ích trong việc lựa chọn các mẫu laptop, các admin tư vấn phù hợp với nhu cầu','2015-10-24','U01',N'Cám ơn bạn. Chúng tôi sẽ cố gắng hoàn thiện trang web hơn','2015-10-24','A02'),
(N'Góp ý',N'Mong các admin trong tương lai cố gắng hồi đáp nhanh hơn những thắc mắc, nhu cầu tư vấn của mem nhé','2016-01-22','U03',N'Cám ơn bạn đã góp ý. Hiện nay đội ngũ admin còn hạn chế, nhưng chúng tôi sẽ cố gắng phản hồi nhanh hơn','2016-01-22','A01'),
(N'Thêm Sản Phẩm',N'Website cần có nhiều sản phẩm hơn','2016-01-22','U02',N'Cám ơn bạn đã góp ý. Chúng tôi sẽ bổ sung thêm sản phẩm trong tương lai','2016-01-22','A01'),
(N'Giao diện website',N'Mong các anh cải tiến giao diện trang web để dễ sử dụng hơn nhé','2016-02-24','U01',N'Cám ơn bạn đã góp ý','2016-02-24','A03'),
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



