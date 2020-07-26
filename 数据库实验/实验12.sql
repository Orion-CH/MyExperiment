--实验12


--由于之前专业代码没有考虑到实验12的需求，所以在实验前先进行一些修改
insert into student values('201808701080','爱因斯','男','安徽','20001230','数学','05','1','2018','合肥','13911212678')

update student
set spno = '001'
where sno in (
	select sno from student  where dno = '计算机'
)

update student
set spno = '002'
where sno in (
	select sno from student where dno = '经济'
)

update student
set spno = '003'
where sno in (
	select sno from student where dno = '数学'
)

update student
set spno = '004'
where sno in (
	select sno from student where dno = '工商'
)

update student
set spno = '000'
where sno in (
	select sno from student where dno is null
)

select * from student


--1．对于student表，将所有专业号为‘001’的，并且入学年份为2006的学生，或是专业号为‘003’，并且年龄小于20岁的学生的班级号改为‘001’。
update student
set classno = '001'
where (spno = '001' and entime = '2006') or (spno = '003' and 2019 - year(birthday)<20 )

select * from student

--2．对于student表，删掉所有年龄小于20岁，并且专业号为‘003’的学生的记录。
delete from student
where 2019-year(birthday) <20 and spno = '003'

select * from student

--3．对于student表，插入一条新记录，它的具体信息为，
--学号：2007110011、姓名：张三三、性别：男、出生日期：19880808、院系编号：‘001’、专业编号：
--‘001’、班级号：‘001’、入学时间：20070901。
insert into student values('2007110011', '张三三','男','上海','19880808','计算机','001','001','20070901','上海浦东','13201238978')

--4．对于student表，将入学时间最晚的学生和年龄最小的学生的联系方式去掉。
update student
set tel = null
where entime in (
	select min(entime) from student
) 
or birthday in (
	select min(birthday) from student
)

select * from student

--5．对于student表，将平均年龄最小的一个院系的院系编号改为‘008’。
--数学和工商平均年龄最低，为26岁(在视图V_NUM_AVG中可以比较直观的看到)
update student
set spno = '008'
where dno in (
	select dno from V_NUM_AVG  where avg_age = (
		select min(avg_age) from V_NUM_AVG
	)
)

select * from student
