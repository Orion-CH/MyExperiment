`timescale 1ns / 1ps


module CONUNIT(Op,Func,Z,Regrt,Se,Wreg,Aluqa,Aluqb,Aluc,Wmem,Pcsrc,Reg2reg,Jal);
/*���Ƶ�Ԫģ�飬���ã����벢���ɿ����ź�*/
input[5:0]Op,Func;
input Z;
output Regrt,Se,Wreg,Aluqa,Aluqb,Wmem,Reg2reg,Jal;
output[1:0]Pcsrc;
output [3:0]Aluc;
wire R_type=~|Op;  // �Ƿ�ΪRָ��

/*��opΪ000000, ��ΪR��ָ��, R_type(op������λ�����~\Op)��Ϊ1, �������Ϊ0
R��: FUNC������, ͨ����R_type�Լ�Func[5:0]��ÿһλ����/����,�õ������������͵��ź�(1λ)
����Ϊ:
    add : 100000
    sub : 100010
    and : 100100
    or  : 100101
    xor : 100110
    sll : 000000
    srl : 000010
    sra : 000011
    jr  : 001000    jrΪr��ָ��
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

/*I��ָ��: OP������, ͨ����op[5:0]��ÿһλ����/����,�õ������������͵��ź�(1λ)
����Ϊ:
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

/*J��ָ��: OP������, ͨ����op[5:0]��ÿһλ����/����,�õ������������͵��ź�(1λ)
����Ϊ:
    j   : 000010
    jal : 000011
    */
wire I_j=~Op[5]&~Op[4]&~Op[3]&~Op[2]&Op[1]&~Op[0];
wire I_jal=~Op[5]&~Op[4]&~Op[3]&~Op[2]&Op[1]&Op[0];

//Wreg �� ͨ�üĴ������дʹ���ź�: ����Ҫ���Ĵ���д�ص��������͵��ź�����, ��һ��1������ÿ����ź�
assign Wreg = I_add|I_sub|I_and|I_or|I_xor|I_sll|I_srl|I_sra|I_addi|I_andi|I_ori|I_or|I_xori|I_lw|I_lui|I_jal;
//Regrt : MUX�Ŀ����ź�, ��Ϊ1��ѡ��Rt, ����ѡ��Rd
assign Regrt = ~R_type; 
//Reg2reg : MUX�Ŀ����ź�, ����д��ͨ�üĴ��������������Data memory(0)����ALU(1)
assign Reg2reg  = I_add|I_sub|I_and|I_or|I_xor|I_sll|I_srl|I_sra|I_addi|I_andi|I_ori|I_xori|I_sw|I_beq|I_bne|I_j|I_jal|I_lui;
//Aluqa: rt����λ�����ź�, ��������Ҫ��rt������λ���������͵��ź�Ϊ1��Ϊ1
assign Aluqa=I_sll | I_srl | I_sra;
//Aluqb : MUX, R��ѡRt, I��ѡimmm, j�Ͳ���Ҫ���ź�
assign Aluqb = I_add | I_sub | I_and | I_or | I_xor | I_sll | I_srl | I_sra | I_beq | I_bne|I_j;
//Se : �Ƿ���Ҫ��imm���з�����չ
assign Se   = I_addi | I_lw | I_sw | I_beq | I_bne;
//Aluc : ����aluִ�е���������
assign Aluc[3] = I_sra;
assign Aluc[2] = I_xor |I_lui | I_sll | I_srl | I_sra |I_xori;
assign Aluc[1] = I_and | I_or | I_lui | I_srl | I_sra | I_andi | I_ori;
assign Aluc[0] = I_sub | I_ori | I_or | I_sll | I_srl |I_sra| I_beq | I_bne;
//Wmem :data memory��дʹ��
assign Wmem = I_sw;
/*Pcsrc:��·ѡ�����Ŀ����ź�:
        ѡ0: ��һ��ָ��;
        ѡ1: ������ת;
        ѡ2: Jr
        ѡ3: J*/
assign Pcsrc[0] = (I_beq&Z) | (I_bne&~Z) | I_jal | I_j;
assign Pcsrc[1] = I_j | I_jr | I_jal;
//jalָ��Ŀ����ź�
assign Jal=I_jal;
endmodule