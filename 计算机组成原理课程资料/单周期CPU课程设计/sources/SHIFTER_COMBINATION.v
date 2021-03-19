`timescale 1ns / 1ps


module SHIFTER_COMBINATION(X,PCADD4,Sh);
/*��λƴ��ģ�飬����J��ָ�ʵ��ָ���ַ��ƴ��,ShΪָ��j��ת��ĵ�ַ�����º��PC��
ʵ�ֹ���Ϊ PC<= PCADD4[31:28] ||  X[25:0] || 2'b00   (����/||'��ƴ��)*/

    input [25:0] X;
    input [31:0] PCADD4;
    output [31:0] Sh;
    
    // ��2λƴ��0
    parameter z=2'b00;
    
    // �����������ƴ��
    assign Sh={PCADD4[31:28],X[25:0],z};
endmodule
