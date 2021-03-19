`timescale 1ns / 1ps


module EXT16T32(X,Se,Y);
/*立即数扩展模块，根据控制信号Se选择做0扩展或者符号扩展*/

    input [15:0]X;//立即数
    input Se;//控制信号
    output [31:0]Y;//输出->扩展后的立即数
    wire [31:0]E0,E1;
    wire [15:0]e={16{X[15]}};
    parameter z=16'b0;
    assign E0={z,X};  // 0扩展
    assign E1={e,X};  // 符号扩展
    MUX2X32 i(E0,E1,Se,Y);   // Y : Se=0 -> E0, Se=1 -> E1
endmodule
