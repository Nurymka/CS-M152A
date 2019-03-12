module seven_display(
  // Inputs
  clk,
  digit_1, digit_2, digit_3, digit_4,
  // Outputs
  seg, an
);

input clk;

input [3:0] digit_1;
input [3:0] digit_2;
input [3:0] digit_3;
input [3:0] digit_4;

output [7:0] seg;
output [3:0] an;

reg [3:0] cur_num = 0;
reg [2:0] cur_digit = 0;
reg [7:0] seg_ = 0;
reg [3:0] an_ = 0;
reg[27:0] fast_counter = 0;

/////////////////////////////////
parameter cutoff_fast = 500000;  
//////////////////////////////////

assign seg = seg_;
assign an = an_;


always @ (posedge clk) begin
	if(fast_counter == cutoff_fast) begin
		// Update digit to display
		case (cur_digit)
			 2'b00: begin an_ = 4'b0111; cur_num = digit_1; end 
			 2'b01: begin an_ = 4'b1011; cur_num = digit_2; end
			 2'b10: begin an_ = 4'b1101; cur_num = digit_3; end
			 2'b11: begin an_ = 4'b1110; cur_num = digit_4; end
		endcase
		
		// Update digit value 
		case (cur_num)
			 0: seg_ = 8'b11000000;
			 1: seg_ = 8'b11111001;
			 2: seg_ = 8'b10100100;
			 3: seg_ = 8'b10110000;
			 4: seg_ = 8'b10011001;
			 5: seg_ = 8'b10010010;
			 6: seg_ = 8'b10000010;
			 7: seg_ = 8'b11111000;
			 8: seg_ = 8'b10000000;
			 9: seg_ = 8'b10010000;
		endcase
		
		// Move to next digit
		if (cur_digit == 2'b11) begin
			cur_digit = 2'b00;
		end
		else begin
			cur_digit = cur_digit + 1;
		end
		
		// Reset clock divider counter
		fast_counter = 0;
	end
	else begin
		fast_counter = fast_counter + 1;
	end
end



endmodule // display