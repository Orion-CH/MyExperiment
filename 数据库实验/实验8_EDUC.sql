--ʵ��8
--1����ѧ����������
select count(*) 'ѧ��������' from student
--2����ѧ��ѡ���˿γ̵�ѧ������
select count(distinct sno) 'ѡ��ѧ������' from student_course
--3����γ̵Ŀγ̺ź�ѡ�޸ÿγ̵�����
select cno '�γ̺�', count(sno) 'ѡ������' from student_course group by cno
--4����ѡ�޳���3�ſε�ѧ��ѧ��
--���Ľ��������������Ӳ�������ɸѡ��ͬʱ����ͬʱ��ʾѧ�ţ����������ѧ��ѡ�δ�����
select student_course.sno 'ѧ��', sname '����', count(cno) 'ѡ�δ���' 
from student left outer join student_course on (student.sno = student_course.sno)
group by student_course.sno, sname having count(cno)>3
