module top(
    input clk,          // 25MHz ʱ��
    input rst,          // ��λ�ź�
    output [3:0] R, // VGA��ɫ
    output [3:0] G, // VGA��ɫ
    output [3:0] B, // VGA��ɫ
    output HS,      // ��ͬ��
    output VS       // ��ͬ��
);
    wire [31:0] div_res;
    clkdiv c1 (clk, rst, div_res);
    // ʾ������Դ��0-99��������
    reg [7:0] data_value = 0;
    reg [7:0] d_2 = 9,d_1=14,d_3=26;
    always @(posedge clk or posedge rst) begin
        if (rst) data_value <= 0;
        else data_value <= (data_value == 99) ? 0 : data_value + 1;
    end

    // VGA�ӿ��ź�
    wire [11:0] pixel_data;
    wire [11:0] pixel_1,p_3;
    wire [11:0] pixel_2;
    wire [8:0] vga_row;
    wire [9:0] vga_col;
    wire Rdn;

    // ʵ����VGAģ��
    VGA vga_inst(
        .clk(div_res[1]),
        .rst(rst),
        .Din(pixel_data),
        .row(vga_row),
        .col(vga_col),
        .rdn(Rdn),
        .R(R),
        .G(G),
        .B(B),
        .HS(HS),
        .VS(VS)
    );

  display_digit #(
        .DIGIT_X_TENS(300), // ���Զ���Xλ��
        .DIGIT_X_ONES(312),
        .DIGIT_Y(220)
    ) d1 (
        .vga_col(vga_col),
        .vga_row(vga_row),
        .data_value(d_1),
        .use_red(1), // ��̬��ɫ�л�
        .pixel_data(pixel_1)
    );
 display_digit #(
        .DIGIT_X_TENS(200), // ���Զ���Xλ��
        .DIGIT_X_ONES(212),
        .DIGIT_Y(120)
    ) d2 (
        .vga_col(vga_col),
        .vga_row(vga_row),
        .data_value(d_2),
        .use_red(0), // ��̬��ɫ�л�
        .pixel_data(pixel_2)
    );
    display_digit #(
        .DIGIT_X_TENS(100), // ���Զ���Xλ��
        .DIGIT_X_ONES(112),
        .DIGIT_Y(320)
    ) d3 (
        .vga_col(vga_col),
        .vga_row(vga_row),
        .data_value(d_3),
        .use_red(0), // ��̬��ɫ�л�
        .pixel_data(p_3)
    );
    assign pixel_data=pixel_1 |pixel_2|p_3;
endmodule