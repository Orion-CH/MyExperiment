`timescale 1ns / 1ps

module PC(Clk,Clrn,Result,Address);  
/*���������������ʱ���źų�ʼ�������PC��ַ�����*/
    
    input Clk;//ʱ��
    input Clrn;//�Ƿ����õ�ַ��ʱ���źš�0��ʼ��PC��������µ�ַ�� 
          
  
    input wire [31:0]Result;  //�µ�ַ
    output reg [31:0]Address; //�����µ�ַ
    
   always @(posedge Clk or negedge Clrn) begin  // ����ʱ���ź��첽��λ
   
		if(Clrn) begin
		// ����PC��ַ
			Address <= Result;
		end else begin
		//  PC <= 0 ����ʼ�� PC
			Address <= 32'b0;
		end
	end
endmodule
