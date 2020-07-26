--1、查找这样的图书类别：
--要求类别中最高的图书定价不低于 全部按类别分组的图书的平均定价的2倍
select 类别 
from book  
group by 类别
having max(定价)>= all (
select book1.平均定价的2倍
from(select avg(定价)*2 as 平均定价的2倍, 类别 from book group by 类别) book1  --派生表子查询
) 

--2、求机械工业出版社出版的各类图书的平均定价，分别用group by和group by all
select 类别, avg(定价) 各类图书平均定价 from book
where 出版社 = '机械工业出版社' 
group by 类别

select 类别, avg(定价) 各类图书平均定价 from book
where 出版社 = '机械工业出版社' 
group by all 类别  -- group by all 将在高版本被废弃, 把空的值的类别也列出来了

--3、列出计算机类图书的书号、名称及价格，最后求出册数和总价格
select 书号, 书名, 定价 from book where 类别 = '计算机'
select count(*) '册数', sum(定价) '总价格' from book where 类别='计算机'

--4、列出计算机类图书的书号、名称及价格，
--并求出各出版社这类书的总价格，最后求出全部册数和总价格
select 书号, 书名, 定价 from book where 类别='计算机'
select count(*) '总册数', 出版社, sum(定价) '总价格' from book where 类别='计算机' group by 出版社
select count(*) '总册数', sum(定价) '总价格' from book where 类别='计算机'

--5、查询计算机类和机械工业出版社出版的图书
select * from book where 类别 = '计算机' and 出版社 = '机械工业出版社'

