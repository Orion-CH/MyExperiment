--实验5 修改数据库基本定义
use EDUC;
--1、修改列属性
--（1）将student表中的birthday设置为not null
alter table student
alter column birthday smalldatetime not null;  --将birthday字段设为非空

--（2）将student表中的sno char(12)改为varchar(20)
--说明：由于之前将sno设置为了student的主键，无法直接修改。

--修改sno属性之前，先解除主键的约束，修改完再加上

--解除主键的时候发现sno正在被student_course表参照，所以又要先解除外键约束
alter table student_course
drop constraint FK__student_cou__sno__4AB81AF0

alter table student
drop constraint PK__student__DDDF6446182565BB

alter table student
alter column sno varchar(20) not null; --将sno属性设置为varchar（20）

alter table student
add constraint PK_student primary key(sno)  --重新把sno设置为主键


--重新添加外键的时候又发现了问题，sno属性修改后变为了varchar，而student_course中sno还是 char(12)
--先解除student_course中的主键，修改类型，再重新设置主键
alter table student_course
drop constraint PK__student___905C0533533364DB

alter table student_course
alter column sno varchar(20) not null;

alter table student_course
add constraint PK_student_course primary key(sno, cno)

alter table student_course
add constraint FK_course_sno foreign key (sno) references student(sno)



--2、添加列

alter table course
add year varchar(4) null;  ---添加一列year属性

alter table course
add constraint C1 check(year between 2004 and 2008) --给year字段添加约束，使其属性值在2004到2008之间

--3、删除列
alter table course
drop constraint C1  --删除列year，需要先解除约束C1

alter table course
drop column year
