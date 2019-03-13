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
module vga_display_nexys3(
  // Inputs
  master_clk,
  sw,
  // Outputs
  hsync,
  vsync,
  red,
  green,
  blue
);

// system
input [7:0] sw;
input master_clk;

wire rst;

// mole
wire [2:0] mole_position;
wire guess_correct;
wire guess_wrong;
wire game_over;

wire [3:0] digit_1;
wire [3:0] digit_2;

// display
output hsync;
output vsync;
output [2:0] red;
output [2:0] green;
output [1:0] blue;

// clocks
wire clk_pixel;
wire clk_blink;

assign rst = sw[0];
assign mole_position = 0;

assign guess_correct = 0;
assign guess_wrong = 0;
assign game_over = 1;

assign digit_1 = 8;
assign digit_2 = 9;

clocks clocks0 (.rst(rst), .master_clk(master_clk), .clk_pixel(clk_pixel));

vga_display vga0 (
  .clk(master_clk),
  .clk_pixel(clk_pixel),
  .rst(rst),
  .digit_1(digit_1),
  .digit_2(digit_2),
  .mole_position(mole_position),
  .guess_correct(guess_correct),
  .guess_wrong(guess_wrong),
  .game_over(game_over), 
  .hsync(hsync),
  .vsync(vsync),
  .red(red),
  .blue(blue),
  .green(green)
);

endmodule