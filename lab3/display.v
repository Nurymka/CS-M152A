module display(
  // Inputs
  clk_fast, clk_adjust,
  reg_mode, adj_sec_mode, adj_min_mode, pause_mode,
  digit_1, digit_2, digit_3, digit_4,
  // Outputs
  seg, an
);

input clk_fast;
input clk_adjust;

input reg_mode;
input adj_sec_mode;
input adj_min_mode;
input pause_mode;

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

// reg isOn = 1;

// always @ (posedge clk_adjust) begin
//   isOn = ~isOn;
// end

always @ (posedge clk_fast) begin
  case (cur_digit)
    2'b00: begin an_ <= 4'b0111; cur_num = digit_1; end
    2'b01: begin an_ <= 4'b1011; cur_num = digit_2; end
    2'b10: begin an_ <= 4'b1101; cur_num = digit_3; end
    2'b11: begin an_ <= 4'b1110; cur_num = digit_4; end
  endcase

  if (cur_digit == 2'b11)
    cur_digit = 2'b00;
  else
    cur_digit = cur_digit + 1;

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

  // if (adj_sec_mode && !isOn && (cur_num == digit_3 || cur_num == digit_4 )) begin
  //   seg_ = 0;
  // end else ;
end

assign seg = seg_;
assign an = an_;

endmodule // display
