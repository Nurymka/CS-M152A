`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:19:06 02/28/2019 
// Design Name: 
// Module Name:    score_evaluation 
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
module score_evaluation(
	//inputs
	clk, user_guess, mole_pos, eval_now, i_restart_game, mole_change, i_game_over, 
	//outputs
	score, guess_correct, guess_wrong, guess_now);

//Inputs
input clk;
input [2:0] user_guess;
input [2:0] mole_pos;
input eval_now;
input i_restart_game;
input mole_change;
input i_game_over;

// Outputs
output reg [7:0] score = 0;
output reg guess_correct = 0;
output reg guess_wrong = 0;
output reg guess_now = 1;

// Internal
reg[27:0] block_counter = 0;
reg blocked_state = 0;
////////////////////////////////////
////////////////////////////////////
parameter block_cutoff = 100000000; 
/////////////////////////////////////
///////////////////////////////////


always @ (posedge clk) begin
	// Reset the game
	if(i_restart_game) begin
		score = 0;
		guess_correct = 0;
		guess_wrong = 0;
		guess_now = 1;
		block_counter = 0;
		blocked_state = 0;
	end
	// During game play
	else if(!i_game_over) begin
		// blocked from the last incorrect guess
		if(blocked_state) begin
			// 1 second counter for blocked state
			if(block_counter < block_cutoff) begin
				block_counter = block_counter + 1;
				guess_wrong = 0;
			end
			// blocked state over, user can guess again
			else begin
				blocked_state = 0;
				guess_now = 1;
			end
		end
		// User pressed a button while not blocked
		else if(eval_now && !blocked_state) begin
			// Correct guess increases the score
			if(user_guess == mole_pos) begin
				guess_correct = 1;
				guess_wrong = 0;
				score = score + 1;
			end
			// Wrong guess blocks the user for 1 second
			else begin
				guess_correct = 0;
				guess_wrong = 1;
				guess_now = 0;
				blocked_state = 1;
				block_counter = 0;
			end
		end
		// Nothing is presed during non-blocked state
		else begin
			guess_correct = 0;
			guess_wrong = 0;
		end
	end
	// Game over
	else begin
		guess_correct = 0;
		guess_wrong = 0;
		guess_now = 0;
	end
end








/*
always @ (posedge clk) begin
	if (mole_change)
		guess_wrong = 0;
	if (rst) begin
		score = 0;
		guess_correct = 0;
		guess_now = 0;
	end else if (eval_now) begin
		guess_now = 0;
		if (mole_pos == user_guess) begin
			guess_correct = 1;
			guess_now = 1;
			score = score + 1;
		end else
			guess_wrong = 1;
	end else if (guess_wrong && !mole_change) begin
		guess_now = 0;
		guess_correct = 0;
	end else begin
		guess_now = 1;
		guess_correct =0;
	end
end
*/

endmodule