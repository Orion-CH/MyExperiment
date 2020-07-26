--实验7
select * from student_course
select * from student
--1、求计算机系的学生学号和姓名

select sno, sname from student
where dno like '计算机'

--2、求选修了课程的学生学号
select distinct sno from student_course

--3、求选修了c1课程的学生学号和成绩，并对查询结果按成绩降序排列，如果成绩相同则按学号升序排列
select sno, score from student_course
where cno = '1'
order by score desc, sno asc

--4、求选修课程c1且成绩在80~90之间的学生学号和成绩，并将成绩乘以0.75输出
select sno, score*0.75 '成绩乘以0.75后' from student_course
where cno=1 and score between 80 and 90

--5、求计算机系和数学系姓张的学生的信息
select * from student 
where sname like '张%' and (dno like '计算机' or dno like '数学')

--6、求缺少了成绩的学生的学号和课程号
select sno, cno from student_course where score is null  --判断是空要用is null，不能用=

--连接查询操作
--1、查询每个学生的情况以及他所选修的课程（采用了自然连接，去除了重复属性名）
select student.sno, sname, sex, native, birthday, dno, spno, classno,entime,home,tel,student_course.cno, score
from student, student_course where student.sno= student_course.sno

--以上做法只能显示出已经选课学生情况及选课的信息，
--为了在结果中也能呈现没选课的学生情况，以下又使用了外连接进行查询
select student.sno, sname, sex, native, birthday, dno, spno, classno,entime,home,tel,student_course.cno, score
from student left outer join student_course on (student.sno = student_course.sno)

--2、求学生的学号，姓名，选修的课程名及成绩（本查询涉及到3个表，使用多表连接）
select student.sno '学号', sname '姓名', cname '课程名', score '成绩' from student, student_course, course
where student.sno = student_course.sno and student_course.cno = course.cno

--3、求选修c1课程且成绩在90分以上的学生学号，姓名及成绩
select student_course.sno, student.sname, score from student_course, student
where student_course.sno = student.sno and
	student_course.score >= 90 and cno = '1'

select * from course
--4、查询每一门课的间接先修课（先修课的先修课）
--由于建表时没有设置先行课这一选项，所以将spno属性作为先行课属性
select thefirst.cno '课程', thesecond.spno '先修课'
from course thefirst, course thesecond
where thefirst.spno = thesecond.cno