`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   03:16:00 03/01/2019
// Design Name:   mole_position
// Module Name:   /home/ise/XilinxVM/csm152a/whackamole/src/tb/mole_position_tb.v
// Project Name:  whackamole
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: mole_position
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module mole_position_tb;

	// Inputs
	reg clk;
	reg rst;
	reg move_mole;
	
	// Outputs
	wire[2:0] mole_pos;

	// Instantiate the Unit Under Test (UUT)
	mole_position uut (
		//inputs
		.i_clk(clk), .i_change_position(move_mole),
		//outputs
		.o_mole_position(mole_pos)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
		move_mole = 0;
		
		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		#10050;
		
		move_mole = 1;
		# 10 move_mole = 0;
		
	end
	
	// Use an always block to generate all the test cases
	always
		#5 clk=~clk;
      
endmodule

