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
module score_evaluation(clk, user_guess, mole_pos, eval_now, rst, mole_change, score, guess_correct, guess_wrong, guess_now);

//Inputs
input clk;
input [2:0] user_guess;
input [2:0] mole_pos;
input eval_now;
input rst;
input mole_change;

// Outputs
output reg [7:0] score;
output reg guess_correct;
output reg guess_now;
output reg guess_wrong;

initial score = 0;
initial guess_correct = 0;
initial guess_wrong = 0;
initial guess_now = 1;

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

endmodule
