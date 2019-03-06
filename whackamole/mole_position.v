`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:15:09 03/01/2019 
// Design Name: 
// Module Name:    mole_position 
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
module mole_position( 
    //inputs
	 i_clk, i_change_position,
	 //outputs
	 o_mole_position, o_position_changed
	 );

// signals
input i_clk;
input i_change_position;

// 1hz counter	
reg[27:0] counter_ = 0;

//**************************************************************
//**************************************************************
parameter cutoff_1hz = 1000; //SIMULATION, change back to 100000000
//**************************************************************
//**************************************************************

reg [4:0] rand_ = 15;
reg [4:0] rand_next_;


// mole position 0-4
output reg[2:0] o_mole_position = 5;
output reg o_position_changed = 0;


always @ (posedge i_clk) begin
	
	// cycle the random position array
	rand_next_[4] = rand_[4]^rand_[1];
	rand_next_[3] = rand_[3]^rand_[0];
	rand_next_[2] = rand_[2]^rand_next_[4];
	rand_next_[1] = rand_[1]^rand_next_[3];
	rand_next_[0] = rand_[0]^rand_next_[2];
	rand_ = rand_next_;
	
	// counting for 1 second
	counter_ = counter_ + 1;
	
	if(i_change_position || counter_ == cutoff_1hz) begin
		// reset 1 second counter
		counter_ = 0;
		
		// change mole position with a new random position
		o_mole_position = rand_ % 5;
		
		// signal the mole changed
		o_position_changed = 1;
		
	end
	else begin
		o_position_changed = 0;
	end
	
end

endmodule
