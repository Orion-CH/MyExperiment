`timescale 1ns / 1ps

module DATAMEM(Addr,Din,Clk,We,Dout);
/*
DATAMEM�����ݴ洢����ģ��ʹ��reg�͵Ķ�ά����ʵ�֣�����ֻ��32����������5λAddr[6:2]��Ѱַ32λ��
�����λ���õ�ԭ������Ϊ32λ��ַ�ܶ�λ���ֽڣ���32λ��2?���ֽڣ��������2λ��������λÿ���洢��Ԫ����ֽڵġ�
*/
input [31:0]Addr,Din;
input Clk,We;
output [31:0]Dout;
reg [31:0]Ram[31:0];// �ö�ά���ݣ��½�32��32λ�洢��Ԫ
assign Dout=Ram[Addr[6:2]];//����Addrѡ���������

always @(posedge Clk)begin
    if(We)Ram[Addr[6:2]]<=Din;  //��ʱ�����������٣���дʹ��Ϊ1����Din������д��Addrλ�õĵ�Ԫ
end

// ģ���ʼ��ʱ����32���洢��Ԫȫ������
integer i;
initial begin
    for(i=0;i<32;i=i+1)
        Ram[i]=0;
end            
endmodule

