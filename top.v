module top(
    input clk,          // 25MHz 时钟
    input rst,          // 复位信号
    input wire[7:0] sw,
    output [3:0] R, // VGA红色
    output [3:0] G, // VGA绿色
    output [3:0] B, // VGA蓝色
    output HS,      // 行同步
    output VS       // 场同步
);
    wire light1;
    wire light2;
    wire light3;
    wire light4;
    wire [7:0] cnt1; 
    wire [7:0] cnt2;
    wire [7:0] cnt3; 
    wire [7:0] cnt4;
    wire [7:0] cnt5; 
    wire [7:0] cnt6;
    wire [7:0] cnt7; 
    wire [7:0] cnt8;
    wire [7:0] cnt9; 
    wire [7:0] cnt10;
    wire [7:0] cnt11; 
    wire [7:0] cnt12;
    wire [7:0] cnt13; 
    wire [7:0] cnt14;
    wire [7:0] cnt15; 
    wire [7:0] cnt16;
    wire [7:0] cnt17; 
    wire [7:0] cnt18;
    wire [7:0] cnt19; 
    wire [7:0] cnt20;
    wire [7:0] cnt21; 
    wire [7:0] cnt22;
    wire [7:0] cnt23; 
    wire [7:0] cnt24;
    carcnt cc(    clk,         
    (!rst),        
    sw,
    light1,
    light2,
    light3,
    light4,
    cnt1, 
    cnt2,
    cnt3, 
    cnt4,
    cnt5, 
    cnt6,
    cnt7, 
    cnt8,
    cnt9, 
    cnt10,
    cnt11, 
    cnt12,
    cnt13, 
    cnt14,
    cnt15, 
    cnt16,
    cnt17, 
    cnt18,
    cnt19, 
    cnt20,
    cnt21, 
    cnt22,
    cnt23, 
    cnt24);
    traffic(clk,rst,cnt5,cnt4,cnt12,cnt1,light1);
    wire [31:0] div_res;
    clkdiv c1 (clk, rst, div_res);
    wire [11:0] pixel_data;
    wire [11:0] p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16,p17,p18,p19,p20,p21,p22,p23,p24;
    wire [8:0] vga_row;
    wire [9:0] vga_col;
    wire Rdn;
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
        .DIGIT_X_TENS(130), 
        .DIGIT_X_ONES(142),
        .DIGIT_Y(70)
    ) d1 (
        .vga_col(vga_col),
        .vga_row(vga_row),
        .data_value(cnt1),
        .pixel_data(p1)
    );
 display_digit #(
        .DIGIT_X_TENS(158), 
        .DIGIT_X_ONES(170),
        .DIGIT_Y(70)
    ) d2 (
        .vga_col(vga_col),
        .vga_row(vga_row),
        .data_value(cnt2),
        .pixel_data(p2)
    );
    display_digit #(
        .DIGIT_X_TENS(80), // 可自定义X位置
        .DIGIT_X_ONES(92),
        .DIGIT_Y(120)
    ) d3 (
        .vga_col(vga_col),
        .vga_row(vga_row),
        .data_value(cnt3),
        .pixel_data(p3)
    );
     display_digit #(
        .DIGIT_X_TENS(80), // 可自定义X位置
        .DIGIT_X_ONES(92),
        .DIGIT_Y(140)
    ) d4 (
        .vga_col(vga_col),
        .vga_row(vga_row),
        .data_value(cnt4),
        .pixel_data(p4)
    );
    display_digit #(
        .DIGIT_X_TENS(270), // 可自定义X位置
        .DIGIT_X_ONES(282),
        .DIGIT_Y(120)
    ) d5 (
        .vga_col(vga_col),
        .vga_row(vga_row),
        .data_value(cnt5),
        .pixel_data(p5)
    );
     display_digit #(
        .DIGIT_X_TENS(270), // 可自定义X位置
        .DIGIT_X_ONES(282),
        .DIGIT_Y(140)
    ) d6 (
        .vga_col(vga_col),
        .vga_row(vga_row),
        .data_value(cnt6),
        .pixel_data(p6)
    );
    display_digit #(
        .DIGIT_X_TENS(382), 
        .DIGIT_X_ONES(394),
        .DIGIT_Y(70)
    ) d7 (
        .vga_col(vga_col),
        .vga_row(vga_row),
        .data_value(cnt7),
        .pixel_data(p7)
    );
    display_digit #(
        .DIGIT_X_TENS(410), 
        .DIGIT_X_ONES(422),
        .DIGIT_Y(70)
    ) d8 (
        .vga_col(vga_col),
        .vga_row(vga_row),
        .data_value(cnt8),
        .pixel_data(p8)
    );
    display_digit #(
        .DIGIT_X_TENS(460), // 可自定义X位置
        .DIGIT_X_ONES(472),
        .DIGIT_Y(120)
    ) d9 (
        .vga_col(vga_col),
        .vga_row(vga_row),
        .data_value(cnt9),
        .pixel_data(p9)
    );
     display_digit #(
        .DIGIT_X_TENS(460), // 可自定义X位置
        .DIGIT_X_ONES(472),
        .DIGIT_Y(140)
    ) d10 (
        .vga_col(vga_col),
        .vga_row(vga_row),
        .data_value(cnt10),
        .pixel_data(p10)
    );
    //--- to be continue---
    display_digit #(
        .DIGIT_X_TENS(130), // 可自定义X位置
        .DIGIT_X_ONES(142),
        .DIGIT_Y(240)
    ) d11 (
        .vga_col(vga_col),
        .vga_row(vga_row),
        .data_value(cnt11),
        .pixel_data(p11)
    );
 display_digit #(
        .DIGIT_X_TENS(158), // 可自定义X位置
        .DIGIT_X_ONES(170),
        .DIGIT_Y(240)
    ) d12 (
        .vga_col(vga_col),
        .vga_row(vga_row),
        .data_value(cnt12),
        .pixel_data(p12)
    );
    display_digit #(
        .DIGIT_X_TENS(382), 
        .DIGIT_X_ONES(394),
        .DIGIT_Y(240)
    ) d13 (
        .vga_col(vga_col),
        .vga_row(vga_row),
        .data_value(cnt13),
        .pixel_data(p13)
    );
    display_digit #(
        .DIGIT_X_TENS(410), 
        .DIGIT_X_ONES(422),
        .DIGIT_Y(240)
    ) d14 (
        .vga_col(vga_col),
        .vga_row(vga_row),
        .data_value(cnt14),
        .pixel_data(p14)
    );
     display_digit #(
        .DIGIT_X_TENS(80), // 可自定义X位置
        .DIGIT_X_ONES(92),
        .DIGIT_Y(340)
    ) d15 (
        .vga_col(vga_col),
        .vga_row(vga_row),
        .data_value(cnt15),
        .pixel_data(p15)
    );
     display_digit #(
        .DIGIT_X_TENS(80), // 可自定义X位置
        .DIGIT_X_ONES(92),
        .DIGIT_Y(360)
    ) d16 (
        .vga_col(vga_col),
        .vga_row(vga_row),
        .data_value(cnt16),
        .pixel_data(p16)
    );
    display_digit #(
        .DIGIT_X_TENS(270), // 可自定义X位置
        .DIGIT_X_ONES(282),
        .DIGIT_Y(340)
    ) d17 (
        .vga_col(vga_col),
        .vga_row(vga_row),
        .data_value(cnt17),
        .pixel_data(p17)
    );
     display_digit #(
        .DIGIT_X_TENS(270), // 可自定义X位置
        .DIGIT_X_ONES(282),
        .DIGIT_Y(360)
    ) d18 (
        .vga_col(vga_col),
        .vga_row(vga_row),
        .data_value(cnt18),
        .pixel_data(p18)
    );
    display_digit #(
        .DIGIT_X_TENS(460), // 可自定义X位置
        .DIGIT_X_ONES(472),
        .DIGIT_Y(340)
    ) d19 (
        .vga_col(vga_col),
        .vga_row(vga_row),
        .data_value(cnt19),
        .pixel_data(p19)
    );
     display_digit #(
        .DIGIT_X_TENS(460), // 可自定义X位置
        .DIGIT_X_ONES(472),
        .DIGIT_Y(360)
    ) d20 (
        .vga_col(vga_col),
        .vga_row(vga_row),
        .data_value(cnt20),
        .pixel_data(p20)
    );
        display_digit #(
        .DIGIT_X_TENS(130), 
        .DIGIT_X_ONES(142),
        .DIGIT_Y(410)
    ) d21 (
        .vga_col(vga_col),
        .vga_row(vga_row),
        .data_value(cnt21),
        .pixel_data(p21)
    );
 display_digit #(
        .DIGIT_X_TENS(158), 
        .DIGIT_X_ONES(170),
        .DIGIT_Y(410)
    ) d22 (
        .vga_col(vga_col),
        .vga_row(vga_row),
        .data_value(cnt22),
        .pixel_data(p22)
    );
    display_digit #(
        .DIGIT_X_TENS(382), 
        .DIGIT_X_ONES(394),
        .DIGIT_Y(410)
    ) d23 (
        .vga_col(vga_col),
        .vga_row(vga_row),
        .data_value(cnt23),
        .pixel_data(p23)
    );
    display_digit #(
        .DIGIT_X_TENS(410), 
        .DIGIT_X_ONES(422),
        .DIGIT_Y(410)
    ) d24 (
        .vga_col(vga_col),
        .vga_row(vga_row),
        .data_value(cnt8),
        .pixel_data(p24)
    );
    assign pixel_data=p1|p2|p3|p4|p5|p6|p7|p8|p9|p10|p11|p12|p13|p14|p15|p16|p17|p18|p19|p20|p21|p22|p23|p24;
endmodule