`timescale 1ns / 1ps

module tb;

   reg master_clk;
   
   reg clk_rst;
   wire clk_2hz;
   wire clk_1hz;
   wire clk_fast;
   wire clk_blink;

   reg reg_mode;
   reg adj_sec_mode;
   reg adj_min_mode;
   reg pause_mode;

   wire [3:0] digit_1;
   wire [3:0] digit_2;
   wire [3:0] digit_3;
   wire [3:0] digit_4;

   wire [7:0] seg;
   wire [3:0] an;

   initial
     begin
        master_clk = 0;
		  clk_rst = 1;
        reg_mode = 1;
        adj_sec_mode = 0;
        adj_min_mode = 0;
        pause_mode = 0;
      //   digit_1 = 0;
      //   digit_2 = 1;
      //   digit_3 = 2;
      //   digit_4 = 3;
      //   adj_sec_mode = 1;
        #1000 clk_rst = 0;
      
        $finish;
     end

   always #5 master_clk = ~master_clk;
   
   clocks clks__(
      .rst(clk_rst),
      .master_clock(master_clk),
      .clock1hz(clk_1hz),
      .clock2hz(clk_2hz),
      .clock_adjust(clk_blink),
      .clock_fast(clk_fast)
   );

   totalCounter counter0 (.rst(clk_rst), .counting_clock(clk_1hz), .adjust_clock(clk_2hz), 
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

