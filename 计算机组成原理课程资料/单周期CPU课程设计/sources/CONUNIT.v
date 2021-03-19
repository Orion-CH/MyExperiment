`timescale 1ns / 1ps


module CONUNIT(Op,Func,Z,Regrt,Se,Wreg,Aluqa,Aluqb,Aluc,Wmem,Pcsrc,Reg2reg,Jal);
/*控制单元模块，作用：译码并生成控制信号*/
input[5:0]Op,Func;
input Z;
output Regrt,Se,Wreg,Aluqa,Aluqb,Wmem,Reg2reg,Jal;
output[1:0]Pcsrc;
output [3:0]Aluc;
wire R_type=~|Op;  // 是否为R指令

/*若op为000000, 即为R型指令, R_type(op的所有位作或非~\Op)才为1, 其它情况为0
R型: FUNC的译码, 通过对R_type以及Func[5:0]的每一位作与/非与,得到所作运算类型的信号(1位)
具体为:
    add : 100000
    sub : 100010
    and : 100100
    or  : 100101
    xor : 100110
    sll : 000000
    srl : 000010
    sra : 000011
    jr  : 001000    jr为r型指令
    */
wire I_add=R_type&Func[5]&~Func[4]&~Func[3]&~Func[2]&~Func[1]&Func[0];
wire I_sub=R_type&Func[5]&~Func[4]&~Func[3]&~Func[2]&Func[1]&Func[0];
wire I_and=R_type&Func[5]&~Func[4]&~Func[3]&Func[2]&~Func[1]&~Func[0];
wire I_or=R_type&Func[5]&~Func[4]&~Func[3]&Func[2]&~Func[1]&Func[0];
wire I_xor=R_type&Func[5]&~Func[4]&~Func[3]&Func[2]&Func[1]&~Func[0];
wire I_sll=R_type&~Func[5]&~Func[4]&~Func[3]&~Func[2]&~Func[1]&~Func[0];
wire I_srl=R_type&~Func[5]&~Func[4]&~Func[3]&~Func[2]&Func[1]&~Func[0];
wire I_sra=R_type&~Func[5]&~Func[4]&~Func[3]&~Func[2]&Func[1]&Func[0];
wire I_jr=R_type&~Func[5]&~Func[4]&Func[3]&~Func[2]&~Func[1]&~Func[0];

/*I型指令: OP的译码, 通过对op[5:0]的每一位作与/非与,得到所作运算类型的信号(1位)
具体为:
    addi  : 001000
    andi  : 001100
    ori   : 001101
    xori  : 001110
    lw    : 100011
    sw    : 101011
    beq   : 000100
    bne   : 000101
    lui   : 001111
  */  
wire I_addi=~Op[5]&~Op[4]&Op[3]&~Op[2]&~Op[1]&~Op[0];
wire I_andi=~Op[5]&~Op[4]&Op[3]&Op[2]&~Op[1]&~Op[0];
wire I_ori=~Op[5]&~Op[4]&Op[3]&Op[2]&~Op[1]&Op[0];
wire I_xori=~Op[5]&~Op[4]&Op[3]&Op[2]&Op[1]&~Op[0];
wire I_lw=Op[5]&~Op[4]&~Op[3]&~Op[2]&Op[1]&Op[0];
wire I_sw=Op[5]&~Op[4]&Op[3]&~Op[2]&Op[1]&Op[0];
wire I_beq=~Op[5]&~Op[4]&~Op[3]&Op[2]&~Op[1]&~Op[0];
wire I_bne=~Op[5]&~Op[4]&~Op[3]&Op[2]&~Op[1]&Op[0];
wire I_lui=~Op[5]&~Op[4]&Op[3]&Op[2]&Op[1]&Op[0];

/*J型指令: OP的译码, 通过对op[5:0]的每一位作与/非与,得到所作运算类型的信号(1位)
具体为:
    j   : 000010
    jal : 000011
    */
wire I_j=~Op[5]&~Op[4]&~Op[3]&~Op[2]&Op[1]&~Op[0];
wire I_jal=~Op[5]&~Op[4]&~Op[3]&~Op[2]&Op[1]&Op[0];

//Wreg ： 通用寄存器组的写使能信号: 对需要往寄存器写回的运算类型的信号做或, 有一个1即激活该控制信号
assign Wreg = I_add|I_sub|I_and|I_or|I_xor|I_sll|I_srl|I_sra|I_addi|I_andi|I_ori|I_or|I_xori|I_lw|I_lui|I_jal;
//Regrt : MUX的控制信号, 若为1则选择Rt, 否则选择Rd
assign Regrt = ~R_type; 
//Reg2reg : MUX的控制信号, 控制写回通用寄存器组的数据来自Data memory(0)还是ALU(1)
assign Reg2reg  = I_add|I_sub|I_and|I_or|I_xor|I_sll|I_srl|I_sra|I_addi|I_andi|I_ori|I_xori|I_sw|I_beq|I_bne|I_j|I_jal|I_lui;
//Aluqa: rt的移位控制信号, 若遇到需要对rt进行移位的运算类型的信号为1则为1
assign Aluqa=I_sll | I_srl | I_sra;
//Aluqb : MUX, R型选Rt, I型选immm, j型不需要此信号
assign Aluqb = I_add | I_sub | I_and | I_or | I_xor | I_sll | I_srl | I_sra | I_beq | I_bne|I_j;
//Se : 是否需要对imm进行符号扩展
assign Se   = I_addi | I_lw | I_sw | I_beq | I_bne;
//Aluc : 控制alu执行的运算种类
assign Aluc[3] = I_sra;
assign Aluc[2] = I_xor |I_lui | I_sll | I_srl | I_sra |I_xori;
assign Aluc[1] = I_and | I_or | I_lui | I_srl | I_sra | I_andi | I_ori;
assign Aluc[0] = I_sub | I_ori | I_or | I_sll | I_srl |I_sra| I_beq | I_bne;
//Wmem :data memory的写使能
assign Wmem = I_sw;
/*Pcsrc:四路选择器的控制信号:
        选0: 下一条指令;
        选1: 条件跳转;
        选2: Jr
        选3: J*/
assign Pcsrc[0] = (I_beq&Z) | (I_bne&~Z) | I_jal | I_j;
assign Pcsrc[1] = I_j | I_jr | I_jal;
//jal指令的控制信号
assign Jal=I_jal;
endmodule