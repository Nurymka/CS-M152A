// Verilog Test Fixture Template

  `timescale 1 ns / 1 ps

module TEST_gate;
			
	// Inputs in the module to be tested will be port mapped to register variables
reg clk;
reg rst;
reg pause;
reg regular;
reg adj_sec;
reg adj_min;

// Outputs in the module to be tested will be port mapped to wire variables

wire[3:0] digit1; 
wire[3:0] digit2; 
wire[3:0] digit3; 
wire[3:0] digit4;

wire [7:0] seg;
wire [3:0] an;
wire blink;

// Instantiation of the design module to be verified by the testbench
// Use named portmapping to map inputs to regsiter variables and outputs to
// wires

//Stopwatch UUT (.clk(clk), .rst(rst), .pause(pause), .seconds(seconds), .minutes(minutes));
Stopwatch UUT (.rst(rst), .clk(clk), .regular_mode(regular), .adjust_seconds_mode(adj_sec), .adjust_minutes_mode(adj_min), .pause_mode(pause), 
						.digit1(digit1), .digit2(digit2), .digit3(digit3), .digit4(digit4), .seg(seg), .an(an), .blink(blink));


//InputModule UUT ();



// IMPORTANT: Initialize all inputs. Otherwise the default value of register
// will be don't care (x).
initial
begin
	//init
	rst = 1;
	clk = 0;
	pause = 0;
	regular = 0;
	adj_sec = 0;
	adj_min = 0;		
	
	/*
	// Test display in regular mode
	#15;
	rst = 0;
	regular = 1;
	*/
	
	// Testing all of the modes directly for the counter module
	#15; 
	rst = 0;
	adj_sec = 1;
	
	#15000;
	adj_sec = 0;
	adj_min = 1;
	
	#15000;
	adj_min = 0;
	regular = 1;
	
	#30000;
	regular = 0;
	pause = 1;
	
	#15000;
	pause = 0;
	regular = 1;
	//

	
end

// Use an always block to generate all the test cases
always
	#5 clk=~clk;


endmodule
