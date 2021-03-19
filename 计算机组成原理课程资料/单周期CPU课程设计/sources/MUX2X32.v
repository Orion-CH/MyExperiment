`timescale 1ns / 1ps



module MUX2X32(A0,A1,S,Y);
    input [31:0]A0,A1;
    input S;
    output [31:0]Y;
    assign Y = (S == 0)? A0 : A1;
endmodule
