module display_digit(
    input [9:0] vga_col,      // ��ǰ�����е�ַ
    input [8:0] vga_row,      // ��ǰ�����е�ַ
    input [7:0] data_value,   // ��������0-99
    input use_red,            // ��ɫѡ��1=�죬0=�̣�
    output reg [11:0] pixel_data  // ���������ɫ��bbbb_gggg_rrrr��
);
    //---------------- �ɵ����� -----------------
    parameter DIGIT_X_TENS = 300;  // ʮλX��ʼλ��
    parameter DIGIT_X_ONES = 316;  // ��λX��ʼλ�ã����16���أ�
    parameter DIGIT_Y      = 200;  // Y��ʼλ��
    parameter DIGIT_WIDTH  = 12;   // �ַ����12����
    parameter DIGIT_HEIGHT = 16;   // �ַ��߶�16����

    // ���ʮλ�͸�λ
    wire [3:0] tens = data_value / 10;
    wire [3:0] ones = data_value % 10;
   
    // �жϵ�ǰ�����Ƿ���ʮλ���λ����
    wire in_tens = (vga_col >= DIGIT_X_TENS) && 
                  (vga_col < DIGIT_X_TENS + DIGIT_WIDTH) &&
                  (vga_row >= DIGIT_Y) && 
                  (vga_row < DIGIT_Y + DIGIT_HEIGHT);

    wire in_ones = (vga_col >= DIGIT_X_ONES) && 
                  (vga_col < DIGIT_X_ONES + DIGIT_WIDTH) &&
                  (vga_row >= DIGIT_Y) && 
                  (vga_row < DIGIT_Y + DIGIT_HEIGHT);

    // ����ROM�е�ַ����ƫ��
    wire [3:0] row_addr = vga_row - DIGIT_Y;       // �е�ַ0-15
    wire [3:0] col_tens = vga_col - DIGIT_X_TENS;  // ��ƫ��0-11
    wire [3:0] col_ones = vga_col - DIGIT_X_ONES;  // ��ƫ��0-11

    // ʵ����ROM
    wire [11:0] tens_pixels, ones_pixels;
    digit rom_tens(.digit(tens), .row(row_addr), .pixels(tens_pixels));
    digit rom_ones(.digit(ones), .row(row_addr), .pixels(ones_pixels));

    // ���ص����ж�
    wire pixel_tens = (col_tens < 12) ? tens_pixels[11 - col_tens] : 0; // ������ƫ��ȡ��Ӧλ
    wire pixel_ones = (col_ones < 12) ? ones_pixels[11 - col_ones] : 0;
    wire pixel_on = (pixel_tens & in_tens) | (pixel_ones & in_ones);

    // ������ɫ
    always @(*) begin
        if (pixel_on) begin
            pixel_data = use_red ? 12'h00F : 12'h0F0; // �����
        end else begin
            pixel_data = 12'h000; // ������ɫ
        end
    end

endmodule