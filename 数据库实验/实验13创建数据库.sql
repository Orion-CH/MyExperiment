create database TeachingActivity;
use TeachingActivity

create table student(
	sno		char(5) not null primary key,
	sname	char(8) not null,
	age		smallint check(age between 15 and 35),
	sex		nchar check(sex in ('男','女'))
)

create table course(
	cno char(4) not null primary key,
	cname char(20) not null,
	teacher char(8)
)

create table study(
	sno char(5) not null,
	cno char(4) not null,
	score smallint check(score between 0 and 100),
	primary key (sno, cno)
)

-- 插入数据
insert into study
values
('98601','C601',90)
insert into study
values(
'98601','C602', 90)
insert into study
values(
'98601', 'C603',85)
insert into study
values(
'98601', 'C604',87)
insert into study
values(
'98602', 'C601',90)
insert into study
values(
'98603', 'C601',75)
insert into study
values(
'98603', 'C602',70)
insert into study
values(
'98603', 'C604',56)
insert into study
values(
'98604', 'C601',90)
insert into study values(
'98604', 'C604',85)
insert into study 
values(
'98605','C601', 95)
insert into study
values(
'98605', 'C603',80)


insert into student values( '98601' ,'李强',20,'男')
insert into student values( '98602', '刘丽', 21, '男'); 
insert into student values( '98603', '张兵', 20, '男'); 
insert into student values( '98604', '陈志坚', 22, '男');
insert into student values( '98605', '王颖', 21,'男'); 

insert into course
values(
'C601', '高等数学','周振兴')
insert into course
values(
'C602', '数据结构','刘建平')
insert into course
values(
'C603', '操作系统','刘建平')
insert into course
values(
'C604', '编译原理','王志伟')