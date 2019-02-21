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
module clocks(rst, master_clock, clock1hz, clock2hz, clock_adjust, clock_fast);

input wire rst;
input wire master_clock;

output reg clock1hz;
output reg clock2hz;
output reg clock_adjust;
output reg clock_fast;

reg[27:0] counter1hz;
reg[27:0] counter2hz;
reg[27:0] counter_adjust;
reg[27:0] counter_fast;

parameter cutoff1hz = 50000000;
parameter cutoff2hz = 25000000;
parameter cutoff_adjust = 40000000; //1.25Hz --- !!! change to 8Hz
parameter cutoff_fast = 100000; //100Hz


always @ (posedge master_clock) begin
	if (rst) begin
		counter1hz <= 0;
		counter2hz <= 0;
		counter_adjust <= 0;
		counter_fast <= 0;
		clock1hz <= 0;
		clock2hz <= 0;
		clock_adjust <= 0;
		clock_fast <= 0;
		
	end
	else begin
			// increment counters
			counter1hz <= counter1hz + 1'b1;
			counter2hz <= counter2hz + 1'b1;
			counter_adjust <= counter_adjust + 1'b1;
			counter_fast <= counter_fast + 1'b1;

			//SIMULATION sped up x100
			//== cutoff1hz/100
			 if(counter1hz == 100) begin
			//if(counter1hz == cutoff1hz) begin
				counter1hz <= 0;
				if(clock1hz == 0)
					clock1hz <= 1'b1;
				else
					clock1hz <= 1'b0;
			end

			//SIMULATION sped up x100
			//== cutoff2hz/100
			if(counter2hz == 50) begin
			//if(counter2hz == cutoff2hz) begin
				counter2hz <= 0;
				if(clock2hz == 0)
					clock2hz <= 1'b1;
				else
					clock2hz <= 1'b0;
			end

			//SIMULATION sped up x100
			//== cutoff_adjust/100
			if(counter_adjust == 12) begin
			//if(counter_adjust == cutoff_adjust) begin
				counter_adjust <= 0;
				if(clock_adjust == 0)
					clock_adjust <= 1'b1;
				else
					clock_adjust <= 1'b0;
			end

			//SIMULATION sped up x100
			// == cutoff_fast/100
			if(counter_fast == 1) begin
			//if(counter_fast == cutoff_fast) begin
				counter_fast <= 0;
				if(clock_fast == 0)
					clock_fast <= 1'b1;
				else
					clock_fast <= 1'b0;
			end
	end
end

endmodule

