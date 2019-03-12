`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   02:44:42 03/08/2019
// Design Name:   score_evaluation
// Module Name:   /home/ise/XilinxVM/csm152a/whackamole/score_evaluation_tb.v
// Project Name:  whackamole
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: score_evaluation
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module score_evaluation_tb;

	// Inputs
	reg clk;
	reg [2:0] user_guess;
	reg [2:0] mole_pos;
	reg eval_now;
	reg rst;
	reg mole_change;

	// Outputs
	wire [7:0] score;
	wire guess_correct;
	wire guess_wrong;
	wire guess_now;

	// Instantiate the Unit Under Test (UUT)
	score_evaluation uut (
		.clk(clk), 
		.user_guess(user_guess), 
		.mole_pos(mole_pos), 
		.eval_now(eval_now), 
		.rst(rst), 
		.mole_change(mole_change), 
		.score(score), 
		.guess_correct(guess_correct), 
		.guess_wrong(guess_wrong), 
		.guess_now(guess_now)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		user_guess = 0;
		mole_pos = 0;
		eval_now = 0;
		rst = 0;
		mole_change = 0;

		// Wait 100 ns for global reset to finish
		#100;
		
		#10000;
		mole_pos = 1;
		
		#10000;
		mole_pos = 2;
		
		#10000;
		mole_pos = 3;
		
		#10000;
		mole_pos = 4;
		#2000;
		// correct guess
		user_guess = 4;
		eval_now = 1;
		#10;
		eval_now = 0;
		
		#10000;
		mole_pos = 0;
		
		#10000;
		mole_pos = 1;
		
		#3000;
		// wrong guess
		user_guess = 2;
		eval_now = 1;
		#10;
		eval_now = 0;
		
		#7000;
		mole_pos = 2;
		#1000;
		user_guess = 2;
		eval_now = 1;
		#10;
		eval_now = 0;
		
		
		
		
		
	end
      
		
	always
		#5 clk=~clk;
		
		
endmodule

