`timescale 1ns / 1ps

module INSTMEM(Addr,Inst);
/*
INSTMEM（指令存储器）模块使用reg型的二维数组实现这里我们假设只存储32条指令，由于只有32个，所以用5位Addr[6:2]来寻址32位，
最后两位不用的原因是因为32位地址能定位到字节，而32位是2?个字节，所以最低2位是用来定位每个存储单元里的字节的。
*/
    input[31:0]Addr;
    output[31:0]Inst;
    wire[31:0]Rom[31:0];
    //命令 ->预计结果 二进制机器码
	//addi $1,$2,16 ->$1=$2+16=16  001000 00010 00001 0000000000010000
	assign Rom[5'h0]=32'h20410010;
	//andi $2,$1,16 ->$2=$1&&16=16  001100 00001 00010 0000000000010000  
	assign Rom[5'h1]=32'h30220010;
	//ori $3,$1,16 ->$3=$1||16=16  001101 00001 00011 0000000000010000 
	assign Rom[5'h2]=32'h34230010;
	//xori $4,$3,16 ->$4=0 		   001110 00011 00100 0000000000010000 
	assign Rom[5'h3]=32'h38640010;
	//sw $2,4($5) ->mem[$5+4]=$2=16 101011 00101 00010 0000000000000100
	assign Rom[5'h4]=32'haca20004;
	//lw $4,4($5) ->$4=mem[$5+4]=16 100011 00101 00100 0000000000000100
	assign Rom[5'h5]=32'h8ca40004;
	//addu $5,$4,$6  ->$5=$4+$6=16 000000 00100 00110 00101 00000 100001
	assign Rom[5'h6]=32'h862821;
	//subu $6,$5,$7  ->$6=$5-$7=16 000000 00101 00111 00110 00000 100011 
	assign Rom[5'h7]=32'ha73023;
	//and $7,$5,$6 ->$7=$5&$6=16 000000 00101 00110 00111 00000 100100 
	assign Rom[5'h8]=32'ha63824;
	//or $8,$7,$9  ->$8=&7||&9=16 000000 00111 01001 01000 00000 100101
	assign Rom[5'h9]=32'he94025;
	//xor $9,$8,$7 ->$9=$8xor$7=0   000000 01000 00111 01001 00000 100110 
	assign Rom[5'ha]=32'h1074826;
	//sll $10,$1,2 ->$10=$1<<2=64 000000 00000 00001 01010 00010 000000 
	assign Rom[5'hb]=32'h15080;
	//srl $11,$10,2 ->$11=$10>>2=16 000000 00000 01010 01011 00010 000010 
	assign Rom[5'hc]=32'ha5882;
	//sra $12,$10,2 ->$12=$10>>2=16 000000 00000 01010 01100 00010 000011 
	assign Rom[5'hd]=32'ha6083;
	//lui $13,0xfb2b ->$13=0xfb2b0000 001111 00000 01101 1111101100101011
	assign Rom[5'he]=32'h3c0dfb2b;
	//jal 19 ->go jr($31=&j) 000011 00000 00000 0000000000010011
	assign Rom[5'hf]=32'hc000013;
	//j 20 -> go beq 000010 00000000000000000000010100
	assign Rom[5'h10]=32'h8000014;
	assign Rom[5'h11]=32'hXXXXXXXX;
	assign Rom[5'h12]=32'hXXXXXXXX;
	//jr go j 000000 11111 00000 00000 00000 001000   
	assign Rom[5'h13]=32'h3e00008;
	//beq $3,$4,4 ->go bne 000100 00011 00100 0000000000000100  
	assign Rom[5'h14]=32'h10640004;
	assign Rom[5'h15]=32'hXXXXXXXX;
	assign Rom[5'h16]=32'hXXXXXXXX;
	assign Rom[5'h17]=32'hXXXXXXXX;
	assign Rom[5'h18]=32'hXXXXXXXX;
	//bne $1,$10,5 ->go love 000101 00001 01010 0000000000000101
	assign Rom[5'h19]=32'h142a0005;
	assign Rom[5'h1a]=32'hXXXXXXXX;
	assign Rom[5'h1b]=32'hXXXXXXXX;
	assign Rom[5'h1c]=32'hXXXXXXXX;
	assign Rom[5'h1d]=32'hXXXXXXXX;
	assign Rom[5'h1e]=32'hXXXXXXXX;
	//love~ 
	assign Rom[5'h1f]=32'h1314520;
    assign Inst=Rom[Addr[6:2]];
    
endmodule