`timescale 1ns / 1ps


module EXT16T32(X,Se,Y);
/*��������չģ�飬���ݿ����ź�Seѡ����0��չ���߷�����չ*/

    input [15:0]X;//������
    input Se;//�����ź�
    output [31:0]Y;//���->��չ���������
    wire [31:0]E0,E1;
    wire [15:0]e={16{X[15]}};
    parameter z=16'b0;
    assign E0={z,X};  // 0��չ
    assign E1={e,X};  // ������չ
    MUX2X32 i(E0,E1,Se,Y);   // Y : Se=0 -> E0, Se=1 -> E1
endmodule
