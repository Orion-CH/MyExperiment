`timescale 1ns / 1ps

module ALU(X,Y,Aluc,R,Z);
    input[31:0]X,Y;
    input[3:0]Aluc;
    output[31:0]R;
    output Z;
    wire[31:0]d_as,d_and,d_or,d_xor,d_lui,d_sh,d;

    Adder_cout as32(Aluc[0],X,Y,d_as, Cout);  // 第一次大作业设计的并行加法器
    assign d_and=X&Y;// 与结果
    assign d_or=X|Y;// 或结果  
    assign d_xor=X^Y;// 异或结果
    //lui指令运算结果，把16位立即数放到32位运算结果的高16位，低16位补零。
    assign d_lui={Y[15:0],16'h0};
    /*
    移位运算：
    X[10:6]五位标识了移动的位数（0~31），
    ALuc[3]说明移位的类型（0逻辑 1算术），
    ALuc[1]说明左移还是右移（0左 1右）*/
    SHIFTER shift(Y,X[10:6],Aluc[3],Aluc[1],d_sh);
    //根据控制信号Aluc（标志运算种类）选择要输出的运算结果。
    MUX6X32 select(d_and,d_or,d_xor,d_lui,d_sh,d_as,Aluc[3:0],R);
    assign Z=~|R;  //  零标志位：把与运算结果R每一位相或，然后取非。
endmodule

