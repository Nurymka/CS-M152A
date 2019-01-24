`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:36:06 01/15/2019 
// Design Name: 
// Module Name:    fpconvert 
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
// module fpconvert(
//    );



// endmodule

module four_priority_encoder(in, out, valid);

input [3:0] in;
output wire [1:0] out;
output wire valid;

assign out[0] = in[3] | (~in[2] & in[1]);
assign out[1] = in[3] | in[2];
assign valid = in[3] | in[2] | in[1] | in[0];

endmodule

module convert_to_signmag(input_2s_compl, output_signmag);

input [12:0] input_2s_compl;
output reg [12:0] output_signmag;

always @* begin
	if (input_2s_compl[12] == 0) begin // checking the sign
		output_signmag = input_2s_compl; 
	end else begin
		output_signmag = ~input_2s_compl + 1; // TODO: edge case of most negative number
	end
end
	
endmodule