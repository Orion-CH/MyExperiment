--ʵ��7
select * from student_course
select * from student
--1��������ϵ��ѧ��ѧ�ź�����

select sno, sname from student
where dno like '�����'

--2����ѡ���˿γ̵�ѧ��ѧ��
select distinct sno from student_course

--3����ѡ����c1�γ̵�ѧ��ѧ�źͳɼ������Բ�ѯ������ɼ��������У�����ɼ���ͬ��ѧ����������
select sno, score from student_course
where cno = '1'
order by score desc, sno asc

--4����ѡ�޿γ�c1�ҳɼ���80~90֮���ѧ��ѧ�źͳɼ��������ɼ�����0.75���
select sno, score*0.75 '�ɼ�����0.75��' from student_course
where cno=1 and score between 80 and 90

--5��������ϵ����ѧϵ���ŵ�ѧ������Ϣ
select * from student 
where sname like '��%' and (dno like '�����' or dno like '��ѧ')

--6����ȱ���˳ɼ���ѧ����ѧ�źͿγ̺�
select sno, cno from student_course where score is null  --�ж��ǿ�Ҫ��is null��������=

--���Ӳ�ѯ����
--1����ѯÿ��ѧ��������Լ�����ѡ�޵Ŀγ̣���������Ȼ���ӣ�ȥ�����ظ���������
select student.sno, sname, sex, native, birthday, dno, spno, classno,entime,home,tel,student_course.cno, score
from student, student_course where student.sno= student_course.sno

--��������ֻ����ʾ���Ѿ�ѡ��ѧ�������ѡ�ε���Ϣ��
--Ϊ���ڽ����Ҳ�ܳ���ûѡ�ε�ѧ�������������ʹ���������ӽ��в�ѯ
select student.sno, sname, sex, native, birthday, dno, spno, classno,entime,home,tel,student_course.cno, score
from student left outer join student_course on (student.sno = student_course.sno)

--2����ѧ����ѧ�ţ�������ѡ�޵Ŀγ������ɼ�������ѯ�漰��3����ʹ�ö�����ӣ�
select student.sno 'ѧ��', sname '����', cname '�γ���', score '�ɼ�' from student, student_course, course
where student.sno = student_course.sno and student_course.cno = course.cno

--3����ѡ��c1�γ��ҳɼ���90�����ϵ�ѧ��ѧ�ţ��������ɼ�
select student_course.sno, student.sname, score from student_course, student
where student_course.sno = student.sno and
	student_course.score >= 90 and cno = '1'

select * from course
--4����ѯÿһ�ſεļ�����޿Σ����޿ε����޿Σ�
--���ڽ���ʱû���������п���һѡ����Խ�spno������Ϊ���п�����
select thefirst.cno '�γ�', thesecond.spno '���޿�'
from course thefirst, course thesecond
where thefirst.spno = thesecond.cno