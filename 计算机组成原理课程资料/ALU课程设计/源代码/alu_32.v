module alu_32
(
	//����˿� 
	in0,in1,op,
	//����˿�
	out,overflow,zero,carryout
);
//-------------------------------------------------------------------------------------
//--     �ⲿ�˿�����
//-------------------------------------------------------------------------------------
input [31:0]in0;			//������0
input [31:0]in1;			//������1
input [10:0]op;				//���ű���
output reg [31:0]out;		//������
output reg overflow;		//�����־λ
output reg zero;			//���־λ
output reg carryout;		//��λ��־λ
//-------------------------------------------------------------------------------------
//--     �ڲ��˿�����
//-------------------------------------------------------------------------------------
wire overflow_result;		//�����־���
wire zero_result;			//���־���
wire carryout_result;		//��λ��־���
wire [31:0]and_result;		//����
wire [31:0]or_result;		//����
wire [31:0]xor_result;		//�����
wire [31:0]nor_result;		//��ǽ��
wire [31:0]add_result;		//�Ӽ������
reg [31:0]sllv_result;		//�߼����ƽ��
reg [31:0]srlv_result;		//�߼����ƽ��
reg [31:0]srav_result;		//�������ƽ��
reg Sub;					//�ӷ�����
//-------------------------------------------------------------------------------------
//--     ������������
//-------------------------------------------------------------------------------------
//���ű����
localparam  SLL=11'b00_0000,
			SRL=11'b00_0010,
			SRA=11'b00_0011,
			SLLV=11'b00_0100,
			SRLV=11'b00_0110,
			SRAV=11'b00_0111,
			ADD=11'b10_0000,
			ADDU=11'b10_0001,
			SUB=11'b10_0010,
			SUBU=11'b10_0011,
			AND=11'b10_0100,
			OR=11'b10_0101,
			XOR=11'b10_0110,
			NOR=11'b10_0111,
			SLT=11'b10_1010,
			SLTU=11'b10_1011;



//-------------------------------------------------------------------------------------
//--     �߼�����ʵ��
//-------------------------------------------------------------------------------------
always@(*)
begin
	case(op)
	SLL:				//�߼�����(��)
	begin
	out=in0<<2;
	overflow=0;
	zero=~(|out);
	carryout=0;
	end

	SRL:				//�߼�����(��)
	begin
	out=in0>>2;
	overflow=0;
	zero=~(|out);
	carryout=0;	
	end

	SRA:				//��������(��)
	begin
	out={{2{in0[31]}}, in0[31:2]};
	overflow=0;
	zero=~(|out);
	carryout=0;	
	end

	SLLV:				//�߼�����(��)
	begin
	out=sllv_result;
	overflow=0;
	zero=~(|out);
	carryout=0;	
	end

	SRLV:				//�߼�����(��)
	begin
	out=srlv_result;
	overflow=0;
	zero=~(|out);
	carryout=0;	
	end

	SRAV:				//��������(��)
	begin
	out=srav_result;
	overflow=0;
	zero=~(|out);
	carryout=0;	
	end

	ADD:				//�з��żӷ�
	begin
	Sub=0;
	out=add_result;
	overflow=overflow_result;
	zero=zero_result;
	carryout=0;
	end

	ADDU:				//�޷��żӷ�
	begin
	Sub=0;
	out=add_result;
	overflow=0;
	zero=zero_result;
	carryout=carryout_result;
	end

	SUB:				//�з��ż���
	begin
	Sub=1;
	out=add_result;
	overflow=overflow_result;
	zero=zero_result;
	carryout=0;
	end

	SUBU:				//�޷��ż���
	begin
	Sub=1;
	out=add_result;
	overflow=0;
	zero=zero_result;
	carryout=carryout_result;
	end

	AND:
	begin
	out=and_result;
	overflow=0;
	zero=~(|and_result);
	carryout=0;
	end

	OR:
	begin
	out=or_result;
	overflow=0;
	zero=~(|and_result);
	carryout=0;
	end

	XOR:
	begin
	out=xor_result;
	overflow=0;
	zero=~(|and_result);
	carryout=0;
	end

	NOR:
	begin
	out=nor_result;
	overflow=0;
	zero=~(|and_result);
	carryout=0;
	end

	//�з����� С����1
	SLT:
	begin
	//result�Ǽ�����������λ
	Sub=1;
	out={31'b0,add_result[31]};
	zero=~(|out);
	overflow=0;
	carryout=0;
	end

	//�޷����� С����1
	SLTU:
	begin
	//result�Ǽ�������Ľ�λ��־λ
	Sub=1;
	out={31'b0,carryout_result};
	zero=~(|out);
	overflow=0;
	carryout=0;
	end
	
	default:out=out;
	endcase
end

assign  and_result=in0&in1;
assign  or_result=in0|in1;
assign  xor_result=in0^in1;
assign  nor_result=~(or_result);

//�߼����� SLLV
always@(*)
begin
    case(in1)
    0: sllv_result <= in0;
	1: sllv_result <= in0 << 1;
	2: sllv_result <= in0 << 2;
	3: sllv_result <= in0 << 3;
	4: sllv_result <= in0 << 4;
	5: sllv_result <= in0 << 5;
	6: sllv_result <= in0 << 6;
	7: sllv_result <= in0 << 7;
	8: sllv_result <= in0 << 8;
	9: sllv_result <= in0 << 9;
	10: sllv_result <= in0 << 10;
	11: sllv_result <= in0 << 11;
	12: sllv_result <= in0 << 12;
	13: sllv_result <= in0 << 13;
	14: sllv_result <= in0 << 14;
	15: sllv_result <= in0 << 15;
	16: sllv_result <= in0 << 16;
	17: sllv_result <= in0 << 17;
	18: sllv_result <= in0 << 18;
	19: sllv_result <= in0 << 19;
	20: sllv_result <= in0 << 20;
	21: sllv_result <= in0 << 21;
	22: sllv_result <= in0 << 22;
	23: sllv_result <= in0 << 23;
	24: sllv_result <= in0 << 24;
	25: sllv_result <= in0 << 25;
	26: sllv_result <= in0 << 26;
	27: sllv_result <= in0 << 27;
	28: sllv_result <= in0 << 28;
	29: sllv_result <= in0 << 29;
	30: sllv_result <= in0 << 30;
	31: sllv_result <= in0 << 31;
	default: sllv_result <= in0;
	endcase
end

//�߼����� SRLV
always@(*)
begin
    case(in1)
    0: srlv_result <= in0;
	1: srlv_result <= in0 >> 1;
	2: srlv_result <= in0 >> 2;
	3: srlv_result <= in0 >> 3;
	4: srlv_result <= in0 >> 4;
	5: srlv_result <= in0 >> 5;
	6: srlv_result <= in0 >> 6;
	7: srlv_result <= in0 >> 7;
	8: srlv_result <= in0 >> 8;
	9: srlv_result <= in0 >> 9;
	10: srlv_result <= in0 >> 10;
	11: srlv_result <= in0 >> 11;
	12: srlv_result <= in0 >> 12;
	13: srlv_result <= in0 >> 13;
	14: srlv_result <= in0 >> 14;
	15: srlv_result <= in0 >> 15;
	16: srlv_result <= in0 >> 16;
	17: srlv_result <= in0 >> 17;
	18: srlv_result <= in0 >> 18;
	19: srlv_result <= in0 >> 19;
	20: srlv_result <= in0 >> 20;
	21: srlv_result <= in0 >> 21;
	22: srlv_result <= in0 >> 22;
	23: srlv_result <= in0 >> 23;
	24: srlv_result <= in0 >> 24;
	25: srlv_result <= in0 >> 25;
	26: srlv_result <= in0 >> 26;
	27: srlv_result <= in0 >> 27;
	28: srlv_result <= in0 >> 28;
	29: srlv_result <= in0 >> 29;
	30: srlv_result <= in0 >> 30;
	31: srlv_result <= in0 >> 31;
	default: srlv_result <= in0;
	endcase
end

//�������� SRAV
always@(*)
begin
    case(in1)
    0: srav_result <= in0;
	1: srav_result <= {{in0[31]}, in0[31:1]};
	2: srav_result <= {{2{in0[31]}}, in0[31:2]};
	3: srav_result <= {{3{in0[31]}}, in0[31:3]};
	4: srav_result <= {{4{in0[31]}}, in0[31:4]};
	5: srav_result <= {{5{in0[31]}}, in0[31:5]};
	6: srav_result <= {{6{in0[31]}}, in0[31:6]};
	7: srav_result <= {{7{in0[31]}}, in0[31:7]};
	8: srav_result <= {{8{in0[31]}}, in0[31:8]};
	9: srav_result <= {{9{in0[31]}}, in0[31:9]};
	10: srav_result <= {{10{in0[31]}}, in0[31:10]};
	11: srav_result <= {{11{in0[31]}}, in0[31:11]};
	12: srav_result <= {{12{in0[31]}}, in0[31:12]};
    13: srav_result <= {{13{in0[31]}}, in0[31:13]};
	14: srav_result <= {{14{in0[31]}}, in0[31:14]};
	15: srav_result <= {{15{in0[31]}}, in0[31:15]};
	16: srav_result <= {{16{in0[31]}}, in0[31:16]};
	17: srav_result <= {{17{in0[31]}}, in0[31:17]};
	18: srav_result <= {{18{in0[31]}}, in0[31:18]};
	19: srav_result <= {{19{in0[31]}}, in0[31:19]};
	20: srav_result <= {{20{in0[31]}}, in0[31:20]};
	21: srav_result <= {{21{in0[31]}}, in0[31:21]};
	22: srav_result <= {{22{in0[31]}}, in0[31:22]};
	23: srav_result <= {{23{in0[31]}}, in0[31:23]};
	24: srav_result <= {{24{in0[31]}}, in0[31:24]};
	25: srav_result <= {{25{in0[31]}}, in0[31:25]};
	26: srav_result <= {{26{in0[31]}}, in0[31:26]};
	27: srav_result <= {{27{in0[31]}}, in0[31:27]};
	28: srav_result <= {{28{in0[31]}}, in0[31:28]};
	29: srav_result <= {{29{in0[31]}}, in0[31:29]};
	30: srav_result <= {{30{in0[31]}}, in0[31:30]};
	31: srav_result <= {{31{in0[31]}}, in0[31]};
	default: srav_result <= in0;
    endcase
end

//�ӷ���
Adder_detectedOverflow MyAdder(
.sub(Sub),.inA(in0), .inB(in1), 
.overflow(overflow_result), .cout(carryout_result), .zero(zero_result), .add_result(add_result));

endmodule
