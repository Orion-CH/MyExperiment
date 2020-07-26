--ʵ��4
use EDUC; --ѡ��EDUC���ݿ�
--1����������
create table student(
	sno		char(12) NOT NULL,  --ѧ��ѧ�ţ����ڿ��ǵ����ݴ�ѧѧ����ѧ����12λ�ģ����Խ�ԭ����char(8)��Ϊchar(12)
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
	tno			char(8) NULL,  --��������ӽ�ʦ��Ľ�ʦ��ţ�ȷ���˱��еĽ�ʦ����
	spno		char(8) NULL,
	classno		char(4) NULL,
	cno			char(10) NOT NULL,  --����� ���ӿγ̱�Ŀγ̺ţ�ȷ��������γ�
	semester	char(6) NULL,
	schoolyear	char(10) NULL,
	classtime	varchar(40) NULL,
	classroom	varchar(40) NULL,
	weektime	tinyint NULL,
	foreign key (tno) references teacher(tno),
	foreign key (cno) references course(cno)
)

--3��ɾ����student_course, student �� course
drop table student_course;
drop table student;

--˵���������ڽ����ʱ���ҽ���ʦ�̿εı������course���еĿγ̺���Ϊ���������ɾ��courseǰ��Ҫ�Ƚ�����չ�ϵ
alter table teacher_course
drop constraint FK__teacher_cou__cno__4222D4EF  --�ҷ���ÿ�ν���ʱ���ɵ����β�Ų�һ��

drop table course ;

--4��ɾ����teacher_course��teacher
drop table teacher_course
drop table teacher

--5����sql��䴴��student, course, student_course, teacher, teacher_course����1��
