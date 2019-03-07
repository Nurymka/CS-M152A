`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:44:32 02/28/2019 
// Design Name: 
// Module Name:    user_input 
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
module user_input(clk, btnUp, btnDown, btnLeft, btnRight, btnCenter, sw, guess_now, user_guess, rst, eval_now);

// Inputs
input clk;
input btnUp;
input btnDown;
input btnLeft;
input btnRight;
input btnCenter;
input sw;
input guess_now;

// Outputs
output reg [2:0] user_guess;
output reg rst;
output reg eval_now;

initial rst = 0;
initial eval_now = 0;
initial user_guess = 5;

// Button Debounce vars
wire [17:0] clk_dv_inc;

reg [16:0]  clk_dv;
reg         clk_en;
reg         clk_en_d;

reg [2:0]   step_U;
reg [2:0]   step_D;
reg [2:0]   step_L;
reg [2:0]   step_R;
reg [2:0]   step_C;

initial clk_dv = 0;
initial clk_en = 0;
initial clk_en_d = 0;
initial step_U[2:0] = 0;
initial step_D[2:0] = 0;
initial step_L[2:0] = 0;
initial step_R[2:0] = 0;
initial step_C[2:0] = 0;

// ===========================================================================
// timing signal for clock enable
// ===========================================================================

assign clk_dv_inc = clk_dv + 1;
   
always @ (posedge clk)
    begin
       clk_dv   <= clk_dv_inc[16:0];
       clk_en   <= clk_dv_inc[17];
       clk_en_d <= clk_en;
    end
	 
// ===========================================================================
// Instruction Stepping Control / Debouncing
// ===========================================================================

   
  wire is_btnU_posedge;
  wire is_btnD_posedge;
  wire is_btnL_posedge;
  wire is_btnR_posedge;
  wire is_btnC_posedge;
  assign is_btnU_posedge = ~ step_U[0] & step_U[1];
  assign is_btnD_posedge = ~ step_D[0] & step_D[1];
  assign is_btnL_posedge = ~ step_L[0] & step_L[1];
  assign is_btnR_posedge = ~ step_R[0] & step_R[1];
  assign is_btnC_posedge = ~ step_C[0] & step_C[1];

  always @ (posedge clk) begin
     if (clk_en) begin // Down sampling // clk_en
       step_U[2:0]  <= {btnUp, step_U[2:1]};
       step_D[2:0]  <= {btnDown, step_D[2:1]};
		 step_L[2:0]  <= {btnLeft, step_L[2:1]};
       step_R[2:0]  <= {btnRight, step_R[2:1]};
		 step_C[2:0]  <= {btnCenter, step_C[2:1]};
     end
   end
	
  always @ (posedge clk) begin
	  if (sw)
		rst <= 1;
	  else
		rst <= 0;
		
     if (clk_en_d) begin // clk_en_d
		if (guess_now) begin
			if (is_btnU_posedge) begin
				eval_now <= 1;
				user_guess <= 0;
			end else if (is_btnL_posedge) begin
				eval_now <= 1;
				user_guess <= 1;
			end else if (is_btnC_posedge) begin
				eval_now <= 1;
				user_guess <= 2;
			end else if (is_btnR_posedge) begin
				eval_now <= 1;
				user_guess <= 3;
			end else if (is_btnD_posedge) begin
				eval_now <= 1;
				user_guess <= 4;
			end else begin
				eval_now <= 0;
				user_guess <= 5;
			end
		end
	  end
	end

endmodule
