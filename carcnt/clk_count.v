`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/04/09 02:04:58
// Design Name: 
// Module Name: counter_1s
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module clk_1s(clk, clk_1s);
input wire clk;
output reg clk_1s;
reg [31:0] cnt;
always @ (posedge clk) begin
   if (cnt<50_000_000) begin // need to fill
       cnt <= cnt+1'b1;// need to fill
       clk_1s<=0;
   end else begin
       clk_1s <= 1;// need to fill
       cnt <= 0;// need to fill
   end
end
endmodule

