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
reg [3:0] digit_1; 
reg [3:0] digit_2; 
reg [3:0] digit_3; 
reg [3:0] digit_4;

// display
wire [7:0] seg;
wire [3:0] an;

// clocks
wire clk_fast;
wire clk_blink;

initial
  begin
    master_clk = 0;
    rst = 1;
    digit_1 = 3;
    digit_2 = 5;
    digit_3 = 8;
    digit_4 = 9;
    #1000 rst = 0;
    $finish;
  end

always #5 master_clk = ~master_clk;

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