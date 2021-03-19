`timescale 1ns / 1ps

    module SHIFTER32_L2(X,Sh);
/*左移2位模块, 实现对输入数据X做固定左移2位（即乘4）运算，
用于对扩展后的立即数左移两位*/

 input [31:0]X;
 output [31:0]Sh;
 
// 调用可任意移位的SHIFTER模块，使其只左移2位 , Sh为移位结果。
 SHIFTER SHIFTER_0(X,2,0,0,Sh);  
endmodule