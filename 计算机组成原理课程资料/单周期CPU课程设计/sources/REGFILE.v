`timescale 1ns / 1ps



module REGFILE(Ra,Rb,D,Wr,We,Clk,Clrn,Qa,Qb,Q31,Q30,Q29,Q28,Q27,Q26,Q25,Q24,Q23,Q22,Q21,Q20,Q19,Q18,Q17,Q16,Q15,Q14,Q13,Q12,Q11,Q10,Q9,Q8,Q7,Q6,Q5,Q4,Q3,Q2,Q1,Q0);
/*寄存器组模块，根据rs,rt,rd及时钟信号写使能控制信号We，实现对32个寄存器的初始化、读出和写入。*/

  //Ra对应rs, Rb对应rt, Wr: R型指令对应rd, I型指令对应rt。都为要写入或读出的寄存器编号。
   input [4:0]Ra,Rb,Wr;
   
   //D为要写入寄存器组的数据
    input [31:0]D;
    
    // We为控制信号写使能，Clk,Clrn为时钟信号。
    input We,Clk,Clrn;
    
    //Qa,Qb为最终寄存器组的输出。
    //Q0~Q31为监视变量分别赋以32个寄存器的值，作为输出以在仿真结果中观察每个寄存器内的数据变化。
    output [31:0]Qa,Qb,Q31,Q30,Q29,Q28,Q27,Q26,Q25,Q24,Q23,Q22,Q21,Q20,Q19,Q18,Q17,Q16,Q15,Q14,Q13,Q12,Q11,Q10,Q9,Q8,Q7,Q6,Q5,Q4,Q3,Q2,Q1,Q0;
    
    //定义reg型二维数组表示32个寄存器。
    reg [31:0] register [0:31]; 
    
    // 根据指令中给出的寄存器编号Ra,Rb，输出对应的寄存器中存储的数据，如给出编号为0默认输出0，即zero寄存器的值。
	assign Qa = (Ra == 0)? 0 : register[Ra]; //read
	assign Qb = (Rb == 0)? 0 : register[Rb]; //read
	
	//临时变量i，循环变量
	integer i;
	
	//在时钟信号控制下，对32个寄存器进行初始化或写入。 
	always @(posedge Clk or negedge Clrn) begin
	// 如果reset时钟信号Clrn为0，则初始化32个寄存器，全部赋0。
	//异步复位
		if (Clrn == 0) begin 
			for (i=0; i<32; i=i+1)
				register[i] <= 0;
	//如果非reset信号，且Wr目标寄存器编号非0、We写使能信号为真，则将要写入寄存器组的数据D写入目标寄存器。
		end else begin
		if ((Wr != 0) && (We == 1)) 
			register[Wr] <= D; //write
		end
	end
    
//为监视变量Q0~Q31赋以对应寄存器的值。
    assign Q0 = register[0];
    assign Q1 = register[1];
    assign Q2 = register[2];
    assign Q3 = register[3];
    assign Q4 = register[4];
    assign Q5 = register[5];
    assign Q6 = register[6];
    assign Q7 = register[7];
    assign Q8 = register[8];
    assign Q9 = register[9];
    assign Q10 = register[10];
    assign Q11 = register[11];
    assign Q12 = register[12];
    assign Q13 = register[13];
    assign Q14 = register[14];
    assign Q15 = register[15];
    assign Q16 = register[16];
    assign Q17 = register[17];
    assign Q18 = register[18];
    assign Q19 = register[19];
    assign Q20 = register[20];
    assign Q21 = register[21];
    assign Q22 = register[22];
    assign Q23 = register[23];
    assign Q24 = register[24];
    assign Q25 = register[25];
    assign Q26 = register[26];
    assign Q27 = register[27];
    assign Q28 = register[28];
    assign Q29 = register[29];
    assign Q30 = register[30];
    assign Q31 = register[31];
    
endmodule
