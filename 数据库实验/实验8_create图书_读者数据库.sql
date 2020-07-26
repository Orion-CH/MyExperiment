--create database 图书_读者;
use 图书_读者;

create table book(
	书号			char(10) not null,
	类别			char(12) null,
	出版社		char(50) not null,
	作者			char(20) null,
	书名			char(50) not null,
	定价		money null,
	constraint PK_book primary key(书号)
)


create table reader(
	编号			char(10) not null,
	姓名			char(8) not null,
	单位			char(50) null,
	性别			char(2) null ,
	电话			char(15) null,
	constraint sex_check check (性别 in('男', '女')), 
	constraint PK_reader primary key(编号)
)

create table borrow_record(
	串号			char(10) not null,
	书号			char(10) not null,
	读者编号		char(10) not null,
	借阅日期		datetime not null,
	constraint PK_borrow_record primary key(串号),
	constraint FK_bookNumber foreign key(书号) references book(书号),
	constraint FK_readerNumber foreign key(读者编号) references reader(编号),
	constraint bkNum_rdNum_unique unique(书号, 读者编号)
)
/*
delete from borrow_record
delete from book
delete from reader
*/

insert into book
values
('1001','计算机','机械工业出版社','王民','数据结构',80),
('1002','计算机','机械工业出版社','张建平','计算机应用',20),
('1003','计算机','电子工业出版社','王敏','数据库技术',15),
('1004','计算机','电子工业出版社','谭浩强','C 语言',25),
('1005','英语','中国人民大学出版社','张锦芯','应用文写作',25),
('1006','管理','高等教育出版社','Robison','管理学',15),
('1007','管理','机械工业出版社','Fayol','工业管理',70),
('1008','数学','机械工业出版社','李平','线性代数',50),
('1009','管理','	机械工业出版社','Durark','公司的概念',14),
('1010','数学','机械工业出版社','徐新国','统计学',15)

insert into reader
values
('1001','丁一','数学院','男','81234567'),
('1002','赵二','经济学院','男','82234567'),
('1003','张三','管理学院','女','83234567'),
('1004','李四','文学院','男','84234567'),
('1005','王五','历史文化学院','女','85234567'),
('1006','孙六','物理学院','男','86234567'),
('1007','周七','生命科学院','女','87234567'),
('1008','徐八','化学院','男','88234567')

insert into borrow_record
values
('01','1001','1003','2000-1-1'),
('02','1002','1005','2002-3-5'),
('03','1003','1008','1998-6-18'),
('04','1004','1003','1997-12-8'),
('05','1005','1004','2001-5-4'),
('06','1006','1001','2005-7-25'),
('07','1007','1007','1997-11-3'),
('08','1008','1002','2004-2-1'),
('09','1009','1004','1996-9-1'),
('10','1010','1008','2000-6-4')

select * from reader
select * from book
select * from borrow_record