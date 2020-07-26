--实验10

--创建视图
--1、建立一个V_计算机系学生的视图，在使用该视图时，将显示student 中的所有字段
create view V_计算机系学生
as 
select * from student
--查询一下
select * from V_计算机系学生

--2、(1)每个学生的学号、姓名、选修的课名及成绩的视图S_C_Grade
create view S_C_Grade (sno, sname, sdept, cno, score)
as 
select student.sno, sname, cname, student_course.cno, score from student, student_course, course
where student.sno=student_course.sno and student_course.cno=course.cno


select sno as 学号, sname as 姓名, sdept as 课程名, cno as 课程号, score as 成绩 from S_C_Grade

--(2)计算机系学生的学号，选修课程号以及平均成绩的视图？？？
create view COMPUTE_AVG_GRADE (sno, cno, avg_score)
as 
select sno, cno, avg(score)
from student_course
where sno in(
	select sno from student where dno = '计算机'
)
group by sno, cno

select sno as 学号, cno as 课程号, avg_score as 平均成绩 from COMPUTE_AVG_GRADE

--修改视图
alter view COMPUTE_AVG_GRADE(sno, cno, avg_score)
as  
select sno, cno, avg(score) from student_course 
where sno in(
	select sno from student where dno = '数学'
)
group by sno, cno

select sno as 学号, cno as 课程号, avg_score as 平均成绩 from COMPUTE_AVG_GRADE  --再次查看一下

--修改视图名字
--将视图‘V_计算机系学生’改名为‘V_计算机系男生’
sp_rename 'V_计算机系学生','V_计算机系男生'

--删除视图
drop view V_计算机系男生
drop view COMPUTE_AVG_GRADE