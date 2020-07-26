use TeachingActivity;
--1、存储过程
--（1）创建一个存储过程，该存储过程统计“高等数学”的成绩分布情况，即按照各分数段统计人数。 
create proc grade_distribute (@math char(20) = '高等数学') 
as
SELECT @math as cname,  -- 分组按条件统计，去重
count(case when score>=90 then 1 end)as[90以上],
count(case when score>=80 and score<90 then 1 end)as[80-90],
count(case when score>=70 and score<80 then 1 end)as[70-80],
count(case when score>=60 and score<70 then 1 end)as[60-70],
count(case when score<60 then 1 end)as[60以下] FROM study,course
WHERE study.cno=course.cno and course.cname= @math
GROUP BY course.cname

execute grade_distribute  --默认查询的是高等数学的分段
execute grade_distribute @math = '数据结构' --查询别的课程也是可以的

--（2）创建一个存储过程，该存储过程有一个参数用来接收课程号，该存储过程统计给定课程的平均成绩。 
--drop proc avg_score
create proc avg_score(@cno char(4))
as
select @cno, cname, avg(score) as 平均成绩
from study, course
where study.cno = course.cno and study.cno = @cno
group by study.cno, cname

execute avg_score @cno = 'C601'

--（3）创建一个存储过程，该存储过程将学生选课成绩从百分制改为等级制（即 A、B、C、D、E）。
create proc change_unit
as
select sname, study.sno, study.cno, cname, case
when score>=90 and score<=100 then 'A'
when score>=80 and score<90 then 'B'
when score>=70 and score<80 then 'C'
when score>=60 and score<70 then 'D'
else 'E'
end as level
from study, student, course
where study.sno = student.sno and study.cno = course.cno

execute change_unit

--（4）创建一个存储过程，该存储过程有一个参数用来接收学生姓名，该存储过程查询该学生的学号以及选修课程的门数。
create proc query_sno_cnum(@sname char(8))
as
select @sname as 学生姓名, study.sno as 学号, count(study.cno) as 选修的课程的门数
from study, student
where student.sno = study.sno and student.sname = @sname
group by study.sno

execute query_sno_cnum @sname='李强'

--（5）创建一个存储过程，该存储过程有两个输入参数用来接收学号和课程号，一个输出参数用于获取相应学号和课程号对应的成绩。
create proc get_score(
@sno char(5),
@cno char(4),
@score smallint output
)
as
select @score = score from study where sno=@sno and cno=@cno
go

declare @score_geted smallint

execute get_score
@sno = '98601',
@cno = 'C601',
@score = @score_geted output

select @score_geted as 该选课信息对应的成绩

--2、触发器
--（1）为study表创建一个UPDATE触发器，当更新成绩时，要求更新后的成绩不能低于原来的成绩。
create trigger update_grade
on study --在study表上创建触发器
instead of update  -- instead of 在操作之前进行
as
declare @old_score smallint
declare @sno_new char(5),@cno_new char(4) 
declare @new_score smallint
select @cno_new =cno,@sno_new=sno, @new_score=score from inserted  --即将要插入的新记录
select @old_score=score from deleted   --即将在更新后被删除的旧记录
if(@new_score>=@old_score) --如果满足要求，进行更新
update study set score=@new_score where sno=@sno_new and cno=@cno_new
else  --不满足要求，打印错误信息
print '无法执行，要求更新后的成绩不能低于原来的成绩！'
go

update study set score=0 where sno='98601' --出现错误提示

--（2）为study表创建一个DELETE触发器，要求一次只能从study表中删除一条记录。
create trigger delete_study_one
on study
instead of delete
as
declare @delete_num int
declare @sno char(5)
declare @cno char(4)
select @delete_num = count(*) from deleted
if(@delete_num =1) 
	begin
	select @sno=sno, @cno=cno from deleted
	delete from study where sno=@sno and cno=@cno
	end
else
	print '一次不能删除多条记录!'
go

delete from study


select * from course
--(3)为course表创建一个INSERT触发器，要求插入的课程记录中任课教师不能为空。
create trigger insert_course_notNull
on course
instead of insert
as
declare @cno char(4),@cname char(20),@teacher char(8)
select @cno=cno,@cname=cname,@teacher=teacher from inserted
if @teacher is not null
begin 
insert into course(cno, cname, teacher) values(@cno, @cname, @teacher)
end
else
print '插入的任课教师不能为空！'
go

insert into course(cno, cname) values('0001', '高数从入门到放弃')  --提示错误


--3、函数
--(1)创建一个返回标量值的用户定义函数 RectangleArea：输入矩形的长和宽就能计算矩形的面积。
create function RectangleArea(@length float, @width float)
returns float
as
begin
	return @length*@width
end

declare @area float;
select @area = dbo.RectangleArea(2.5, 5)
print '矩形面积为：'+str(@area,5,2)  --浮点数要保留两位小数，不然转换时会被取整了

--（2）创建一个用户自定义函数，功能为产生一张有关学生成绩统计的报表。
--该报表显示每一门课程的课程号、课程名、选修人数、本门最高分、最低分和平均分。
--调用这个函数，生成相应的报表并给用户浏览。  
create function score_report()
returns table
as
return(
	select study.cno 课程号, cname 课程名, count(sno) 选修人数, max(score) 最高分, min(score) 最低分, avg(score) 平均分
	from study,course
	where study.cno = course.cno
	group by study.cno, cname
)
go

select * from dbo.score_report()