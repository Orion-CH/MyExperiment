use TeachingActivity;
--1���洢����
--��1������һ���洢���̣��ô洢����ͳ�ơ��ߵ���ѧ���ĳɼ��ֲ�����������ո�������ͳ�������� 
create proc grade_distribute (@math char(20) = '�ߵ���ѧ') 
as
SELECT @math as cname,  -- ���鰴����ͳ�ƣ�ȥ��
count(case when score>=90 then 1 end)as[90����],
count(case when score>=80 and score<90 then 1 end)as[80-90],
count(case when score>=70 and score<80 then 1 end)as[70-80],
count(case when score>=60 and score<70 then 1 end)as[60-70],
count(case when score<60 then 1 end)as[60����] FROM study,course
WHERE study.cno=course.cno and course.cname= @math
GROUP BY course.cname

execute grade_distribute  --Ĭ�ϲ�ѯ���Ǹߵ���ѧ�ķֶ�
execute grade_distribute @math = '���ݽṹ' --��ѯ��Ŀγ�Ҳ�ǿ��Ե�

--��2������һ���洢���̣��ô洢������һ�������������տγ̺ţ��ô洢����ͳ�Ƹ����γ̵�ƽ���ɼ��� 
--drop proc avg_score
create proc avg_score(@cno char(4))
as
select @cno, cname, avg(score) as ƽ���ɼ�
from study, course
where study.cno = course.cno and study.cno = @cno
group by study.cno, cname

execute avg_score @cno = 'C601'

--��3������һ���洢���̣��ô洢���̽�ѧ��ѡ�γɼ��Ӱٷ��Ƹ�Ϊ�ȼ��ƣ��� A��B��C��D��E����
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

--��4������һ���洢���̣��ô洢������һ��������������ѧ���������ô洢���̲�ѯ��ѧ����ѧ���Լ�ѡ�޿γ̵�������
create proc query_sno_cnum(@sname char(8))
as
select @sname as ѧ������, study.sno as ѧ��, count(study.cno) as ѡ�޵Ŀγ̵�����
from study, student
where student.sno = study.sno and student.sname = @sname
group by study.sno

execute query_sno_cnum @sname='��ǿ'

--��5������һ���洢���̣��ô洢�������������������������ѧ�źͿγ̺ţ�һ������������ڻ�ȡ��Ӧѧ�źͿγ̺Ŷ�Ӧ�ĳɼ���
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

select @score_geted as ��ѡ����Ϣ��Ӧ�ĳɼ�

--2��������
--��1��Ϊstudy����һ��UPDATE�������������³ɼ�ʱ��Ҫ����º�ĳɼ����ܵ���ԭ���ĳɼ���
create trigger update_grade
on study --��study���ϴ���������
instead of update  -- instead of �ڲ���֮ǰ����
as
declare @old_score smallint
declare @sno_new char(5),@cno_new char(4) 
declare @new_score smallint
select @cno_new =cno,@sno_new=sno, @new_score=score from inserted  --����Ҫ������¼�¼
select @old_score=score from deleted   --�����ڸ��º�ɾ���ľɼ�¼
if(@new_score>=@old_score) --�������Ҫ�󣬽��и���
update study set score=@new_score where sno=@sno_new and cno=@cno_new
else  --������Ҫ�󣬴�ӡ������Ϣ
print '�޷�ִ�У�Ҫ����º�ĳɼ����ܵ���ԭ���ĳɼ���'
go

update study set score=0 where sno='98601' --���ִ�����ʾ

--��2��Ϊstudy����һ��DELETE��������Ҫ��һ��ֻ�ܴ�study����ɾ��һ����¼��
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
	print 'һ�β���ɾ��������¼!'
go

delete from study


select * from course
--(3)Ϊcourse����һ��INSERT��������Ҫ�����Ŀγ̼�¼���ον�ʦ����Ϊ�ա�
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
print '������ον�ʦ����Ϊ�գ�'
go

insert into course(cno, cname) values('0001', '���������ŵ�����')  --��ʾ����


--3������
--(1)����һ�����ر���ֵ���û����庯�� RectangleArea��������εĳ��Ϳ���ܼ�����ε������
create function RectangleArea(@length float, @width float)
returns float
as
begin
	return @length*@width
end

declare @area float;
select @area = dbo.RectangleArea(2.5, 5)
print '�������Ϊ��'+str(@area,5,2)  --������Ҫ������λС������Ȼת��ʱ�ᱻȡ����

--��2������һ���û��Զ��庯��������Ϊ����һ���й�ѧ���ɼ�ͳ�Ƶı���
--�ñ�����ʾÿһ�ſγ̵Ŀγ̺š��γ�����ѡ��������������߷֡���ͷֺ�ƽ���֡�
--�������������������Ӧ�ı������û������  
create function score_report()
returns table
as
return(
	select study.cno �γ̺�, cname �γ���, count(sno) ѡ������, max(score) ��߷�, min(score) ��ͷ�, avg(score) ƽ����
	from study,course
	where study.cno = course.cno
	group by study.cno, cname
)
go

select * from dbo.score_report()