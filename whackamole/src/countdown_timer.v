`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    05:12:08 03/08/2019 
// Design Name: 
// Module Name:    countdown_timer 
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
module countdown_timer(
	// Inputs
	clk, i_restart_game,
	// Outputs
	seconds, game_over
    );

input clk;
input i_restart_game;

output reg[4:0] seconds = 29;
output reg game_over = 0;

reg[27:0] counter_second = 0;

////////////////////////////////
////////////////////////////////
parameter cutoff_second = 10000; //SIMULATION, change back to 100,000,000
////////////////////////////////



always @ (posedge clk) begin
	if(i_restart_game) begin
		seconds = 29;
		counter_second = 0;
		game_over = 0;
	end
	else if(!game_over) begin
		if(counter_second < cutoff_second) begin
			counter_second = counter_second + 1;
		end
		else begin
			if(seconds > 0) begin
				seconds = seconds - 1;
				counter_second = 0;
			end
			else begin
				game_over = 1;
			end
		end
	end

end

endmodule
