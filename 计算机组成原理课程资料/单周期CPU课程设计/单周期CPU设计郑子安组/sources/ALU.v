`timescale 1ns / 1ps

module ALU(X,Y,Aluc,R,Z);
    input[31:0]X,Y;
    input[3:0]Aluc;
    output[31:0]R;
    output Z;
    wire[31:0]d_as,d_and,d_or,d_xor,d_lui,d_sh,d;

    Adder_cout as32(Aluc[0],X,Y,d_as, Cout);  // ��һ�δ���ҵ��ƵĲ��мӷ���
    assign d_and=X&Y;// ����
    assign d_or=X|Y;// ����  
    assign d_xor=X^Y;// �����
    //luiָ������������16λ�������ŵ�32λ�������ĸ�16λ����16λ���㡣
    assign d_lui={Y[15:0],16'h0};
    /*
    ��λ���㣺
    X[10:6]��λ��ʶ���ƶ���λ����0~31����
    ALuc[3]˵����λ�����ͣ�0�߼� 1��������
    ALuc[1]˵�����ƻ������ƣ�0�� 1�ң�*/
    SHIFTER shift(Y,X[10:6],Aluc[3],Aluc[1],d_sh);
    //���ݿ����ź�Aluc����־�������ࣩѡ��Ҫ�������������
    MUX6X32 select(d_and,d_or,d_xor,d_lui,d_sh,d_as,Aluc[3:0],R);
    assign Z=~|R;  //  ���־λ������������Rÿһλ���Ȼ��ȡ�ǡ�
endmodule

