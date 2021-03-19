`timescale 1ns / 1ps


module PCadd4(PC_0,PCadd4);
/*PC固定加4模块，即实现PC = PC + 4*/

   
input [31:0] PC_0; // 原指令地址
output [31:0] PCadd4;//新指令地址

//输出PC+4之后的地址：PCadd4为输出结果。
Adder_cout adder(0,PC_0,4,PCadd4, Cout);
endmodule
