`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:18:00 03/05/2019 
// Design Name: 
// Module Name:    main 
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
module main(clk, btnUp, btnDown, btnLeft, btnRight, btnCenter, sw, led);

input clk;
input btnUp;
input btnDown;
input btnLeft;
input btnRight;
input btnCenter;
input sw;

output [7:0] led;

wire guess_now;
wire [2:0] user_guess;
wire rst;
wire eval_now;
wire guess_correct;
wire guess_wrong;
wire [2:0] mole_pos;
wire mole_change;
wire [7:0] score;

user_input user_input(.clk(clk), .btnUp(btnUp), .btnDown(btnDown), .btnLeft(btnLeft), .btnRight(btnRight), .btnCenter(btnCenter), .sw(sw), .guess_now(guess_now), 
								.user_guess(user_guess), .rst(rst), .eval_now(eval_now));

mole_position mole_position(.i_clk(clk), .i_change_position(guess_correct), .o_mole_position(mole_pos), .o_position_changed(mole_change));

score_evaluation score_evaluation(.clk(clk), .user_guess(user_guess), .mole_pos(mole_pos), .eval_now(eval_now), .rst(rst), .mole_change(mole_change), .score(score), 
								.guess_correct(guess_correct), .guess_wrong(guess_wrong), .guess_now(guess_now));
								
led_display led_display (.i_clk(clk), .i_user_guess(user_guess), .i_mole_position(mole_pos), .i_user_right(guess_correct), .i_user_wrong(guess_wrong), .leds(led));

endmodule
