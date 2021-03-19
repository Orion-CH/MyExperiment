`timescale 1ns / 1ps


module SHIFTER_COMBINATION(X,PCADD4,Sh);
/*移位拼接模块，用于J型指令，实现指令地址的拼接,Sh为指令j跳转后的地址即更新后的PC，
实现功能为 PC<= PCADD4[31:28] ||  X[25:0] || 2'b00   (符号/||'表拼接)*/

    input [25:0] X;
    input [31:0] PCADD4;
    output [31:0] Sh;
    
    // 低2位拼接0
    parameter z=2'b00;
    
    // 根据输入进行拼接
    assign Sh={PCADD4[31:28],X[25:0],z};
endmodule
