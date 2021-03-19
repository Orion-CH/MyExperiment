`timescale 1ns / 1ps

module MUX6X32(d_and,d_or,d_xor,d_lui,d_sh,d_as,Aluc,d);
/*6路选择模块，根据ALU控制信号Aluc以及6种运算的运算结果，选择指令对应的的计算结果并输出*/

    input [31:0]d_and,d_or,d_xor,d_lui,d_sh,d_as;//不同运算的ALU运算结果
    input [3:0]Aluc; //ALU控制信号
    output [31:0]d; //输出
    
    //定义select函数，根据Aluc选择对应ALU的计算结果并输出
    function [31:0]select;
        input [31:0]d_and,d_or,d_xor,d_lui,d_sh,d_as;
        input [3:0]Aluc;
            case(Aluc)
                4'b0000:select=d_as; //addu结果
                4'b0001:select=d_as; //subu结果
                4'b0010:select=d_and;//and结果
                4'b0011:select=d_or;//or结果
                4'b0100:select=d_xor;//xor结果
                4'b0110:select=d_lui;//lui结果
                4'b0101:select=d_sh;//逻辑左移结果
                4'b0111:select=d_sh;//逻辑右移结果
                4'b1111:select=d_sh;//算数左移结果
                4'b1101:select=d_sh;//算数右移结果
            endcase
    endfunction
    
    //调用自己定义的select函数，输出选择后的ALU运算结果 d 
    assign d=select(d_and,d_or,d_xor,d_lui,d_sh,d_as,Aluc);
endmodule
