--ʵ��13
--1�������ṹ 
--��дһ�γ����ж�һ�����(����1900��)�Ƿ�������,������ʾ1900��Ϊ����,������ʾ1900�겻������. 
declare @y int;
set @y = 2000
if ((@y%4=0) and (@y%100 <> 0)) or @y%400=0 
	print cast(@y as varchar) + '������'
else
	print cast(@y as varchar) + '��������'

--2��ѭ���ṹ 
--(1)�����Ǽ���1~100�͵�ѭ���ṹ��ִ��֮�����ѭ���ṹ����ע�������־BEGIN ... END 
DECLARE @SUM INT,@I INT
SELECT @I=1,@SUM=0
WHILE @I<=100
BEGIN
	SELECT @SUM=@SUM+@I
	SELECT @I=@I+1
END
PRINT '1...100�ĺ�Ϊ��'+CONVERT(CHAR(4),@SUM) 

--2����дһ��������������10�Ľ׳�
declare @j int, @factorial int;
select @j=1, @factorial =1;
while @j<=10
begin
	select @factorial = @factorial * @j
	select @j = @j + 1
end

print '10�Ľ׳�Ϊ��'+cast(@factorial as varchar)

--3����ӡ��100���ڵ�����
--drop function prime
--�������Ҫ�޸ģ�����ɾ��ԭ���ĺ���Ȼ�����´���

create function prime(@n int)  
--��дһ���ж������ĺ��� 
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

print '100���ڵ�����Ϊ��'
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


--3��CASE�ṹ 
--��1������SQL��ѯͼ�����Ϣ��������ͼ�鶨���ж��Ƿ��ʺ���Ϊ�̲� 
use ͼ��_����
select ����, ������, ����,
	case
		when ����>50 then '����̫�ߣ����ʺ����̲�'
		else '����' + CAST(���� as varchar(5)) + '���������̲�' 
	end �ɷ���Ϊ�̲�
from book

--��2�����Լ����ʵ�ָ�λͬѧ�ĳɼ��Եȼ�����ʾ��:
--90�ּ�����Ϊ��,80�ּ����ϵ�90����Ϊ��,70�ּ����ϵ�80������Ϊ��,
--60�ּ����ϵ�70������Ϊ����,����Ϊ������. 
use EDUC
--��дһ���жϵȼ��ĺ���
create function print_grade(@s int)
returns varchar(6)
as
begin
return case 
		when @s < 60 then  '������'
		when @s between 60 and 69 then  '����'
		when @s between 70 and 79 then  '��'
		when @s between 80 and 89 then  '��'
		else  '��'
	   end
end

select student.sno ѧ��, sname ����,score ����, �ɼ� = dbo.print_grade(score)
from student, student_course
where student.sno = student_course.sno and score is not null


--4������ʹ��
--�����ѯ����ʾ��ǰ���ڣ���ʾ��ʽΪ��"������XXXX��XX��XX�գ�����X",ִ��֮,���ϵͳ�������÷�. 
select '������'+DATENAME(YEAR,GETDATE())+'��'+DATENAME(MONTH,GETDATE())+'��'+DATENAME(DAY,GETDATE())+'��'+DATENAME(WEEKDAY,GETDATE())