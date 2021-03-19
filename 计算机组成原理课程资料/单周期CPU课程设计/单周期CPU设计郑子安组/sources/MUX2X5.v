`timescale 1ns / 1ps


module MUX2X5(A0,A1,S,Y);
    input [4:0]A0,A1;
    input S;
    output [4:0] Y;
    assign Y = (S==0)? A0 : A1;
endmodule
