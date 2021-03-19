`timescale 1ns / 1ps


module MUX4X32(A0, A1, A2, A3, S, Y);
/*4路选择模块-PC更新选择器，功能：从指令执行后，更新的4个PC来源中，根据控制信号S(即Pcsrc)，选择对应的输入作为新地址送给PC*/

    input [31:0] A0, A1, A2, A3; //指令执行后PC的4个更新的值
    input [1:0] S;//控制信号即Pcsrc
    output [31:0] Y;//输出结果->新的PC值
    
    //定义函数，根据控制信号S做选择
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
    
    //调用select函数，输出选择结果Y
    assign Y = select (A0, A1, A2, A3, S);
endmodule
