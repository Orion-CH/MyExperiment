--ʵ��9
--1����ѡ���˸ߵ���ѧ��ѧ��ѧ�ź�����
select sno as ѧ��, sname as ����
from student
where sno in (
	select sno  -- �ҵ���ѡ�α���ѡ����ѧ�ε�ѧ����ѧ��
	from student_course
	where cno in (
		select cno 
		from course
		where cname = '��ѧ'
	)
)

--2����1�ſγ̵ĳɼ�����������ѧ����ѧ�źͳɼ�
select sno ѧ��, score �ɼ�
from student_course
where cno='1' and score > any(
	select score  --ѡ��������1�ſγ̵ĳɼ�
	from student_course
	where cno = '1' and sno in(
		select sno from student where sname='����'
	)
)

--3��������ϵ�бȼ����ϵĳһѧ������С��ѧ����Ϣ
--  ����������ϵ������С�ڼ����ϵ��������ߵ�ѧ����
select *
from student
where dno <> '�����' and birthday > (
-- ����ϵ�����Ǽ����ϵ�� =��  dno<>'�����'
-- ����С =�� �������ڴ�
	select max(birthday)
	from student
	where dno = '�����'
)

--4�� ������ϵ�бȼ����ϵѧ�����䶼С��ѧ����Ϣ
select *
from student
where dno <> '�����' and birthday > all(
	select birthday from student where dno like '�����'
)

--5����ѡ����c2�γ̵�ѧ������
select sname ѡ����2�ſγ̵�ѧ������
from student
where sno in (  --Ȼ����ѧ����Ϊ�����ҳ�ѧ��������
	select sno from student_course where cno = '2' --�ҳ�ѡ����2�ſγ̵�ѧ��
)

--6����û��ѡ��c2�γ̵�ѧ������
select sname ѡ����2�ſγ̵�ѧ������
from student
where sno not in(  --Ȼ����ѧ����Ϊ�����ҳ�ѧ��������
	select sno from student_course where cno = '2' --�ҳ�ѡ����2�ſγ̵�ѧ��
)

--7����ѯѡ����ȫ���γ̵�ѧ��������
--˵��������sql����û��ȫ�����ʣ�
--������Ŀ����˼Ҫ���ȼ�Ϊ����һ��ѧ����������û��һ�ſ�û�б���ѡ
select sname --��һ��ѧ��������
from student 
where not exists( --������
	select * --����һ���γ�
	from course
	where not exists( --����γ�û�б�ѧ��ѡ
		select *
		from student_course sc
		where sc.sno = student.sno and sc.cno = course.cno
	)
)

--8��������ѡ����ѧ��Ϊ��20130802044����ѧ����ѡ�޵�ȫ���γ̵�ѧ��ѧ�ź�����
--����ѯ�������߼��̺�����
--ԭ����Ϊ��
--��ѯѧ�š�����Ϊx��ѧ�����������пγ�y��ֻҪ20130802044ѧ��ѡ���˿γ�y����xҲѡ����y
--����sql������û�б�ʾ�����⡯��ȫ�������Լ����̺������߼��������
--�������ǽ�������侭��ν������ת��Ϊ�ȼ۵ģ�
--��ѯѧ�š�����Ϊx��ѧ��������ÿ��ѧ��x�������������Ŀγ�y��ѧ��20130802044ѡ���˿γ�y����ѧ��xû��ѡ
select distinct sno, sname  --����������ѧ��stu_x
from (select student_course.sno, sname from student_course, student where student_course.sno = student.sno) as stu_x
where not exists( --������
	select * from student_course as sc_y --�����Ŀγ�y��ʹ��
	where sc_y.sno = '20130802044' and   -- ��where������ʾ��ѧ��'20130802044'ѡ���˿γ�y����ѧ��xû��ѡ
		not exists(
			select * from student_course as sc_medium
			where sc_medium.sno = stu_x.sno 
										and sc_medium.cno = sc_y.cno
		)
)


