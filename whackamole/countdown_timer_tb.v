`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   05:26:23 03/08/2019
// Design Name:   countdown_timer
// Module Name:   /home/ise/XilinxVM/csm152a/whackamole/countdown_timer_tb.v
// Project Name:  whackamole
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: countdown_timer
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module countdown_timer_tb;

	// Inputs
	reg clk;
	reg restart_game;

	// Outputs
	wire [4:0] seconds;
	wire game_over;

	// Instantiate the Unit Under Test (UUT)
	countdown_timer uut (
		.clk(clk), 
		.restart_game(restart_game), 
		.seconds(seconds), 
		.game_over(game_over)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		restart_game = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		#4000000;
		restart_game = 1;
	end
	
	always
		#5 clk = ~clk;
      
endmodule

