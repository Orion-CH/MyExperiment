--1������������ͼ�����
--Ҫ���������ߵ�ͼ�鶨�۲����� ȫ�����������ͼ���ƽ�����۵�2��
select ��� 
from book  
group by ���
having max(����)>= all (
select book1.ƽ�����۵�2��
from(select avg(����)*2 as ƽ�����۵�2��, ��� from book group by ���) book1  --�������Ӳ�ѯ
) 

--2�����е��ҵ���������ĸ���ͼ���ƽ�����ۣ��ֱ���group by��group by all
select ���, avg(����) ����ͼ��ƽ������ from book
where ������ = '��е��ҵ������' 
group by ���

select ���, avg(����) ����ͼ��ƽ������ from book
where ������ = '��е��ҵ������' 
group by all ���  -- group by all ���ڸ߰汾������, �ѿյ�ֵ�����Ҳ�г�����

--3���г��������ͼ�����š����Ƽ��۸��������������ܼ۸�
select ���, ����, ���� from book where ��� = '�����'
select count(*) '����', sum(����) '�ܼ۸�' from book where ���='�����'

--4���г��������ͼ�����š����Ƽ��۸�
--���������������������ܼ۸�������ȫ���������ܼ۸�
select ���, ����, ���� from book where ���='�����'
select count(*) '�ܲ���', ������, sum(����) '�ܼ۸�' from book where ���='�����' group by ������
select count(*) '�ܲ���', sum(����) '�ܼ۸�' from book where ���='�����'

--5����ѯ�������ͻ�е��ҵ����������ͼ��
select * from book where ��� = '�����' and ������ = '��е��ҵ������'

