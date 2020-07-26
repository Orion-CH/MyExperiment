--实验11 使用视图
--一、定义视图
--1、定义计算机系学生基本情况视图V_Computer
create view V_Computer
as
select * from student where dno = '计算机'

select * from V_Computer

--2、将Student Course和Student_course表中学生的学号，姓名，课程号，课程名，成绩定义为视图V_S_C_G
create view V_S_C_G
as
select student.sno, sname, course.cno, cname, score
from student, student_course, course
where student.sno = student_course.sno and student_course.cno = course.cno

select * from V_S_C_G

--3、将各系学生人数，平均年龄定义为视图V_NUM_AVG
--先把年龄弄成一个视图
create view stu_age(sno, dno, age)
as
select sno, dno, year(getdate())-year(birthday) from student
where dno is not null and birthday is not null

select * from stu_age

create view V_NUM_AVG(dno, avg_num, avg_age)
as
select dno, count(sno), avg(age)
from stu_age
group by dno

select * from V_NUM_AVG

--4、定义一个反映学生出生年份的视图V_YEAR
create view V_YEAR(sname, sno, birthday)
as
select sno, sname, birthday from student

select * from V_YEAR

--5、将各位学生 选修课程的门数 及平均成绩定义为视图V_AVG_S_G
create view V_AVG_S_G(sno, sname, total_course, avg_score)
as
select student.sno, sname, count(cno), avg(score)
from student, student_course
where student.sno = student_course.sno
group by student.sno, sname

select * from V_AVG_S_G

--6、将各门课程的 选修人数及平均成绩定义为视图V_AVG_C_G
create view V_AVG_C_G(cno, cname, total_stu, avg_score)
as
select course.cno, cname, count(sno), avg(score)
from course, student_course
where course.cno = student_course.cno
group by course.cno, cname

select * from V_AVG_C_G

--二、使用视图
--1、查询以上视图的结果
select * from V_Computer
select * from V_S_C_G
select * from V_NUM_AVG
select * from V_YEAR
select * from V_AVG_S_G
select * from V_AVG_C_G

--2、查询平均成绩在80分以上人的数据,结果按降序排列
--由于在V_AVG_S_G中算平时成绩的时候，也加入了学生信息，所以直接从V_AVG_S_G中查询即可
select sno, sname, avg_score from V_AVG_S_G
where avg_score > 80
order by avg_score desc

--3、查询各课成绩均大于平均成绩的学生学号、姓名、课程和成绩
create view 辅助信息(sno, sname, 学生大于平均成绩的课程数)
as
select V_S_C_G.sno, sname, count(score)
from V_S_C_G, V_AVG_C_G
where V_S_C_G.cno = V_AVG_C_G.cno and V_S_C_G.score > V_AVG_C_G.avg_score
group by V_S_C_G.sno,sname

select * from V_S_C_G where sno in(
	select V_AVG_S_G.sno
	from V_AVG_S_G, 辅助信息
	where V_AVG_S_G.sno = 辅助信息.sno and total_course =  学生大于平均成绩的课程数 
	--当一个学生：大于平均成绩的课程数 = 总选课数 的时候，我们认为这个学生是符合要求的
	--所以我先建立了一个视图（辅助信息），保存每个学生的学号和这位学生大于平均成绩课程的数量
	--然后把这个数量和总选课数进行比较，筛选出符合要求的学生
	--借助视图更清晰地表达查询
)


--4、按系统计各系平均成绩在80分以上的人数，结果按降序排列
select dno as 专业, count(student.sname) as '平均成绩>80的人数'
from student, V_AVG_S_G
where student.sno = V_AVG_S_G.sno and avg_score >80
group by dno
order by '平均成绩>80的人数' desc

--三、修改视图
--1、通过视图V_Computer，分别将学号为“20131701110”和“20131702111”的学生姓名更改为“AAAA”,”BBBB” 并查询结果;
select * from V_Computer

update V_Computer
set sname = 'AAAA'
where sno = '20131701110'

update V_Computer
set sname = 'BBBB'
where sno = '20131702111'

select * from V_Computer
select * from student  
-- 我们可以看到，修改完视图之后，student表中的数据也发生了改变
-- 也就是说，对视图的更新最终是转化为对数据表的更新的

--2、通过视图V_Computer，新增加一个学生记录 ('33333333333','YAN XI', '1990-1-1','2006-1-1','计算机')，并查询结果
insert into V_Computer(sno, sname, sex, birthday, entime, dno, spno)
values ('33333333333', 'YAN XI', '男', '1990-1-1','2006-1-1', '计算机', '001')

select * from student
select * from V_Computer

--3、要通过视图V_AVG_S_G，将学号为“S1”的平均成绩改为90分，是否可以实现？并说明原因
/*
答：不能实现。
首先，由于视图是不实际存储数据的虚表，因此对视图的更新要转换为对基本表的更新。
正如视图的查询，对视图的更新操作也是通过视图消解，转换为对基本的的更新操作。
（前两问可以看到，更新视图的时候，基本表也发生了变化）

在关系型数据库中，有些视图是不能更新的，因为这些视图的更新不能唯一地有意义地转换成对相应基本表的更新
视图V_AVG_S_G中的平均成绩是通过对student_course表中的元组分组后计算平均值得来的，
所以对平均成绩的更新无法转换为对student_course表的更新，数据库无法修改各科成绩，使得平均成绩变为90分
*/