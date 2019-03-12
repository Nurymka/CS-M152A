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
module main_no_buttons(
	// input
	clk, user_guess, restart_game, eval_now, 
	// output
   mole_pos, mole_change, guess_correct, guess_wrong, guess_now, score, led, seconds, game_over);

input clk;
input[2:0] user_guess;
input restart_game;
input eval_now;


wire rst;
output wire guess_correct;
output wire guess_wrong;
output wire [2:0] mole_pos;
output wire mole_change;
output wire guess_now;
output wire [7:0] score;
output [7:0] led;
output [4:0] seconds;
output wire game_over;



//TODO: simulation to check game_over works
//TODO: simulation to check restart_game works
//TODO: clean up project files into proper folder
//TODO: upload to github

//TODO: make sure user_input module sends eval_now signal for only 1 or 2 clock cycles

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

countdown_timer countdown (
		.clk(clk), 
		.i_restart_game(restart_game), 
		.seconds(seconds), 
		.game_over(game_over)
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

endmodule
