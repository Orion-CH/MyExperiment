--实验8
--1、求学生的总人数
select count(*) '学生总人数' from student
--2、求学生选修了课程的学生人数
select count(distinct sno) '选课学生人数' from student_course
--3、求课程的课程号和选修该课程的人数
select cno '课程号', count(sno) '选课人数' from student_course group by cno
--4、求选修超过3门课的学生学号
--（改进：利用了外连接操作，在筛选的同时可以同时显示学号，姓名和这个学生选课次数）
select student_course.sno '学号', sname '姓名', count(cno) '选课次数' 
from student left outer join student_course on (student.sno = student_course.sno)
group by student_course.sno, sname having count(cno)>3
