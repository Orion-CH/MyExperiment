`timescale 1ns / 1ps


module PCadd4(PC_0,PCadd4);
/*PC�̶���4ģ�飬��ʵ��PC = PC + 4*/

   
input [31:0] PC_0; // ԭָ���ַ
output [31:0] PCadd4;//��ָ���ַ

//���PC+4֮��ĵ�ַ��PCadd4Ϊ��������
Adder_cout adder(0,PC_0,4,PCadd4, Cout);
endmodule
