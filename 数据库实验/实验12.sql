--ʵ��12


--����֮ǰרҵ����û�п��ǵ�ʵ��12������������ʵ��ǰ�Ƚ���һЩ�޸�
insert into student values('201808701080','����˹','��','����','20001230','��ѧ','05','1','2018','�Ϸ�','13911212678')

update student
set spno = '001'
where sno in (
	select sno from student  where dno = '�����'
)

update student
set spno = '002'
where sno in (
	select sno from student where dno = '����'
)

update student
set spno = '003'
where sno in (
	select sno from student where dno = '��ѧ'
)

update student
set spno = '004'
where sno in (
	select sno from student where dno = '����'
)

update student
set spno = '000'
where sno in (
	select sno from student where dno is null
)

select * from student


--1������student��������רҵ��Ϊ��001���ģ�������ѧ���Ϊ2006��ѧ��������רҵ��Ϊ��003������������С��20���ѧ���İ༶�Ÿ�Ϊ��001����
update student
set classno = '001'
where (spno = '001' and entime = '2006') or (spno = '003' and 2019 - year(birthday)<20 )

select * from student

--2������student��ɾ����������С��20�꣬����רҵ��Ϊ��003����ѧ���ļ�¼��
delete from student
where 2019-year(birthday) <20 and spno = '003'

select * from student

--3������student������һ���¼�¼�����ľ�����ϢΪ��
--ѧ�ţ�2007110011�����������������Ա��С��������ڣ�19880808��Ժϵ��ţ���001����רҵ��ţ�
--��001�����༶�ţ���001������ѧʱ�䣺20070901��
insert into student values('2007110011', '������','��','�Ϻ�','19880808','�����','001','001','20070901','�Ϻ��ֶ�','13201238978')

--4������student������ѧʱ�������ѧ����������С��ѧ������ϵ��ʽȥ����
update student
set tel = null
where entime in (
	select min(entime) from student
) 
or birthday in (
	select min(birthday) from student
)

select * from student

--5������student����ƽ��������С��һ��Ժϵ��Ժϵ��Ÿ�Ϊ��008����
--��ѧ�͹���ƽ��������ͣ�Ϊ26��(����ͼV_NUM_AVG�п��ԱȽ�ֱ�۵Ŀ���)
update student
set spno = '008'
where dno in (
	select dno from V_NUM_AVG  where avg_age = (
		select min(avg_age) from V_NUM_AVG
	)
)

select * from student
