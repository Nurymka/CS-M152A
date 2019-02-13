`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:13:13 02/12/2019 
// Design Name: 
// Module Name:    counter60 
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
module counter60(rst, clk, count_value, increment_next);

input wire rst;
input wire clk;

output reg[5:0] count_value; // 6 bits, 64 vals
output reg increment_next;

parameter cutoff = 59;

initial count_value = 0;


always @ (posedge clk) begin
	if(rst) begin
		count_value <= 0;
		increment_next <= 0;
	end
	else begin
		count_value <= count_value + 1;
		
		if(count_value == cutoff) begin
			increment_next <= 1;
			count_value <= 0;
		end
		else begin
			increment_next <= 0;
		end
	end

end

endmodule
