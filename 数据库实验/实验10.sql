--ʵ��10

--������ͼ
--1������һ��V_�����ϵѧ������ͼ����ʹ�ø���ͼʱ������ʾstudent �е������ֶ�
create view V_�����ϵѧ��
as 
select * from student
--��ѯһ��
select * from V_�����ϵѧ��

--2��(1)ÿ��ѧ����ѧ�š�������ѡ�޵Ŀ������ɼ�����ͼS_C_Grade
create view S_C_Grade (sno, sname, sdept, cno, score)
as 
select student.sno, sname, cname, student_course.cno, score from student, student_course, course
where student.sno=student_course.sno and student_course.cno=course.cno


select sno as ѧ��, sname as ����, sdept as �γ���, cno as �γ̺�, score as �ɼ� from S_C_Grade

--(2)�����ϵѧ����ѧ�ţ�ѡ�޿γ̺��Լ�ƽ���ɼ�����ͼ������
create view COMPUTE_AVG_GRADE (sno, cno, avg_score)
as 
select sno, cno, avg(score)
from student_course
where sno in(
	select sno from student where dno = '�����'
)
group by sno, cno

select sno as ѧ��, cno as �γ̺�, avg_score as ƽ���ɼ� from COMPUTE_AVG_GRADE

--�޸���ͼ
alter view COMPUTE_AVG_GRADE(sno, cno, avg_score)
as  
select sno, cno, avg(score) from student_course 
where sno in(
	select sno from student where dno = '��ѧ'
)
group by sno, cno

select sno as ѧ��, cno as �γ̺�, avg_score as ƽ���ɼ� from COMPUTE_AVG_GRADE  --�ٴβ鿴һ��

--�޸���ͼ����
--����ͼ��V_�����ϵѧ��������Ϊ��V_�����ϵ������
sp_rename 'V_�����ϵѧ��','V_�����ϵ����'

--ɾ����ͼ
drop view V_�����ϵ����
drop view COMPUTE_AVG_GRADE