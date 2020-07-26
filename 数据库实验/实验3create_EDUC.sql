--实验3 创建和删除数据库
--1、创建userdb1
create database userdb1
on
(name=userdb4_data,
filename='c:\database_experiment1\userdb4.mdf' ,
size=5,
maxsize=10,
filegrowth=1)
log on  --存日志文件的地址
( name=userdb4_log, 
filename='c:\database_experiment1\userdb4.ldf ' , 
size=2 , 
maxsize=5 , 
filegrowth=1)

--2、创建EDUC
create database EDUC
on
( name = N'student_data', 
  filename = N'C:\sql_data\student_data.mdf' , 
  size = 10MB , 
  maxsize = 50MB , 
  filegrowth = 5%)
/*字符串前加上 N 代表存入数据库时以 Unicode 格式存储*/
 log on 
( name = N'student_log', 
  filename = N'C:\sql_data\student_log' , 
  size = 2MB , 
  maxsize = 5MB , 
  filegrowth = 1MB )

 --3、删除userdb1
 drop database userdb1
