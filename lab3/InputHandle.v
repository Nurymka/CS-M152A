`timescale 1ns / 1ps

module InputHandle(rst, clk, btnR, btnP, sw, pause_vld, reset_vld, adj_vld, adj_sel);

input rst;
input clk;
input btnR;
input btnP;
input [1:0] sw;

output reg pause_vld;
output reg reset_vld;
output reg adj_vld;
output reg adj_sel;

initial pause_vld = 0;

wire [17:0] clk_dv_inc;

reg [16:0]  clk_dv;
reg         clk_en;
reg         clk_en_d;

reg [2:0]   step_r;
reg [2:0]   step_p;

// ===========================================================================
// timing signal for clock enable
// ===========================================================================

assign clk_dv_inc = clk_dv + 1;
   
always @ (posedge clk)
  if (rst)
    begin
       clk_dv   <= 0;
       clk_en   <= 1'b0;
       clk_en_d <= 1'b0;
    end
  else
    begin
       clk_dv   <= clk_dv_inc[16:0];
       clk_en   <= clk_dv_inc[17];
       clk_en_d <= clk_en;
    end
	 
// ===========================================================================
// Instruction Stepping Control / Debouncing
// ===========================================================================

   
  wire is_btnR_posedge;
  wire is_btnP_posedge;
  assign is_btnR_posedge = ~ step_r[0] & step_r[1];
  assign is_btnP_posedge = ~ step_p[0] & step_p[1];
  
  always @ (posedge clk) begin
     if (rst)
       begin
          step_r[2:0]  <= 0;
			 step_p[2:0]  <= 0;
       end
     else if (clk_en) begin // Down sampling
       step_r[2:0]  <= {btnR, step_r[2:1]};
       step_p[2:0]  <= {btnP, step_p[2:1]};
     end
   end

   always @ (posedge clk)
     if (rst) begin
       reset_vld <= 1'b0;
		 pause_vld <= 1'b0;
     end else if (clk_en_d) begin
     if (is_btnR_posedge)
      reset_vld <= 1'b1;
     else
      reset_vld <= 1'b0;
	  if (is_btnP_posedge && !adj_vld)
      pause_vld <= ~pause_vld;
    end else begin
      reset_vld <= 0;
    end

   always @ (posedge clk)
     if (rst) begin
		 adj_vld <= 0;
		 adj_sel <= 0;
     end else begin
		 adj_vld <= sw[1];
		 adj_sel <= sw[0];
	  end
	  
endmodule
