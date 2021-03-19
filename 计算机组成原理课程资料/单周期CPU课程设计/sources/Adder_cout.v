`timescale 1ns / 1ps

// 32λ�Ӽ���������
/// ��cpuֻʵ����addu��subuָ��ò���overflowλ����û���漰
module Adder_cout(sub, inA, inB, add_result,cout);// overflow  ��zero
    input sub; //�Ƿ�������
    input [31:0]inA;
    input [31:0]inB;
    output [31:0]add_result; //������
    output reg cout; // �Ƿ��н�λ���޷������ӷ�������λ���޷��ż�����
    wire [31:0]inB_r; //Bȡ��
    wire C2;  //��λ���
    wire C_r;  //��λ���ȡ��
    reg [31:0]inB_final; //�����������B
    
    assign inB_r = ~inB;
    assign C_r = ~C2;
    always@(*)
    begin
    if(sub==1)
        begin
            inB_final = inB_r;
            cout = C_r; //������޷��ż�������ô��λͨ���ѽ�λȡ���õ�
        end
    else
        begin
            inB_final = inB;
            cout = C2;
       end
   end
   aheadAdder_32 adder(add_result, C2, inA, inB_final, sub); // �������������ô��Bȡ���󣬼���sub

endmodule

module aheadAdder_32(f32,c2,x32,y32,cin32);//32λ�ӷ������н�λ�ӷ���
input [32:1]x32;
input [32:1]y32;
input cin32;//��λ����
output [32:1]f32;
output c2;   //��λ���
wire c1;
wire [2:1]p;
wire [2:1]g;

// ��������16λ�ļӷ����Ľ�λ
assign c1=g[1]|p[1]&cin32;  // C16 = G0+P0*C0
assign c2=g[2]|p[2]&g[1]|p[2]&p[1]&cin32; // C32 = G1 + P1*G0 + P1*P0*C0

aheadAdder_16 ah1(g[1],p[1],f32[16:1],x32[16:1],y32[16:1],cin32);
aheadAdder_16 ah2(g[2],p[2],f32[32:17],x32[32:17],y32[32:17],c1);

endmodule


module aheadAdder_16(gmm,pmm,f16,x16,y16,cin);//16λ�ӷ������н�λ�ӷ���
input [16:1]x16;
input [16:1]y16;
input cin;
output [16:1]f16;
output gmm,pmm;
wire [4:1]c;
wire [4:1]p;
wire [4:1]g;

aheadAdder_4 ah_1(g[1],p[1],f16[4:1],x16[4:1],y16[4:1],cin);
aheadAdder_4 ah_2(g[2],p[2],f16[8:5],x16[8:5],y16[8:5],c[1]);
aheadAdder_4 ah_3(g[3],p[3],f16[12:9],x16[12:9],y16[12:9],c[2]);
aheadAdder_4 ah_4(g[4],p[4],f16[16:13],x16[16:13],y16[16:13],c[3]);

parrallel_carry cl4(c,p,g,cin);

assign pmm=p[4]&p[3]&p[2]&p[1];
assign gmm=g[4]|p[4]&g[3]|p[4]&p[3]&g[2]|p[4]&p[3]&p[2]&g[1];
endmodule



module aheadAdder_4(gm,pm,f,x,y,c0);   //4λ��ǰ��λ�ӷ���
input [4:1]x;                    //��λxֵ
input [4:1]y;                    //��λyֵ
input c0;                        //��һ�ļ���λ
output [4:1]f;                  //��λ�Ӻ�f
output gm,pm;

wire [3:1]c;                     //��ǰ��λ
wire [4:1]p;
wire [4:1]g;
assign p=x|y;  // P����λ���ݺ����е�ÿһ����(A3+B3), (A2+B2), (A1+B1), (A0+B0)
assign g=x&y;  //G�� ��λ���������еĻ�� A3B3,A2B2,A1B1,A0B0

assign pm=p[4]&p[3]&p[2]&p[1];  //������һ����Ԫ��G��P
assign gm=g[4]|p[4]&g[3]|p[4]&p[3]&g[2]|p[4]&p[3]&p[2]&g[1];

// ����ÿһλ�Ľ�λ
assign c[1]=g[1]|p[1]&c0;
assign c[2]=g[2]|p[2]&g[1]|p[2]&p[1]&c0;
assign c[3]=g[3]|p[3]&g[2]|p[2]&p[3]&g[1]|p[3]&p[2]&p[1]&c0;
//�õ�������
half_adder H1(x[1],y[1],c0,f[1]);
half_adder H2(x[2],y[2],c[1],f[2]);
half_adder H3(x[3],y[3],c[2],f[3]);
half_adder H4(x[4],y[4],c[3],f[4]);
endmodule



module half_adder(x,y,c0,f);  //���������Ϊ��������һλ��λ
input x;
input y;
input c0;
output f;
assign f=(x^y)^c0;
endmodule


module parrallel_carry(c,p,g,c0);//���н�λ���������ڰ�4��4λ��ǰ��λ�ӷ���->16λ��ǰ��λ�ӷ���������G��P��C0������ÿһλ�Ľ�λ��
input [4:1]p;
input [4:1]g;
input c0;
output [4:1]c;
assign c[1]=g[1]|p[1]&c0;  // C4��λ
assign c[2]=g[2]|p[2]&g[1]|p[2]&p[1]&c0; //C8��λ
assign c[3]=g[3]|p[3]&g[2]|p[2]&p[3]&g[1]|p[3]&p[2]&p[1]&c0; // C12��λ
assign c[4]=g[4]|p[4]&g[3]|p[4]&p[3]&g[2]|p[4]&p[3]&p[2]&g[1]|p[4]&p[3]&p[2]&p[1]&c0; // C16��λ
endmodule
