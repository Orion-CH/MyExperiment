	
insert into student values('20131701110','张福新','女','山东','19901211','计算机','17','2','2013','山东德州','15771384655')
insert into student values('20131702111','杨文婷','女','山西','19880309','计算机','17','2','2013','山西太原','15771384656')
insert into student values('20131703111','张琦','女','山西','19890316','计算机','17','2','2013','山西太原','15771381128')
insert into student values('20130802044','冯艺','女','山东','19900809','经济','08','1','2013','山东德州','15771383418')
insert into student values('201308702040','王仲','男','山东','19930623','工商','05','1','2014','山东德州','15771381378')
insert into student values('201308702041','李四','男','山东','19930724','数学','05','1','2012','广东佛山','15771381370')
insert into student values('201308701080','张三','男','山东','19931230','数学','05','1','2012','广东佛山','13901265678')
insert into student(sno, sname, birthday) values('000000000000','没选课的', '19991231')
insert into student(sno, sname, birthday) values('111111111111','全选了的', '19991231')
/*
delete from student_course
delete from course
delete from student
*/

insert into course values('1','8','数据库','001','9','18','1','3') 
insert into course values('2','0','网络工程','002','9','18','2','3') 
insert into course values('3','2','信息系统','003','9','18','2','3') 
insert into course values('4','2','ERP应用','004','9','18','2','2') 
insert into course values('5','0','移动商务','005','9','18','2','2')
insert into course values('6','0','数学','006','9','18','1','4')
insert into course values('7','9','操作系统','007','9','18','2','3')
insert into course values('8','6','数据结构','008','9','18','1','4')
insert into course values('9','0','数据处理','009','9','18','1','2')

insert into student_course(sno, cno, score)
values('20130802044', '1', 95),('20130802044', '2', 87),('20130802044', '3', 90)

insert into student_course(sno, cno, score)
values('201308702040', '1', 77),('201308702040', '2', 60),('201308702040', '3', 88)

insert into student_course(sno, cno, score)
values('20131701110', '2', 67),('20131701110', '4', 55),('20131701110', '5', 76)

insert into student_course(sno, cno, score)
values('20131702111', '3', 88),('20131702111', '4', 99),('20131702111', '5', 94)
insert into student_course(sno, cno, score) values('20131702111', '6', 88), ('20131702111', '7', 82)

insert into student_course(sno, cno, score)
values('20131703111', '1', 85),('20131703111', '4', 84),('20131703111', '5', 80)
insert into student_course(sno, cno, score) values('20131703111', '8', 88), ('20131703111', '9', 82)
insert into student_course(sno, cno, score) values('201308701080', '1', 59)
insert into student_course(sno, cno, score) values('201308702041', '1', 89)
insert into student_course(sno, cno) values('201308702041', '3') --还没有成绩默认为空
insert into student_course(sno, cno) values('111111111111', '1'),('111111111111', '2'),('111111111111', '3'),('111111111111', '4'),('111111111111', '5'),
('111111111111', '6'),('111111111111', '7'),('111111111111', '8'),('111111111111', '9')

select * from student
select * from course
select * from student_course