`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/09 10:31:14
// Design Name: 
// Module Name: CPU_test
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module CPU_test();
    reg Clk,Clrn;
    wire [31:0] Inst,NEXTADDR,InstAddr;
    CPU uut(.Clk(Clk),.Clrn(Clrn),.Inst(Inst),.NEXTADDR(NEXTADDR),.InstAddr(InstAddr));
    initial begin 
        Clk=0;
        Clrn=0;
        #5
        Clrn<=1;
    end
    always #5 Clk=~Clk;
endmodule
