`timescale 1ns / 1ps

module DATAMEM(Addr,Din,Clk,We,Dout);
/*
DATAMEM（数据存储器）模块使用reg型的二维数组实现，由于只有32个，所以用5位Addr[6:2]来寻址32位，
最后两位不用的原因是因为32位地址能定位到字节，而32位是2?个字节，所以最低2位是用来定位每个存储单元里的字节的。
*/
input [31:0]Addr,Din;
input Clk,We;
output [31:0]Dout;
reg [31:0]Ram[31:0];// 用二维数据，新建32个32位存储单元
assign Dout=Ram[Addr[6:2]];//根据Addr选择输出数据

always @(posedge Clk)begin
    if(We)Ram[Addr[6:2]]<=Din;  //当时钟上升沿来临，若写使能为1，把Din的数据写入Addr位置的单元
end

// 模块初始化时，将32个存储单元全部置零
integer i;
initial begin
    for(i=0;i<32;i=i+1)
        Ram[i]=0;
end            
endmodule

