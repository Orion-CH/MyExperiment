--实验9
--1、求选修了高等数学的学生学号和姓名
select sno as 学号, sname as 姓名
from student
where sno in (
	select sno  -- 找到了选课表里选了数学课的学生的学号
	from student_course
	where cno in (
		select cno 
		from course
		where cname = '数学'
	)
)

--2、求1号课程的成绩高于张三的学生的学号和成绩
select sno 学号, score 成绩
from student_course
where cno='1' and score > any(
	select score  --选出张三的1号课程的成绩
	from student_course
	where cno = '1' and sno in(
		select sno from student where sname='张三'
	)
)

--3、求其他系中比计算机系某一学生年龄小的学生信息
--  （即求其他系中年龄小于计算机系年龄最大者的学生）
select *
from student
where dno <> '计算机' and birthday > (
-- 其他系（不是计算机系） =》  dno<>'计算机'
-- 年龄小 =》 出生日期大
	select max(birthday)
	from student
	where dno = '计算机'
)

--4、 求其他系中比计算机系学生年龄都小的学生信息
select *
from student
where dno <> '计算机' and birthday > all(
	select birthday from student where dno like '计算机'
)

--5、求选修了c2课程的学生姓名
select sname 选修了2号课程的学生姓名
from student
where sno in (  --然后用学号作为条件找出学生的姓名
	select sno from student_course where cno = '2' --找出选修了2号课程的学号
)

--6、求没有选修c2课程的学生姓名
select sname 选修了2号课程的学生姓名
from student
where sno not in(  --然后用学号作为条件找出学生的姓名
	select sno from student_course where cno = '2' --找出选修了2号课程的学号
)

--7、查询选修了全部课程的学生的姓名
--说明：由于sql语言没有全称量词，
--所以题目的意思要被等价为：求一个学生的姓名，没有一门课没有被他选
select sname --找一个学生的姓名
from student 
where not exists( --不存在
	select * --这样一个课程
	from course
	where not exists( --这个课程没有被学生选
		select *
		from student_course sc
		where sc.sno = student.sno and sc.cno = course.cno
	)
)

--8、求至少选修了学号为“20130802044”的学生所选修的全部课程的学生学号和姓名
--本查询可以用逻辑蕴含来表达：
--原题意为：
--查询学号、姓名为x的学生，对于所有课程y，只要20130802044学生选修了课程y，则x也选修了y
--由于sql语言中没有表示‘任意’的全称量词以及‘蕴含’的逻辑运算符，
--所以我们将上述语句经过谓词演算转化为等价的：
--查询学号、姓名为x的学生，对于每个学生x：不存在这样的课程y，学生20130802044选修了课程y，而学生x没有选
select distinct sno, sname  --对于这样的学生stu_x
from (select student_course.sno, sname from student_course, student where student_course.sno = student.sno) as stu_x
where not exists( --不存在
	select * from student_course as sc_y --这样的课程y，使得
	where sc_y.sno = '20130802044' and   -- 此where条件表示：学生'20130802044'选修了课程y，而学生x没有选
		not exists(
			select * from student_course as sc_medium
			where sc_medium.sno = stu_x.sno 
										and sc_medium.cno = sc_y.cno
		)
)


