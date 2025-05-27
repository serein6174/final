module display_digit(
    input [9:0] vga_col,      // 当前像素列地址
    input [8:0] vga_row,      // 当前像素行地址
    input [7:0] data_value,   // 输入数据0-99
    input use_red,            // 颜色选择（1=红，0=绿）
    output reg [11:0] pixel_data  // 输出像素颜色（bbbb_gggg_rrrr）
);
    //---------------- 可调参数 -----------------
    parameter DIGIT_X_TENS = 300;  // 十位X起始位置
    parameter DIGIT_X_ONES = 316;  // 个位X起始位置（间隔16像素）
    parameter DIGIT_Y      = 200;  // Y起始位置
    parameter DIGIT_WIDTH  = 12;   // 字符宽度12像素
    parameter DIGIT_HEIGHT = 16;   // 字符高度16像素

    // 拆分十位和个位
    wire [3:0] tens = data_value / 10;
    wire [3:0] ones = data_value % 10;
   
    // 判断当前像素是否在十位或个位区域
    wire in_tens = (vga_col >= DIGIT_X_TENS) && 
                  (vga_col < DIGIT_X_TENS + DIGIT_WIDTH) &&
                  (vga_row >= DIGIT_Y) && 
                  (vga_row < DIGIT_Y + DIGIT_HEIGHT);

    wire in_ones = (vga_col >= DIGIT_X_ONES) && 
                  (vga_col < DIGIT_X_ONES + DIGIT_WIDTH) &&
                  (vga_row >= DIGIT_Y) && 
                  (vga_row < DIGIT_Y + DIGIT_HEIGHT);

    // 计算ROM行地址和列偏移
    wire [3:0] row_addr = vga_row - DIGIT_Y;       // 行地址0-15
    wire [3:0] col_tens = vga_col - DIGIT_X_TENS;  // 列偏移0-11
    wire [3:0] col_ones = vga_col - DIGIT_X_ONES;  // 列偏移0-11

    // 实例化ROM
    wire [11:0] tens_pixels, ones_pixels;
    digit rom_tens(.digit(tens), .row(row_addr), .pixels(tens_pixels));
    digit rom_ones(.digit(ones), .row(row_addr), .pixels(ones_pixels));

    // 像素点亮判断
    wire pixel_tens = (col_tens < 12) ? tens_pixels[11 - col_tens] : 0; // 根据列偏移取对应位
    wire pixel_ones = (col_ones < 12) ? ones_pixels[11 - col_ones] : 0;
    wire pixel_on = (pixel_tens & in_tens) | (pixel_ones & in_ones);

    // 生成颜色
    always @(*) begin
        if (pixel_on) begin
            pixel_data = use_red ? 12'h00F : 12'h0F0; // 红或绿
        end else begin
            pixel_data = 12'h000; // 背景黑色
        end
    end

endmodule