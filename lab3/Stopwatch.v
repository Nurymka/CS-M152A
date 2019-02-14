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
module Stopwatch(rst, clk, pause, seconds, minutes);

input rst;
input clk;
input pause;

output wire[5:0] seconds;
output wire[5:0] minutes;


wire clock1hz;
wire clock2hz;
wire clock_adjust;
wire clock_fast;

wire incr_minutes;
wire incr_hours;

wire clock_valid;


// Pause the clocks
assign clock_valid = ~pause & ~incr_hours;


clocks clocks0 (.rst(rst), .master_clock(clk), .in_valid(clock_valid), 
						.clock1hz(clock1hz), .clock2hz(clock2hz), .clock_adjust(clock_adjust), .clock_fast(clock_fast));
													//SIMULATION swich back to 1hz
counter60 counter_seconds (.rst(rst), .clk(clock_fast), .count_value(seconds), .increment_next(incr_minutes));
counter60 counter_minutes (.rst(rst), .clk(incr_minutes), .count_value(minutes), .increment_next(incr_hours));



endmodule

