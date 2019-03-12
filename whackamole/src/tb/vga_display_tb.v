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
module vga_display_tb;

// system
reg master_clk;
reg rst;

// display
wire hsync;
wire vsync;
wire [2:0] red;
wire [2:0] green;
wire [1:0] blue;
reg guess_correct;
reg guess_wrong;

// mole
reg [2:0] mole_pos;

// clocks
wire clk_fast;
wire clk_blink;


initial
  begin
    master_clk = 0;
    rst = 1;
    mole_pos = 1;
    guess_correct = 1;
    guess_wrong = 0;
    #1000 rst = 0;
  end

always #5 master_clk = ~master_clk;

clocks clocks0 (.rst(rst), .master_clk(master_clk), .clk_pixel(clk_pixel), .clk_blink(clk_blink));

vga_display vga0 (
  .clk_pixel(clk_pixel),
  .clk_blink(clk_blink),
  .rst(rst),
  .mole_position(mole_pos),
  .hsync(hsync),
  .vsync(vsync),
  .red(red),
  .blue(blue),
  .green(green),
  .guess_correct(guess_correct),
  .guess_wrong(guess_wrong)
);

endmodule