--ʵ��6 ������ɾ������
--1����������
--(1) ��student���sname���Ͻ�����ͨ����������
create index sname_desc on student(sname desc) --��ͨ����������Ψһ����?
--(2) ��course���cname���Ͻ���Ψһ������
create unique index cname_unique on course(cname)

--(3)��student_course���sno���Ͻ����ۼ�������
--�޷������ۼ�������SQL Server�У�һ����ֻ�ܴ���1���ۼ�����������Ǿۼ��������������ĳ��Ϊ���������о�Ĭ��Ϊ�ۼ�����
--��student_course�У�sno��cno�Ѿ����������������Ѿ���1���ۼ������ˣ��޷�����Ӿۼ�����
--create clustered index sno_cluster on student_course(sno)

alter table student_course
drop constraint PK_student_course --��ɾ������Լ����Ĭ�ϵľۼ�����Ҳ��֮ɾ��

create clustered index sno_cluster on student_course(sno) --���ھͿ��Դ����ۼ�������

alter table student_course
add constraint PK_student_course primary key (sno, cno) --�ٰ���������

--(4)��student_course���sno(����), cno(����)��score(����)�����Ͻ���һ����ͨ������
create index student_course_sno_cno_score on student_course(sno asc, cno asc, score desc)

--2��ɾ��student_course��sno�ϵľۼ�����ɾ��
drop index student_course.sno_cluster