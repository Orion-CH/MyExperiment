`timescale 1ns / 1ps

module MUX6X32(d_and,d_or,d_xor,d_lui,d_sh,d_as,Aluc,d);
/*6·ѡ��ģ�飬����ALU�����ź�Aluc�Լ�6���������������ѡ��ָ���Ӧ�ĵļ����������*/

    input [31:0]d_and,d_or,d_xor,d_lui,d_sh,d_as;//��ͬ�����ALU������
    input [3:0]Aluc; //ALU�����ź�
    output [31:0]d; //���
    
    //����select����������Alucѡ���ӦALU�ļ����������
    function [31:0]select;
        input [31:0]d_and,d_or,d_xor,d_lui,d_sh,d_as;
        input [3:0]Aluc;
            case(Aluc)
                4'b0000:select=d_as; //addu���
                4'b0001:select=d_as; //subu���
                4'b0010:select=d_and;//and���
                4'b0011:select=d_or;//or���
                4'b0100:select=d_xor;//xor���
                4'b0110:select=d_lui;//lui���
                4'b0101:select=d_sh;//�߼����ƽ��
                4'b0111:select=d_sh;//�߼����ƽ��
                4'b1111:select=d_sh;//�������ƽ��
                4'b1101:select=d_sh;//�������ƽ��
            endcase
    endfunction
    
    //�����Լ������select���������ѡ����ALU������ d 
    assign d=select(d_and,d_or,d_xor,d_lui,d_sh,d_as,Aluc);
endmodule
