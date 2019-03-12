`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   03:52:08 03/08/2019
// Design Name:   main_no_buttons
// Module Name:   /home/ise/XilinxVM/csm152a/whackamole/main_no_buttons_tb.v
// Project Name:  whackamole
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: main_no_buttons
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module main_no_buttons_tb;

	// Inputs
	reg clk;
	reg [2:0] user_guess;
	reg eval_now;
	reg restart_game;
	

	// Outputs
	wire [7:0] score;
	wire [4:0] seconds;
	wire game_over;
	wire mole_change;
	wire guess_correct;
	wire guess_wrong;
	wire guess_now;
	wire [2:0] mole_pos;
	wire [7:0] led;
	
	

	// Instantiate the Unit Under Test (UUT)
	main_no_buttons uut (
		// Inputs
		.clk(clk), 
		.user_guess(user_guess),
		.restart_game(restart_game),
		.eval_now(eval_now), 
		// Outputs
		.mole_pos(mole_pos), 
		.mole_change(mole_change), 
		.guess_correct(guess_correct), 
		.guess_wrong(guess_wrong), 
		.guess_now(guess_now), 
		.score(score),
		.led(led),
		.seconds(seconds),
		.game_over(game_over)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		user_guess = 0;
		eval_now = 0;
		restart_game = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		// Wait 100 ns for global reset to finish
		#100;
		
		// Wait, let the mole move around
		#500000;
		
		// Guess correct
		#10000;
		user_guess = mole_pos;
		eval_now = 1;
		#10 eval_now = 0;
		
		// Wait again
		#300000;
		
		// Guess wrong
		#10000;
		user_guess = mole_pos + 1;
		eval_now = 1;
		#10 eval_now = 0;
		
		// Try to guess during block, should not work
		#30000;
		user_guess = mole_pos;
		eval_now = 1;
		#10  eval_now = 0;
		
		// Wait for game over
		#4000000;
		// Try to press button while game over
		user_guess = 2;
		eval_now = 1;
		#10 eval_now = 0;
		
		// Restart game
		#1000000;
		restart_game = 1;
		#500000;
		restart_game = 0;
		
		#120000;
		// Guess correct
		user_guess = mole_pos;
		eval_now = 1;
		#10 eval_now = 0;
		
		
		#120000;
		// Guess correct
		user_guess = mole_pos;
		eval_now = 1;
		#10 eval_now = 0;
		
		#120000;
		// Guess correct
		user_guess = mole_pos;
		eval_now = 1;
		#10 eval_now = 0;
		
		
		#120000;
		// Guess correct
		user_guess = mole_pos;
		eval_now = 1;
		#10 eval_now = 0;
		
		
		
	end
      
	always 
		#5 clk = ~clk;
		
endmodule

