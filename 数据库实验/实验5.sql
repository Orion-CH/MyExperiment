--ʵ��5 �޸����ݿ��������
use EDUC;
--1���޸�������
--��1����student���е�birthday����Ϊnot null
alter table student
alter column birthday smalldatetime not null;  --��birthday�ֶ���Ϊ�ǿ�

--��2����student���е�sno char(12)��Ϊvarchar(20)
--˵��������֮ǰ��sno����Ϊ��student���������޷�ֱ���޸ġ�

--�޸�sno����֮ǰ���Ƚ��������Լ�����޸����ټ���

--���������ʱ����sno���ڱ�student_course����գ�������Ҫ�Ƚ�����Լ��
alter table student_course
drop constraint FK__student_cou__sno__4AB81AF0

alter table student
drop constraint PK__student__DDDF6446182565BB

alter table student
alter column sno varchar(20) not null; --��sno��������Ϊvarchar��20��

alter table student
add constraint PK_student primary key(sno)  --���°�sno����Ϊ����


--������������ʱ���ַ��������⣬sno�����޸ĺ��Ϊ��varchar����student_course��sno���� char(12)
--�Ƚ��student_course�е��������޸����ͣ���������������
alter table student_course
drop constraint PK__student___905C0533533364DB

alter table student_course
alter column sno varchar(20) not null;

alter table student_course
add constraint PK_student_course primary key(sno, cno)

alter table student_course
add constraint FK_course_sno foreign key (sno) references student(sno)



--2�������

alter table course
add year varchar(4) null;  ---���һ��year����

alter table course
add constraint C1 check(year between 2004 and 2008) --��year�ֶ����Լ����ʹ������ֵ��2004��2008֮��

--3��ɾ����
alter table course
drop constraint C1  --ɾ����year����Ҫ�Ƚ��Լ��C1

alter table course
drop column year
