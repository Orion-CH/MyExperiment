create database AirplaneManagement;
use AirplaneManagement;

--drop database AirplaneManagement

-- �ͻ�����
create table cType(   
	ctypeNo		char(2) primary key,	-- �ͻ����ͱ��
	typeName	char(10),				-- �ͻ���������
	discount	float					-- �ۿ�
)
/*
ctypeNo Ϊ00ʱ��˵���ǲ����۵���ͨ�û����ۿ�Ϊ1
*/

create table customer(
	cId		char(20) primary key,	-- �ÿ����֤�ţ����ڱ�ʶ�ͻ�
	cname	varchar(20),			-- �ÿ�����
	sex		char(2),				-- �ÿ��Ա� {�У�Ů}
	ctypeNo	char(2),				-- �ͻ����ͱ��
	phone	char(15),				-- �绰�ţ����ǵ���ͬ���Ҳ�ͬ
	totalMile int,					-- �ͻ����������
	constraint FK_customer foreign key (ctypeNo) references cType(ctypeNo)
)


create table airplane_route(
	routeNo		char(8) primary key,	-- ���߱��
	departAirport	varchar(50),		-- ��������
	landAirport		varchar(50),		-- �������
	departureTime	smalldatetime,		-- ����ʱ��(����)
	arriveTime		smalldatetime,		-- ����ʱ��(����)
	ticketPrice		float,				-- Ʊ��
	mile			int					-- ������ߵ��̵������������ͳ�ƿͻ�������̼����Ż�
)

create table airplane(
	airplaneNo	char(8) primary key,	-- �ɻ����
	company		varchar(20),			-- ���չ�˾
	routeNo		char(8),				-- ���߱��
	model		char(20),				-- �ɻ��ͺ�
	buyTime		smalldatetime,			-- ����ʱ��
	life		int,					-- �������꣩
	sitNum		int,					-- ��λ����
	descrip		varchar(50),			-- ��ע��Ϣ
	constraint FK_airplane foreign key (routeNo) references airplane_route(routeNo)
)

create table book_ticket(
	airplaneNo	char(8),		-- �������ɻ���
	routeNo		char(8),		-- ���������ߺ�
	cId			char(20),		-- �������ÿ���ݺ�
	orderTime	smalldatetime,	-- �µ�ʱ��
	finalPrice	float,			-- ���յļ۸�
	primary key (airplaneNo, routeNo, cId),
	foreign key (airplaneNo) references airplane(airplaneNo),
	foreign key (routeNo) references airplane_route(routeNo),
	foreign key (cId) references customer(cId)
)

--drop trigger insert_ticket

create trigger insert_ticket
on book_ticket
instead of insert  --�ڲ���ǰ��Ҫ�����ۿۼ������յļ۸�
as
-- �õ�Ҫ�������Ϣ
declare @airplaneNo char(8)
declare @routeNo char(8)
declare @cId	char(20)
declare @ordertime smalldatetime
select @ordertime = GETDATE()  -- ��ȡ��ǰϵͳʱ����Ϊ����ʱ��

select @airplaneNo=airplaneNo, @routeNo=routeNo, @cId=cId from inserted

-- �ȸ��ݿͻ��������ҵ��ۿ�
declare @cTypeno char(2)   -- �ҵ��û�����
select @cTypeno = cTypeno from customer where cId = @cId
declare @discount float  -- �ҵ��û����ۿ�
select @discount = discount from cType where ctypeNo = @cTypeno

-- �õ��ɻ�Ʊ�����ļ۸�
declare @originPrice float
select @originPrice = ticketPrice from airplane_route where routeNo = @routeNo

-- ����õ�ʵ�ʼ۸�
declare @finalPrice float
select @finalPrice = @discount * @originPrice

-- ����ʵ����Ϣ
insert into book_ticket
values (@airplaneNo, @routeNo, @cId, @orderTime, @finalPrice)

-- ������ۻ����ͻ����������
declare @mile int  -- �ҵ����εĵ��������
select @mile = mile from airplane_route where routeNo = @routeNo

declare @totalMile int  -- �ҵ�����ÿ�֮ǰ���������
select @totalMile = totalMile from customer where cId = @cId  
select @totalMile = @totalMile + @mile
update customer set totalMile = @totalMile where cId = @cId

-- �ټ���һ�¿ͻ��������費��Ҫ���
declare @newTypeNum char(2)
if @cTypeno != '00'  -- '00'��ʾ��ͨ�û�������������Ż�
begin
	select @newTypeNum = case 
							when @totalMile >= 10000 then  '03'
							when @totalMile >= 5000  then  '02'
							when @totalMile >= 2000  then  '01'
						 end

	if @newTypeNum != @cTypeno  -- ��������б䶯����ô�����ÿ���Ϣ
		update customer set ctypeNo = @newTypeNum where cId = @cId
end

go
