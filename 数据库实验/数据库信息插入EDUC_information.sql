	
insert into student values('20131701110','�Ÿ���','Ů','ɽ��','19901211','�����','17','2','2013','ɽ������','15771384655')
insert into student values('20131702111','������','Ů','ɽ��','19880309','�����','17','2','2013','ɽ��̫ԭ','15771384656')
insert into student values('20131703111','����','Ů','ɽ��','19890316','�����','17','2','2013','ɽ��̫ԭ','15771381128')
insert into student values('20130802044','����','Ů','ɽ��','19900809','����','08','1','2013','ɽ������','15771383418')
insert into student values('201308702040','����','��','ɽ��','19930623','����','05','1','2014','ɽ������','15771381378')
insert into student values('201308702041','����','��','ɽ��','19930724','��ѧ','05','1','2012','�㶫��ɽ','15771381370')
insert into student values('201308701080','����','��','ɽ��','19931230','��ѧ','05','1','2012','�㶫��ɽ','13901265678')
insert into student(sno, sname, birthday) values('000000000000','ûѡ�ε�', '19991231')
insert into student(sno, sname, birthday) values('111111111111','ȫѡ�˵�', '19991231')
/*
delete from student_course
delete from course
delete from student
*/

insert into course values('1','8','���ݿ�','001','9','18','1','3') 
insert into course values('2','0','���繤��','002','9','18','2','3') 
insert into course values('3','2','��Ϣϵͳ','003','9','18','2','3') 
insert into course values('4','2','ERPӦ��','004','9','18','2','2') 
insert into course values('5','0','�ƶ�����','005','9','18','2','2')
insert into course values('6','0','��ѧ','006','9','18','1','4')
insert into course values('7','9','����ϵͳ','007','9','18','2','3')
insert into course values('8','6','���ݽṹ','008','9','18','1','4')
insert into course values('9','0','���ݴ���','009','9','18','1','2')

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
insert into student_course(sno, cno) values('201308702041', '3') --��û�гɼ�Ĭ��Ϊ��
insert into student_course(sno, cno) values('111111111111', '1'),('111111111111', '2'),('111111111111', '3'),('111111111111', '4'),('111111111111', '5'),
('111111111111', '6'),('111111111111', '7'),('111111111111', '8'),('111111111111', '9')

select * from student
select * from course
select * from student_course