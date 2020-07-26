--实验13
--1、条件结构 
--编写一段程序判断一个年份(比如1900年)是否是闰年,是则显示1900年为闰年,否则显示1900年不是闰年. 
declare @y int;
set @y = 2000
if ((@y%4=0) and (@y%100 <> 0)) or @y%400=0 
	print cast(@y as varchar) + '是闰年'
else
	print cast(@y as varchar) + '不是闰年'

--2、循环结构 
--(1)下面是计算1~100和的循环结构，执行之，体会循环结构程序，注意语句块标志BEGIN ... END 
DECLARE @SUM INT,@I INT
SELECT @I=1,@SUM=0
WHILE @I<=100
BEGIN
	SELECT @SUM=@SUM+@I
	SELECT @I=@I+1
END
PRINT '1...100的和为：'+CONVERT(CHAR(4),@SUM) 

--2、编写一个程序用来计算10的阶乘
declare @j int, @factorial int;
select @j=1, @factorial =1;
while @j<=10
begin
	select @factorial = @factorial * @j
	select @j = @j + 1
end

print '10的阶乘为：'+cast(@factorial as varchar)

--3、打印出100以内的素数
--drop function prime
--函数如果要修改，得先删除原来的函数然后重新创建

create function prime(@n int)  
--先写一个判断素数的函数 
returns int
as
begin
	declare @i int;
	select @i = 2;
	while (@i < @n)
	begin
		--print @i
		if(@n % @i =0)
			return 0
		select @i = @i + 1
	end
	return 1
end

declare @r int
select @r = dbo.prime(29)
print @r

print '100以内的素数为：'
declare @num int, @count int;
declare @target int;
select @num = 100;
select @count = 2;
while (@count <= 100)
begin

	select @target = dbo.prime(@count);
	if (@target=1)
		print @count
	select @count = @count +1
end


--3、CASE结构 
--（1）下面SQL查询图书的信息，并根据图书定价判断是否适合作为教材 
use 图书_读者
select 书名, 出版社, 作者,
	case
		when 定价>50 then '定价太高，不适合作教材'
		else '定价' + CAST(定价 as varchar(5)) + '，可以作教材' 
	end 可否作为教材
from book

--（2）请自己编程实现各位同学的成绩以等级分显示即:
--90分及以上为优,80分及以上到90以下为良,70分及以上到80分以下为中,
--60分及以上到70分以下为及格,其余为不及格. 
use EDUC
--先写一个判断等级的函数
create function print_grade(@s int)
returns varchar(6)
as
begin
return case 
		when @s < 60 then  '不及格'
		when @s between 60 and 69 then  '及格'
		when @s between 70 and 79 then  '中'
		when @s between 80 and 89 then  '良'
		else  '优'
	   end
end

select student.sno 学号, sname 姓名,score 分数, 成绩 = dbo.print_grade(score)
from student, student_course
where student.sno = student_course.sno and score is not null


--4、函数使用
--下面查询，显示当前日期，显示格式为："今天是XXXX年XX月XX日，星期X",执行之,体会系统函数的用法. 
select '今天是'+DATENAME(YEAR,GETDATE())+'年'+DATENAME(MONTH,GETDATE())+'月'+DATENAME(DAY,GETDATE())+'日'+DATENAME(WEEKDAY,GETDATE())