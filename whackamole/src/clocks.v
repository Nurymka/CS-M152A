`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:37:56 02/12/2019 
// Design Name: 
// Module Name:    clocks 
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
module clocks(
  // Inputs
  rst,
  master_clk,
  // Outputs
  clk_fast,
  clk_blink,
	clk_pixel);

input wire rst;
input wire master_clk;

output reg clk_fast;
output reg clk_blink;
output wire clk_pixel;

reg[27:0] ctr_fast;
reg[27:0] ctr_blink;
reg[27:0] ctr_pixel;

parameter cutoff_fast = 100000;
parameter cutoff_blink = 40000000;

assign clk_pixel = ctr_pixel[1];

always @ (posedge master_clk) begin
	if (rst) begin
		ctr_fast = 0;
		ctr_blink = 0;	
		ctr_pixel = 0;
	end
	else begin
			//SIMULATION sped up x100
			// == cutoff_adjust/100
			// if(ctr_blink == 12) begin
			if(ctr_blink == cutoff_blink) begin
				ctr_blink = 0;
				if(clk_blink == 0)
					clk_blink = 1'b1;
				else
					clk_blink = 1'b0;
			end

			//SIMULATION sped up x100
			// == cutoff_fast/100
			// if(ctr_fast == 2) begin
			if(ctr_fast == cutoff_fast) begin
				ctr_fast = 0;
				if(clk_fast == 0)
					clk_fast = 1'b1;
				else
					clk_fast = 1'b0;
			end

			// increment counters
			ctr_blink = ctr_blink + 1'b1;
			ctr_fast = ctr_fast + 1'b1;
			ctr_pixel = ctr_pixel + 1'b1;
	end
end

endmodule