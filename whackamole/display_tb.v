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
module display_tb;

// system
reg master_clk;
reg rst;

// digits
output wire[3:0] digit1; 
output wire[3:0] digit2; 
output wire[3:0] digit3; 
output wire[3:0] digit4;

// display
output [7:0] seg;
output [3:0] an;

// clocks
output wire clk_fast;
output wire clk_blink;

initial
  begin
    master_clk = 0;
    rst = 1;
    digit1 = 3;
    digit2 = 5;
    digit3 = 8;
    digit4 = 9;
    #1000 rst = 0;
    $finish;
  end

always #5 master_clk = ~master_clk;

clocks clocks0 (.rst(rst), .master_clock(master_clk), .clk_fast(clk_fast), .clk_blink(clk_blink));

display display0(
  // Inputs
  .clk_fast(clk_fast),
  .clk_blink(clk_blink),
  .digit_1(digit1),
  .digit_2(digit2),
  .digit_3(digit3),
  .digit_4(digit4),
  // Outputs
  .seg(seg), .an(an)
);

endmodule