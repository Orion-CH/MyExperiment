create database AirplaneManagement;
use AirplaneManagement;

--drop database AirplaneManagement

-- 客户类型
create table cType(   
	ctypeNo		char(2) primary key,	-- 客户类型编号
	typeName	char(10),				-- 客户类型名称
	discount	float					-- 折扣
)
/*
ctypeNo 为00时，说明是不打折的普通用户，折扣为1
*/

create table customer(
	cId		char(20) primary key,	-- 旅客身份证号，用于标识客户
	cname	varchar(20),			-- 旅客姓名
	sex		char(2),				-- 旅客性别 {男，女}
	ctypeNo	char(2),				-- 客户类型编号
	phone	char(15),				-- 电话号，考虑到不同国家不同
	totalMile int,					-- 客户的总里程数
	constraint FK_customer foreign key (ctypeNo) references cType(ctypeNo)
)


create table airplane_route(
	routeNo		char(8) primary key,	-- 航线编号
	departAirport	varchar(50),		-- 出发机场
	landAirport		varchar(50),		-- 降落机场
	departureTime	smalldatetime,		-- 出发时间(几点)
	arriveTime		smalldatetime,		-- 到达时间(几点)
	ticketPrice		float,				-- 票价
	mile			int					-- 这个航线单程的里程数，用于统计客户的总里程计算优惠
)

create table airplane(
	airplaneNo	char(8) primary key,	-- 飞机编号
	company		varchar(20),			-- 航空公司
	routeNo		char(8),				-- 航线编号
	model		char(20),				-- 飞机型号
	buyTime		smalldatetime,			-- 购买时间
	life		int,					-- 寿命（年）
	sitNum		int,					-- 座位数量
	descrip		varchar(50),			-- 备注信息
	constraint FK_airplane foreign key (routeNo) references airplane_route(routeNo)
)

create table book_ticket(
	airplaneNo	char(8),		-- 主键，飞机号
	routeNo		char(8),		-- 主键，航线号
	cId			char(20),		-- 主键，旅客身份号
	orderTime	smalldatetime,	-- 下单时间
	finalPrice	float,			-- 最终的价格
	primary key (airplaneNo, routeNo, cId),
	foreign key (airplaneNo) references airplane(airplaneNo),
	foreign key (routeNo) references airplane_route(routeNo),
	foreign key (cId) references customer(cId)
)

--drop trigger insert_ticket

create trigger insert_ticket
on book_ticket
instead of insert  --在插入前，要先用折扣计算最终的价格
as
-- 得到要插入的信息
declare @airplaneNo char(8)
declare @routeNo char(8)
declare @cId	char(20)
declare @ordertime smalldatetime
select @ordertime = GETDATE()  -- 获取当前系统时间作为订单时间

select @airplaneNo=airplaneNo, @routeNo=routeNo, @cId=cId from inserted

-- 先根据客户的类型找到折扣
declare @cTypeno char(2)   -- 找到用户类型
select @cTypeno = cTypeno from customer where cId = @cId
declare @discount float  -- 找到用户的折扣
select @discount = discount from cType where ctypeNo = @cTypeno

-- 得到飞机票本来的价格
declare @originPrice float
select @originPrice = ticketPrice from airplane_route where routeNo = @routeNo

-- 计算得到实际价格
declare @finalPrice float
select @finalPrice = @discount * @originPrice

-- 插入实际信息
insert into book_ticket
values (@airplaneNo, @routeNo, @cId, @orderTime, @finalPrice)

-- 将里程累积到客户的总里程上
declare @mile int  -- 找到本次的单程里程数
select @mile = mile from airplane_route where routeNo = @routeNo

declare @totalMile int  -- 找到这个旅客之前的总里程数
select @totalMile = totalMile from customer where cId = @cId  
select @totalMile = @totalMile + @mile
update customer set totalMile = @totalMile where cId = @cId

-- 再计算一下客户的类型需不需要提高
declare @newTypeNum char(2)
if @cTypeno != '00'  -- '00'表示普通用户，不参与里程优惠
begin
	select @newTypeNum = case 
							when @totalMile >= 10000 then  '03'
							when @totalMile >= 5000  then  '02'
							when @totalMile >= 2000  then  '01'
						 end

	if @newTypeNum != @cTypeno  -- 如果类型有变动，那么更新旅客信息
		update customer set ctypeNo = @newTypeNum where cId = @cId
end

go
