`timescale 1ns / 1ps

    module SHIFTER32_L2(X,Sh);
/*����2λģ��, ʵ�ֶ���������X���̶�����2λ������4�����㣬
���ڶ���չ���������������λ*/

 input [31:0]X;
 output [31:0]Sh;
 
// ���ÿ�������λ��SHIFTERģ�飬ʹ��ֻ����2λ , ShΪ��λ�����
 SHIFTER SHIFTER_0(X,2,0,0,Sh);  
endmodule