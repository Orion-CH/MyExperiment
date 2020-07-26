--ʵ��11 ʹ����ͼ
--һ��������ͼ
--1����������ϵѧ�����������ͼV_Computer
create view V_Computer
as
select * from student where dno = '�����'

select * from V_Computer

--2����Student Course��Student_course����ѧ����ѧ�ţ��������γ̺ţ��γ������ɼ�����Ϊ��ͼV_S_C_G
create view V_S_C_G
as
select student.sno, sname, course.cno, cname, score
from student, student_course, course
where student.sno = student_course.sno and student_course.cno = course.cno

select * from V_S_C_G

--3������ϵѧ��������ƽ�����䶨��Ϊ��ͼV_NUM_AVG
--�Ȱ�����Ū��һ����ͼ
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

--4������һ����ӳѧ��������ݵ���ͼV_YEAR
create view V_YEAR(sname, sno, birthday)
as
select sno, sname, birthday from student

select * from V_YEAR

--5������λѧ�� ѡ�޿γ̵����� ��ƽ���ɼ�����Ϊ��ͼV_AVG_S_G
create view V_AVG_S_G(sno, sname, total_course, avg_score)
as
select student.sno, sname, count(cno), avg(score)
from student, student_course
where student.sno = student_course.sno
group by student.sno, sname

select * from V_AVG_S_G

--6�������ſγ̵� ѡ��������ƽ���ɼ�����Ϊ��ͼV_AVG_C_G
create view V_AVG_C_G(cno, cname, total_stu, avg_score)
as
select course.cno, cname, count(sno), avg(score)
from course, student_course
where course.cno = student_course.cno
group by course.cno, cname

select * from V_AVG_C_G

--����ʹ����ͼ
--1����ѯ������ͼ�Ľ��
select * from V_Computer
select * from V_S_C_G
select * from V_NUM_AVG
select * from V_YEAR
select * from V_AVG_S_G
select * from V_AVG_C_G

--2����ѯƽ���ɼ���80�������˵�����,�������������
--������V_AVG_S_G����ƽʱ�ɼ���ʱ��Ҳ������ѧ����Ϣ������ֱ�Ӵ�V_AVG_S_G�в�ѯ����
select sno, sname, avg_score from V_AVG_S_G
where avg_score > 80
order by avg_score desc

--3����ѯ���γɼ�������ƽ���ɼ���ѧ��ѧ�š��������γ̺ͳɼ�
create view ������Ϣ(sno, sname, ѧ������ƽ���ɼ��Ŀγ���)
as
select V_S_C_G.sno, sname, count(score)
from V_S_C_G, V_AVG_C_G
where V_S_C_G.cno = V_AVG_C_G.cno and V_S_C_G.score > V_AVG_C_G.avg_score
group by V_S_C_G.sno,sname

select * from V_S_C_G where sno in(
	select V_AVG_S_G.sno
	from V_AVG_S_G, ������Ϣ
	where V_AVG_S_G.sno = ������Ϣ.sno and total_course =  ѧ������ƽ���ɼ��Ŀγ��� 
	--��һ��ѧ��������ƽ���ɼ��Ŀγ��� = ��ѡ���� ��ʱ��������Ϊ���ѧ���Ƿ���Ҫ���
	--�������Ƚ�����һ����ͼ��������Ϣ��������ÿ��ѧ����ѧ�ź���λѧ������ƽ���ɼ��γ̵�����
	--Ȼ��������������ѡ�������бȽϣ�ɸѡ������Ҫ���ѧ��
	--������ͼ�������ر���ѯ
)


--4����ϵͳ�Ƹ�ϵƽ���ɼ���80�����ϵ��������������������
select dno as רҵ, count(student.sname) as 'ƽ���ɼ�>80������'
from student, V_AVG_S_G
where student.sno = V_AVG_S_G.sno and avg_score >80
group by dno
order by 'ƽ���ɼ�>80������' desc

--�����޸���ͼ
--1��ͨ����ͼV_Computer���ֱ�ѧ��Ϊ��20131701110���͡�20131702111����ѧ����������Ϊ��AAAA��,��BBBB�� ����ѯ���;
select * from V_Computer

update V_Computer
set sname = 'AAAA'
where sno = '20131701110'

update V_Computer
set sname = 'BBBB'
where sno = '20131702111'

select * from V_Computer
select * from student  
-- ���ǿ��Կ������޸�����ͼ֮��student���е�����Ҳ�����˸ı�
-- Ҳ����˵������ͼ�ĸ���������ת��Ϊ�����ݱ�ĸ��µ�

--2��ͨ����ͼV_Computer��������һ��ѧ����¼ ('33333333333','YAN XI', '1990-1-1','2006-1-1','�����')������ѯ���
insert into V_Computer(sno, sname, sex, birthday, entime, dno, spno)
values ('33333333333', 'YAN XI', '��', '1990-1-1','2006-1-1', '�����', '001')

select * from student
select * from V_Computer

--3��Ҫͨ����ͼV_AVG_S_G����ѧ��Ϊ��S1����ƽ���ɼ���Ϊ90�֣��Ƿ����ʵ�֣���˵��ԭ��
/*
�𣺲���ʵ�֡�
���ȣ�������ͼ�ǲ�ʵ�ʴ洢���ݵ������˶���ͼ�ĸ���Ҫת��Ϊ�Ի�����ĸ��¡�
������ͼ�Ĳ�ѯ������ͼ�ĸ��²���Ҳ��ͨ����ͼ���⣬ת��Ϊ�Ի����ĵĸ��²�����
��ǰ���ʿ��Կ�����������ͼ��ʱ�򣬻�����Ҳ�����˱仯��

�ڹ�ϵ�����ݿ��У���Щ��ͼ�ǲ��ܸ��µģ���Ϊ��Щ��ͼ�ĸ��²���Ψһ���������ת���ɶ���Ӧ������ĸ���
��ͼV_AVG_S_G�е�ƽ���ɼ���ͨ����student_course���е�Ԫ���������ƽ��ֵ�����ģ�
���Զ�ƽ���ɼ��ĸ����޷�ת��Ϊ��student_course��ĸ��£����ݿ��޷��޸ĸ��Ƴɼ���ʹ��ƽ���ɼ���Ϊ90��
*/