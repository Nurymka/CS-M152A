`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:33:18 02/12/2019 
// Design Name: 
// Module Name:    Stopwatch 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module display_nexys3(
  // Inputs
  master_clk,
  sw,
  // Outputs
  seg,
  an
);

// system
input [7:0] sw;
input master_clk;

wire rst;

// display
output wire [7:0] seg;
output wire [3:0] an;

// digits
reg [3:0] digit_1 = 4; 
reg [3:0] digit_2 = 6; 
reg [3:0] digit_3 = 8; 
reg [3:0] digit_4 = 9;

// clocks
wire clk_fast;
wire clk_blink;

assign rst = sw[0];

clocks clocks0 (.rst(rst), .master_clk(master_clk), .clk_fast(clk_fast), .clk_blink(clk_blink));

display display0(
  // Inputs
  .clk_fast(clk_fast),
  .clk_blink(clk_blink),
  .digit_1(digit_1),
  .digit_2(digit_2),
  .digit_3(digit_3),
  .digit_4(digit_4),
  // Outputs
  .seg(seg), .an(an)
);

endmodule