`timescale 1ns / 1ps

// 32位加减法运算器
/// 本cpu只实现了addu，subu指令，用不到overflow位，故没有涉及
module Adder_cout(sub, inA, inB, add_result,cout);// overflow  ，zero
    input sub; //是否做减法
    input [31:0]inA;
    input [31:0]inB;
    output [31:0]add_result; //运算结果
    output reg cout; // 是否有进位（无符号数加法），借位（无符号减法）
    wire [31:0]inB_r; //B取反
    wire C2;  //进位结果
    wire C_r;  //进位结果取反
    reg [31:0]inB_final; //最终做运算的B
    
    assign inB_r = ~inB;
    assign C_r = ~C2;
    always@(*)
    begin
    if(sub==1)
        begin
            inB_final = inB_r;
            cout = C_r; //如果是无符号减法，那么借位通过把进位取反得到
        end
    else
        begin
            inB_final = inB;
            cout = C2;
       end
   end
   aheadAdder_32 adder(add_result, C2, inA, inB_final, sub); // 如果做减法，那么把B取反后，加上sub

endmodule

module aheadAdder_32(f32,c2,x32,y32,cin32);//32位加法器先行进位加法器
input [32:1]x32;
input [32:1]y32;
input cin32;//进位输入
output [32:1]f32;
output c2;   //进位输出
wire c1;
wire [2:1]p;
wire [2:1]g;

// 生成两个16位的加法器的进位
assign c1=g[1]|p[1]&cin32;  // C16 = G0+P0*C0
assign c2=g[2]|p[2]&g[1]|p[2]&p[1]&cin32; // C32 = G1 + P1*G0 + P1*P0*C0

aheadAdder_16 ah1(g[1],p[1],f32[16:1],x32[16:1],y32[16:1],cin32);
aheadAdder_16 ah2(g[2],p[2],f32[32:17],x32[32:17],y32[32:17],c1);

endmodule


module aheadAdder_16(gmm,pmm,f16,x16,y16,cin);//16位加法器先行进位加法器
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



module aheadAdder_4(gm,pm,f,x,y,c0);   //4位超前进位加法器
input [4:1]x;                    //四位x值
input [4:1]y;                    //四位y值
input c0;                        //上一的级进位
output [4:1]f;                  //四位加和f
output gm,pm;

wire [3:1]c;                     //超前进位
wire [4:1]p;
wire [4:1]g;
assign p=x|y;  // P，进位传递函数中的每一和项(A3+B3), (A2+B2), (A1+B1), (A0+B0)
assign g=x&y;  //G， 进位产生函数中的积项， A3B3,A2B2,A1B1,A0B0

assign pm=p[4]&p[3]&p[2]&p[1];  //生成下一个单元的G和P
assign gm=g[4]|p[4]&g[3]|p[4]&p[3]&g[2]|p[4]&p[3]&p[2]&g[1];

// 产生每一位的进位
assign c[1]=g[1]|p[1]&c0;
assign c[2]=g[2]|p[2]&g[1]|p[2]&p[1]&c0;
assign c[3]=g[3]|p[3]&g[2]|p[2]&p[3]&g[1]|p[3]&p[2]&p[1]&c0;
//得到计算结果
half_adder H1(x[1],y[1],c0,f[1]);
half_adder H2(x[2],y[2],c[1],f[2]);
half_adder H3(x[3],y[3],c[2],f[3]);
half_adder H4(x[4],y[4],c[3],f[4]);
endmodule



module half_adder(x,y,c0,f);  //半加器，因为不用向下一位进位
input x;
input y;
input c0;
output f;
assign f=(x^y)^c0;
endmodule


module parrallel_carry(c,p,g,c0);//并行进位部件，用于把4个4位超前进位加法器->16位超前进位加法器。根据G，P和C0，生成每一位的进位。
input [4:1]p;
input [4:1]g;
input c0;
output [4:1]c;
assign c[1]=g[1]|p[1]&c0;  // C4进位
assign c[2]=g[2]|p[2]&g[1]|p[2]&p[1]&c0; //C8进位
assign c[3]=g[3]|p[3]&g[2]|p[2]&p[3]&g[1]|p[3]&p[2]&p[1]&c0; // C12进位
assign c[4]=g[4]|p[4]&g[3]|p[4]&p[3]&g[2]|p[4]&p[3]&p[2]&g[1]|p[4]&p[3]&p[2]&p[1]&c0; // C16进位
endmodule
