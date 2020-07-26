--create database ͼ��_����;
use ͼ��_����;

create table book(
	���			char(10) not null,
	���			char(12) null,
	������		char(50) not null,
	����			char(20) null,
	����			char(50) not null,
	����		money null,
	constraint PK_book primary key(���)
)


create table reader(
	���			char(10) not null,
	����			char(8) not null,
	��λ			char(50) null,
	�Ա�			char(2) null ,
	�绰			char(15) null,
	constraint sex_check check (�Ա� in('��', 'Ů')), 
	constraint PK_reader primary key(���)
)

create table borrow_record(
	����			char(10) not null,
	���			char(10) not null,
	���߱��		char(10) not null,
	��������		datetime not null,
	constraint PK_borrow_record primary key(����),
	constraint FK_bookNumber foreign key(���) references book(���),
	constraint FK_readerNumber foreign key(���߱��) references reader(���),
	constraint bkNum_rdNum_unique unique(���, ���߱��)
)
/*
delete from borrow_record
delete from book
delete from reader
*/

insert into book
values
('1001','�����','��е��ҵ������','����','���ݽṹ',80),
('1002','�����','��е��ҵ������','�Ž�ƽ','�����Ӧ��',20),
('1003','�����','���ӹ�ҵ������','����','���ݿ⼼��',15),
('1004','�����','���ӹ�ҵ������','̷��ǿ','C ����',25),
('1005','Ӣ��','�й������ѧ������','�Ž�о','Ӧ����д��',25),
('1006','����','�ߵȽ���������','Robison','����ѧ',15),
('1007','����','��е��ҵ������','Fayol','��ҵ����',70),
('1008','��ѧ','��е��ҵ������','��ƽ','���Դ���',50),
('1009','����','	��е��ҵ������','Durark','��˾�ĸ���',14),
('1010','��ѧ','��е��ҵ������','���¹�','ͳ��ѧ',15)

insert into reader
values
('1001','��һ','��ѧԺ','��','81234567'),
('1002','�Զ�','����ѧԺ','��','82234567'),
('1003','����','����ѧԺ','Ů','83234567'),
('1004','����','��ѧԺ','��','84234567'),
('1005','����','��ʷ�Ļ�ѧԺ','Ů','85234567'),
('1006','����','����ѧԺ','��','86234567'),
('1007','����','������ѧԺ','Ů','87234567'),
('1008','���','��ѧԺ','��','88234567')

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