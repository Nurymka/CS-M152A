`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:37:02 01/15/2019
// Design Name:   fpconvert
// Module Name:   /home/ise/vm_folder/lab0/nexys3/fptestbench.v
// Project Name:  nexys3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: fpconvert
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module fptestbench;

	// Outputs
	
	//wire [12:0] signmag;
	//reg [12:0] input_2s;
	// convert_to_signmag cts_uut (
	//	.input_2s_compl(input_2s),
	//	.output_signmag(signmag)
	//);
	
	wire [1:0] encoded;
	reg [3:0] decoded;
	wire valid;
	four_priority_encoder pe_uut (
		.in(decoded),
		.out(encoded),
		.valid(valid)
	);
	
	initial begin
		// Initialize Inputs

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		decoded = 4'b1100;
		
		#100;
		
		decoded = 4'b0010;
		
		#100;
		
		decoded = 4'b0000;
		
		#100;
		
		decoded = 4'b0111;
		
		#100;

	end
      
endmodule

