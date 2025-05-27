module top(
    input clk,          // 25MHz 时钟
    input rst,          // 复位信号
    output [3:0] R, // VGA红色
    output [3:0] G, // VGA绿色
    output [3:0] B, // VGA蓝色
    output HS,      // 行同步
    output VS       // 场同步
);
    wire [31:0] div_res;
    clkdiv c1 (clk, rst, div_res);
    // 示例数据源（0-99计数器）
    reg [7:0] data_value = 0;
    reg [7:0] d_2 = 9,d_1=14,d_3=26;
    always @(posedge clk or posedge rst) begin
        if (rst) data_value <= 0;
        else data_value <= (data_value == 99) ? 0 : data_value + 1;
    end

    // VGA接口信号
    wire [11:0] pixel_data;
    wire [11:0] pixel_1,p_3;
    wire [11:0] pixel_2;
    wire [8:0] vga_row;
    wire [9:0] vga_col;
    wire Rdn;

    // 实例化VGA模块
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
        .DIGIT_X_TENS(300), // 可自定义X位置
        .DIGIT_X_ONES(312),
        .DIGIT_Y(220)
    ) d1 (
        .vga_col(vga_col),
        .vga_row(vga_row),
        .data_value(d_1),
        .use_red(1), // 动态颜色切换
        .pixel_data(pixel_1)
    );
 display_digit #(
        .DIGIT_X_TENS(200), // 可自定义X位置
        .DIGIT_X_ONES(212),
        .DIGIT_Y(120)
    ) d2 (
        .vga_col(vga_col),
        .vga_row(vga_row),
        .data_value(d_2),
        .use_red(0), // 动态颜色切换
        .pixel_data(pixel_2)
    );
    display_digit #(
        .DIGIT_X_TENS(100), // 可自定义X位置
        .DIGIT_X_ONES(112),
        .DIGIT_Y(320)
    ) d3 (
        .vga_col(vga_col),
        .vga_row(vga_row),
        .data_value(d_3),
        .use_red(0), // 动态颜色切换
        .pixel_data(p_3)
    );
    assign pixel_data=pixel_1 |pixel_2|p_3;
endmodule