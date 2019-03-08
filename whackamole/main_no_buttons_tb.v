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
	reg guess_now;

	// Outputs
	wire [2:0] mole_pos;
	wire mole_change;
	wire guess_correct;
	wire guess_wrong;
	wire [7:0] led;

	// Instantiate the Unit Under Test (UUT)
	main_no_buttons uut (
		.clk(clk), 
		.user_guess(user_guess), 
		.eval_now(eval_now), 
		.mole_pos(mole_pos), 
		.mole_change(mole_change), 
		.guess_correct(guess_correct), 
		.guess_wrong(guess_wrong), 
		.guess_now(guess_now), 
		.led(led)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		user_guess = 0;
		eval_now = 0;
		guess_now = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
	always 
		clk = ~clk;
endmodule

