--ʵ��3 ������ɾ�����ݿ�
--1������userdb1
create database userdb1
on
(name=userdb4_data,
filename='c:\database_experiment1\userdb4.mdf' ,
size=5,
maxsize=10,
filegrowth=1)
log on  --����־�ļ��ĵ�ַ
( name=userdb4_log, 
filename='c:\database_experiment1\userdb4.ldf ' , 
size=2 , 
maxsize=5 , 
filegrowth=1)

--2������EDUC
create database EDUC
on
( name = N'student_data', 
  filename = N'C:\sql_data\student_data.mdf' , 
  size = 10MB , 
  maxsize = 50MB , 
  filegrowth = 5%)
/*�ַ���ǰ���� N ����������ݿ�ʱ�� Unicode ��ʽ�洢*/
 log on 
( name = N'student_log', 
  filename = N'C:\sql_data\student_log' , 
  size = 2MB , 
  maxsize = 5MB , 
  filegrowth = 1MB )

 --3��ɾ��userdb1
 drop database userdb1
