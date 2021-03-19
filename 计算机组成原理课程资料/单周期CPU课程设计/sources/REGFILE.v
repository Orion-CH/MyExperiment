`timescale 1ns / 1ps



module REGFILE(Ra,Rb,D,Wr,We,Clk,Clrn,Qa,Qb,Q31,Q30,Q29,Q28,Q27,Q26,Q25,Q24,Q23,Q22,Q21,Q20,Q19,Q18,Q17,Q16,Q15,Q14,Q13,Q12,Q11,Q10,Q9,Q8,Q7,Q6,Q5,Q4,Q3,Q2,Q1,Q0);
/*�Ĵ�����ģ�飬����rs,rt,rd��ʱ���ź�дʹ�ܿ����ź�We��ʵ�ֶ�32���Ĵ����ĳ�ʼ����������д�롣*/

  //Ra��Ӧrs, Rb��Ӧrt, Wr: R��ָ���Ӧrd, I��ָ���Ӧrt����ΪҪд�������ļĴ�����š�
   input [4:0]Ra,Rb,Wr;
   
   //DΪҪд��Ĵ����������
    input [31:0]D;
    
    // WeΪ�����ź�дʹ�ܣ�Clk,ClrnΪʱ���źš�
    input We,Clk,Clrn;
    
    //Qa,QbΪ���ռĴ�����������
    //Q0~Q31Ϊ���ӱ����ֱ���32���Ĵ�����ֵ����Ϊ������ڷ������й۲�ÿ���Ĵ����ڵ����ݱ仯��
    output [31:0]Qa,Qb,Q31,Q30,Q29,Q28,Q27,Q26,Q25,Q24,Q23,Q22,Q21,Q20,Q19,Q18,Q17,Q16,Q15,Q14,Q13,Q12,Q11,Q10,Q9,Q8,Q7,Q6,Q5,Q4,Q3,Q2,Q1,Q0;
    
    //����reg�Ͷ�ά�����ʾ32���Ĵ�����
    reg [31:0] register [0:31]; 
    
    // ����ָ���и����ļĴ������Ra,Rb�������Ӧ�ļĴ����д洢�����ݣ���������Ϊ0Ĭ�����0����zero�Ĵ�����ֵ��
	assign Qa = (Ra == 0)? 0 : register[Ra]; //read
	assign Qb = (Rb == 0)? 0 : register[Rb]; //read
	
	//��ʱ����i��ѭ������
	integer i;
	
	//��ʱ���źſ����£���32���Ĵ������г�ʼ����д�롣 
	always @(posedge Clk or negedge Clrn) begin
	// ���resetʱ���ź�ClrnΪ0�����ʼ��32���Ĵ�����ȫ����0��
	//�첽��λ
		if (Clrn == 0) begin 
			for (i=0; i<32; i=i+1)
				register[i] <= 0;
	//�����reset�źţ���WrĿ��Ĵ�����ŷ�0��Weдʹ���ź�Ϊ�棬��Ҫд��Ĵ����������Dд��Ŀ��Ĵ�����
		end else begin
		if ((Wr != 0) && (We == 1)) 
			register[Wr] <= D; //write
		end
	end
    
//Ϊ���ӱ���Q0~Q31���Զ�Ӧ�Ĵ�����ֵ��
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
