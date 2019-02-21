`timescale 1ns / 1ps

module tb(seg, an, clk, sw);

   input clk;
   
   wire rst;

   // reg clk_rst;
   wire clk_2hz;
   wire clk_1hz;
   wire clk_fast;
   wire clk_blink;

   wire reg_mode;
   wire adj_sec_mode;
   wire adj_min_mode;
   wire pause_mode;

   wire [3:0] digit_1;
   wire [3:0] digit_2;
   wire [3:0] digit_3;
   wire [3:0] digit_4;

   input [7:0] sw;

   output [7:0] seg;
   output [3:0] an;

   assign reg_mode = sw[0];
   // initial
   //   begin
   //      master_clk = 0;
	// 	  clk_rst = 1;
   //      rst = 1;
   //      digit_1 = 0;
   //      digit_2 = 1;
   //      digit_3 = 2;
   //      digit_4 = 3;
   //      #1000 rst = 0; clk_rst = 0;
      
   //      $finish;
   //   end

   // always #5 master_clk = ~master_clk;
   
   clocks clks__(
      .rst(rst),
      .master_clock(clk),
      .clock1hz(clk_1hz),
      .clock2hz(clk_2hz),
      .clock_adjust(clk_blink),
      .clock_fast(clk_fast)
   );

   totalCounter counter0 (.rst(rst), .counting_clock(clk_1hz), .adjust_clock(clk_2hz), 
								.regular_mode(reg_mode), .adjust_seconds_mode(adj_sec_mode), .adjust_minutes_mode(adj_min_mode), .pause_mode(pause_mode),
								.digit1(digit_1), .digit2(digit_2), .digit3(digit_3), .digit4(digit_4));

   display display__(
      .clk_fast(clk_fast),
      .clk_adjust(clk_blink),
      .reg_mode(reg_mode),
      .adj_sec_mode(adj_sec_mode),
      .adj_min_mode(adj_min_mode),
      .pause_mode(pause_mode),
      .digit_1(digit_1),
      .digit_2(digit_2),
      .digit_3(digit_3),
      .digit_4(digit_4),
      .seg(seg),
      .an(an)
   );
endmodule // tb

