`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:05:05 02/26/2019 
// Design Name: 
// Module Name:    main 
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
module main(clk, btnU, btnD, btnL, btnR, btnC, guess_correct, led);

input clk;
input btnU;
input btnD;
input btnL;
input btnR;
input btnC;

output reg guess_correct;
output reg [7:0] led;

initial led[7:0] = 8'b0;

initial guess_correct = 0;

reg [3:0] guess;
reg [3:0] mole;

initial guess = 5;

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
  
  reg [4:0] rand;
  reg [4:0] rand_next;
  
  initial rand [4:0] = 15;
  initial mole = rand % 5;
  
  always @* begin
	rand_next[4] = rand[4]^rand[1];
	rand_next[3] = rand[3]^rand[0];
	rand_next[2] = rand[2]^rand_next[4];
	rand_next[1] = rand[1]^rand_next[3];
	rand_next[0] = rand[0]^rand_next[2];
  end
  
  always @ (posedge clk) begin
     if (clk_en) begin // Down sampling
       step_U[2:0]  <= {btnU, step_U[2:1]};
       step_D[2:0]  <= {btnD, step_D[2:1]};
		 step_L[2:0]  <= {btnL, step_L[2:1]};
       step_R[2:0]  <= {btnR, step_R[2:1]};
		 step_C[2:0]  <= {btnC, step_C[2:1]};
     end
   end

   always @ (posedge clk)
     if (clk_en_d) begin
	   rand <= rand_next;
		if (is_btnU_posedge || is_btnD_posedge || is_btnL_posedge || is_btnR_posedge || is_btnC_posedge) begin
			if (is_btnU_posedge)
				guess <= 0;
			else if (is_btnD_posedge)
				guess <= 1;
			else if (is_btnL_posedge)
				guess <= 2;
			else if (is_btnR_posedge)
				guess <= 3;
			else if (is_btnC_posedge)
				guess <= 4;
			else
				guess <= 5;
			
			if (guess == mole) begin
				led[7:0] <= 1;
				mole <= rand%5;
				guess <= 5;
				guess_correct <= 1;
			end else begin
				led[0] <= 1;
				mole <= rand%5;
				guess <= 5;
				guess_correct <= 0;
			end
		end else 
			guess_correct <= 0;
	  end
		
endmodule
