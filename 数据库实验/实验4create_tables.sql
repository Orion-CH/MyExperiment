--实验4
use EDUC; --选择EDUC数据库
--1、创建各表
create table student(
	sno		char(12) NOT NULL,  --学生学号，由于考虑到兰州大学学生的学号是12位的，所以将原本的char(8)改为char(12)
	sname	char(8) NOT NULL,  
	sex		char(2) NULL,		
	native	char(20) NULL,
	birthday smalldatetime NULL,
	dno		char(6) NULL,
	spno	char(8) NULL,
	classno char(4) NULL,
	entime	smalldatetime NULL,
	home	varchar(40) NULL,
	tel		varchar(40) NULL,

	primary key(sno)
)

create table teacher(
	tno		char(8) NOT NULL,
	tname	char(8) NOT NULL,
	sex		char(2) NULL,
	birthday smalldatetime NULL,
	dno		char(6) NULL,
	pno		tinyint NULL,
	home	varchar(40) NULL,
	zipcode char(6) NULL,
	tel		varchar(40) NULL,
	email	varchar(49) NULL

	primary key(tno)
)

create table course( 
	cno		char(10) NOT NULL,
	spno	char(8) NULL,
	cname	char(20) NOT NULL,
	ctno	tinyint NULL,
	expertiment	tinyint NULL,
	lecture	tinyint NULL,
	semester	tinyint NULL,
	credit	tinyint NULL,

	primary key(cno)
)


create table student_course(
	sno char(12) NOT NULL,
	cno char(10) NOT NULL,
	score tinyint NULL,
	primary key(sno, cno),
	foreign key (sno) references student(sno),
	foreign key (cno) references course(cno)
)


create table teacher_course(
	tcid		smallint NOT NULL primary key,
	tno			char(8) NULL,  --外键，连接教师表的教师编号，确保此表中的教师存在
	spno		char(8) NULL,
	classno		char(4) NULL,
	cno			char(10) NOT NULL,  --外键， 连接课程表的课程号，确保有这个课程
	semester	char(6) NULL,
	schoolyear	char(10) NULL,
	classtime	varchar(40) NULL,
	classroom	varchar(40) NULL,
	weektime	tinyint NULL,
	foreign key (tno) references teacher(tno),
	foreign key (cno) references course(cno)
)

--3、删除表student_course, student 和 course
drop table student_course;
drop table student;

--说明：由于在建表的时候，我将老师教课的表参照了course表中的课程号作为外键，所以删除course前需要先解除参照关系
alter table teacher_course
drop constraint FK__teacher_cou__cno__4222D4EF  --我发现每次建表时生成的外键尾号不一样

drop table course ;

--4、删除表teacher_course和teacher
drop table teacher_course
drop table teacher

--5、用sql语句创建student, course, student_course, teacher, teacher_course表（见1）
