`timescale 1ns / 1ps


module MUX4X32(A0, A1, A2, A3, S, Y);
/*4·ѡ��ģ��-PC����ѡ���������ܣ���ָ��ִ�к󣬸��µ�4��PC��Դ�У����ݿ����ź�S(��Pcsrc)��ѡ���Ӧ��������Ϊ�µ�ַ�͸�PC*/

    input [31:0] A0, A1, A2, A3; //ָ��ִ�к�PC��4�����µ�ֵ
    input [1:0] S;//�����źż�Pcsrc
    output [31:0] Y;//������->�µ�PCֵ
    
    //���庯�������ݿ����ź�S��ѡ��
    function [31:0] select;
        input [31:0] A0, A1, A2, A3;
        input [1:0] S;
            case(S)
                2'b00: select = A0;
                2'b01: select = A1;
                2'b10: select = A2;
                2'b11: select = A3;
            endcase
    endfunction
    
    //����select���������ѡ����Y
    assign Y = select (A0, A1, A2, A3, S);
endmodule
