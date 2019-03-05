`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:17:38 03/05/2019
// Design Name:   ScoreEvaluation
// Module Name:   /home/ise/XilinxVM/csm152a/whackamole/src/tb/LedDisplay_tb.v
// Project Name:  whackamole
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ScoreEvaluation
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module LedDisplay_tb;

	// Inputs
	reg clk;
	reg[2:0] user_guess = 0;
	reg[2:0] mole_pos = 0;
	reg user_right;
	reg user_wrong;
	
	//Outputs
	wire[7:0] leds = 0;

	// Instantiate the Unit Under Test (UUT)
	LedDisplay uut (
		.i_clk(clk), 
		.i_user_guess(user_guess), 
		.i_mole_position(mole_pos), 
		.i_user_right(user_right), 
		.i_user_wrong(user_wrong),
		// output
		.leds(leds)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		user_guess = 5;
		mole_pos = 0;
		user_right = 0;
		user_wrong = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Wrong guess
		#1000;
		user_guess = 0;
		mole_pos = 3;
		user_right = 0;
		user_wrong = 1;
		#10;
		user_wrong = 0;
		
		// Correct guess
		#10000;
		user_guess = 0;
		mole_pos = 3;
		user_right = 1;
		user_wrong = 0;
		#10;
		user_right = 0;
		
	end
	
	
	// Use an always block to generate all the test cases
	always
		#5 clk=~clk;
      
endmodule

