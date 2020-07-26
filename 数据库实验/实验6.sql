--实验6 创建和删除索引
--1、建立索引
--(1) 在student表的sname列上建立普通降序索引。
create index sname_desc on student(sname desc) --普通索引：不是唯一索引?
--(2) 在course表的cname列上建立唯一索引。
create unique index cname_unique on course(cname)

--(3)在student_course表的sno列上建立聚集索引。
--无法创建聚集索引：SQL Server中，一个表只能创建1个聚集索引，多个非聚集索引。如果设置某列为主键，该列就默认为聚集索引
--在student_course中，sno和cno已经构成主键，所以已经有1个聚集索引了，无法再添加聚集索引
--create clustered index sno_cluster on student_course(sno)

alter table student_course
drop constraint PK_student_course --先删除主键约束，默认的聚集索引也随之删除

create clustered index sno_cluster on student_course(sno) --现在就可以创建聚集索引了

alter table student_course
add constraint PK_student_course primary key (sno, cno) --再把主键加上

--(4)在student_course表的sno(升序), cno(升序)和score(降序)三列上建立一个普通索引。
create index student_course_sno_cno_score on student_course(sno asc, cno asc, score desc)

--2、删除student_course的sno上的聚集索引删掉
drop index student_course.sno_cluster