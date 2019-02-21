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
module Stopwatch(rst, clk, regular_mode, adjust_seconds_mode, adjust_minutes_mode, pause_mode, 
						digit1, digit2, digit3, digit4, seg, an, blink, led);


// system
input rst;
input clk;

// modes
input regular_mode; 
input adjust_seconds_mode; 
input adjust_minutes_mode; 
input pause_mode;

output wire led;

// digits
output wire[3:0] digit1; 
output wire[3:0] digit2; 
output wire[3:0] digit3; 
output wire[3:0] digit4;

// display
output [7:0] seg;
output [3:0] an;
output blink;

// clocks
wire clock1hz;
wire clock2hz;
wire clock_adjust_blink;
wire clock_fast;


// Initialize hardcoded values for board testing??
wire tmp_regular_mode = 1; 
reg tmp_adjust_seconds_mode = 0; 
reg tmp_adjust_minutes_mode = 0; 
reg tmp_pause_mode = 0;

assign tmp_regular_mode = 1;
assign led = 1;


clocks clocks0 (.rst(rst), .master_clock(clk), 
						.clock1hz(clock1hz), .clock2hz(clock2hz), .clock_adjust(clock_adjust_blink), .clock_fast(clock_fast));

totalCounter counter0 (.rst(rst), .counting_clock(clock1hz), .adjust_clock(clock2hz), 
								.regular_mode(tmp_regular_mode), .adjust_seconds_mode(tmp_adjust_seconds_mode), .adjust_minutes_mode(tmp_adjust_minutes_mode), .pause_mode(tmp_pause_mode),
								.digit1(digit1), .digit2(digit2), .digit3(digit3), .digit4(digit4));

display display0(
  // Inputs
  .clk_fast(clock_fast), .clk_adjust(clock_adjust_blink),
  .reg_mode(tmp_regular_mode), .adj_sec_mode(tmp_adjust_seconds_mode), .adj_min_mode(tmp_adjust_minutes_mode), .pause_mode(tmp_pause_mode),
  .digit_1(digit1), .digit_2(digit2), .digit_3(digit3), .digit_4(digit4),
  // Outputs
  .seg(seg), .an(an)
);


endmodule
