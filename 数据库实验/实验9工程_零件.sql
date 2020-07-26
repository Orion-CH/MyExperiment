--实验9 工程-零件

--1、求供应项目j4红色零件的供应商号及名称
--此查询结果为空，因为j4所用零件为p6和p2，一个是绿色，一个是黑色，没有用到红色零件
select 供应商代码,姓名 from 供应商
where 供应商代码 in (
	select 供应商代码 from 供应零件
	where 工程代码 = 'J4' and 零件代码 in (
		select 零件代码 from 零件 where  颜色 = '红色'
	)
)
-- 为了验证以上语句的正确性，我们可以求供应项目j2红色零件的供应商号及名称
--此时查询结果为s1
select 供应商代码,姓名 from 供应商
where 供应商代码 in (
	select 供应商代码 from 供应零件
	where 工程代码 = 'J2' and 零件代码 in (
		select 零件代码 from 零件 where  颜色 = '红色'
	)
)

--2、求没有上海供应商生成的零件的项目号
select distinct 工程代码 项目号 from 供应零件
where 供应商代码 not in (
	select 供应商代码 from 供应商 where 姓名 like '%上海供应商%' 
)

--3、至少使用了供应商s5所供应的全部零件的项目号
--本查询可以用逻辑蕴含来表达：
--原题意为：
--选择这样的项目号x，使得：只要供应商s5供应了零件y，则项目x使用了零件y
--由于sql语言中没有表示‘任意’的全称量词以及‘蕴含’的逻辑运算符，
--所以我们将上述语句经过谓词演算转化为等价的：
--对于每个项目号x：不存在这样的零件y：供应商s5供应了，而项目x没有使用

select distinct 工程代码 from 供应零件 as pjx  --对于每个项目号pjx
where not exists( --不存在
	select * from 供应零件 as part_y  --这样的零件y，使得：
	where 供应商代码 = 'S5' and not exists( -- 供应商s5供应了，而项目x没有使用
		select * from 供应零件 med 
		where med.供应商代码 = part_y.供应商代码 and 
			med.工程代码 = pjx.工程代码
			)
	)
