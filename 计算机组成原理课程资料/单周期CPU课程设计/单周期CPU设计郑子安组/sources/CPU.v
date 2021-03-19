`timescale 1ns / 1ps

module CPU(Clk,Clrn,Inst,NEXTADDR,InstAddr);
    input Clk,Clrn;
    output [31:0] Inst,NEXTADDR,InstAddr;
    
    // 很多变量是为了可视化，监视指令执行过程中数据等的变化，如Q0-Q32(regfile模块)
    wire [31:0]PCadd4,EXTIMM,InstL2,EXTIMML2,X,Y,Dout,I_Addr,Qb,Qa,D,
    R,D0,Q31,Q30,Q29,Q28,Q27,Q26,Q25,Q24,Q23,Q22,Q21,Q20,Q19,Q18,Q17,
    Q16,Q15,Q14,Q13,Q12,Q11,Q10,Q9,Q8,Q7,Q6,Q5,Q4,Q3,Q2,Q1,Q0;
    //控制信号
    wire Z,Regrt,Se,Wreg,Aluqa,Aluqb,Reg2reg,Cout,Wmem,Jal;
    wire [3:0]Aluc;
    wire [1:0]Pcsrc;
    wire [4:0]Wr,Wr0;
    //对指令进行分解的相关变量
    wire [4:0]rs,rt,rd,sa;
    wire [5:0]op,func;
    wire [15:0]immediate;
    wire [25:0]address;
    //拆分指令
    assign op=Inst[31:26];
    assign func=Inst[5:0];
    assign rs=Inst[25:21];
    assign rt=Inst[20:16];
    assign rd=Inst[15:11];
    assign sa=Inst[10:6];
    assign immediate=Inst[15:0];
    assign address=Inst[25:0];
    //InstAddr为PC寄存器给出的指令地址
    PC PC_0(Clk,Clrn,NEXTADDR,InstAddr);
    //PCadd4为指令地址+4后的地址
    PCadd4 PCadd4_0(InstAddr,PCadd4);
    //指令存储器，Inst为根据指令地址输出的指令
    INSTMEM INSTMEM_0(InstAddr,Inst);
    //控制模块 CONUNIT(Op,Func,Z,Regrt,Se,Wreg,Aluqa,Aluqb,Aluc,Wmem,Pcsrc,Reg2reg,Jal)
    CONUNIT CONUNIT_0(op,func,Z,Regrt,Se,Wreg,Aluqa,Aluqb,Aluc,Wmem,Pcsrc,Reg2reg,Jal);
    //MUX2X5(A0,A1,S,Y),根据R型指令、I型指令选择Wr的输入端
    MUX2X5 MUX2X5_1(rd,rt,Regrt,Wr0);
    //根据jal指令选择31号寄存器将指令地址写入
    MUX2X5 MUX2X5_2(Wr0,31,Jal,Wr);
    //EXT16T32(X,Se,Y) 根据信号对立即数进行零扩展和符号扩展
    EXT16T32 EXT16T32_0(immediate,Se,EXTIMM);
    //用于J型指令，实现指令地址的拼接,InstL2为指令j跳转后的地址
    SHIFTER_COMBINATION SHIFTER_COMBINATION_0(address,PCadd4,InstL2);
    //对扩展后的立即数左移两位
    SHIFTER32_L2 SHIFTER32_L2_0(EXTIMM,EXTIMML2);
    //寄存器堆，这里输出了所有寄存器的值
    REGFILE REGFILE_0(rs,rt,D,Wr,Wreg,Clk,Clrn,Qa,Qb,
    Q31,Q30,Q29,Q28,Q27,Q26,Q25,Q24,Q23,Q22,Q21,Q20,Q19,Q18,Q17,Q16,
    Q15,Q14,Q13,Q12,Q11,Q10,Q9,Q8,Q7,Q6,Q5,Q4,Q3,Q2,Q1,Q0);
    //根据R型指令和I型指令对ALU的输入端XS进行选择
    MUX2X32 MUX2X32_1(EXTIMM,Qb,Aluqb,Y);
    //根据R型指令和I型指令对ALU的输入端X进行选择
    MUX2X32 MUX2X32_2(Qa,Inst,Aluqa,X);
    //逻辑单元
    ALU ALU_0(X,Y,Aluc,R,Z);
    //数据存储单元
    DATAMEM DATAMEM_0(R,Qb,Clk,Wmem,Dout); 
    //选择写入端
    MUX2X32 MUX2X32_3(Dout,R,Reg2reg,D0);
    //用于Jal指令,选择写入PCADD4的值
    MUX2X32 MUX2X32_4(D0,PCadd4,Jal,D);
    //I型指令的条件分支指令跳转地址
    Adder_cout add(0, PCadd4,EXTIMML2,I_Addr,Cout);
    //对下一个周期的指令地址进行选择
    MUX4X32 MUX4X32_0(PCadd4,I_Addr,Qa,InstL2,Pcsrc,NEXTADDR);
endmodule