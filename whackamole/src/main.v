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
module main(
	//inputs
clk, btnUp, btnDown, btnLeft, btnRight, btnCenter, sw, 
	//outputs
led, seg, an);

input clk;
input btnUp;
input btnDown;
input btnLeft;
input btnRight;
input btnCenter;
input sw;

output [7:0] led;
output [7:0] seg;
output [3:0] an;

wire restart_game;
wire guess_now;
wire [2:0] user_guess;
wire eval_now;
wire guess_correct;
wire guess_wrong;
wire [2:0] mole_pos;
wire mole_change;
wire [7:0] score;
wire game_over;
wire [4:0] seconds;
//TODO: change seg display to show seconds countdown

wire [3:0] digit_4;
wire [3:0] digit_3;
wire [3:0] digit_2;
wire [3:0] digit_1;


/*
//TODO: change seg display to show seconds countdown
assign digit_4 = score % 10;
assign digit_3 = (score / 10) % 10;
assign digit_2 = (score / 100) % 10;
assign digit_1 = (score / 1000) % 10;
*/
assign digit_4 = seconds % 10;
assign digit_3 = (seconds / 10) % 10;
assign digit_2 = 0;
assign digit_1 = 0;


user_input user_input(
		.clk(clk), 
		.btnUp(btnUp), 
		.btnDown(btnDown), 
		.btnLeft(btnLeft), 
		.btnRight(btnRight), 
		.btnCenter(btnCenter), 
		.sw(sw),  
		.user_guess(user_guess), 
		.rst(restart_game), 
		.eval_now(eval_now)
	);


countdown_timer countdown (
		.clk(clk), 
		.i_restart_game(restart_game), 
		.seconds(seconds), 
		.game_over(game_over)
	);
	
	
mole_position mole_position(
		.i_clk(clk), 
		.i_restart_game(restart_game),
		.i_change_position(guess_correct),
		.i_game_over(game_over),
		.o_mole_position(mole_pos), 
		.o_position_changed(mole_change)
	);

score_evaluation score_evaluation(
		.clk(clk), 
		.user_guess(user_guess), 
		.mole_pos(mole_pos), 
		.eval_now(eval_now), 
		.i_restart_game(restart_game), 
		.mole_change(mole_change),
		.i_game_over(game_over),
		.score(score), 
		.guess_correct(guess_correct), 
		.guess_wrong(guess_wrong), 
		.guess_now(guess_now)
	);
								
led_display led_display (
		.i_clk(clk), 
		.i_restart_game(restart_game),
		.i_user_guess(user_guess), 
		.i_mole_position(mole_pos), 
		.i_user_right(guess_correct), 
		.i_user_wrong(guess_wrong), 
		.i_game_over(game_over),
		.leds(led)
	);

seven_display seven_display(
		.clk(clk),  
		.digit_1(digit_1), 
		.digit_2(digit_2), 
		.digit_3(digit_3), 
		.digit_4(digit_4), 
		.seg(seg), 
		.an(an)
	);


endmodule