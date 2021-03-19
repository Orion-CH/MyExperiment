`timescale 1ns / 1ps

module PC(Clk,Clrn,Result,Address);  
/*程序计数器，根据时钟信号初始化或更新PC地址并输出*/
    
    input Clk;//时钟
    input Clrn;//是否重置地址的时钟信号。0初始化PC，否则更新地址。 
          
  
    input wire [31:0]Result;  //新地址
    output reg [31:0]Address; //待更新地址
    
   always @(posedge Clk or negedge Clrn) begin  // 根据时钟信号异步复位
   
		if(Clrn) begin
		// 更新PC地址
			Address <= Result;
		end else begin
		//  PC <= 0 即初始化 PC
			Address <= 32'b0;
		end
	end
endmodule
