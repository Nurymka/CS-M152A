// Verilog Test Fixture Template

  `timescale 1 ns / 1 ps

module TEST_gate;
			
	// Inputs in the module to be tested will be port mapped to register variables
reg clk;
reg rst;

// Outputs in the module to be tested will be port mapped to wire variables

wire[5:0] seconds;
wire[5:0] minutes;


// Instantiation of the design module to be verified by the testbench
// Use named portmapping to map inputs to regsiter variables and outputs to
// wires

Stopwatch UUT (.clk(clk), .rst(rst), .seconds(seconds), .minutes(minutes));

//counter60 UUT (.rst(rst), .clk(clk), .count_value(seconds), .increment_next(incr_minute));

// IMPORTANT: Initialize all inputs. Otherwise the default value of register
// will be don't care (x).
initial
begin
	rst = 1;
	clk = 0;
		
	#15 rst = 0;
	
end

// Use an always block to generate all the test cases
always
	#5 clk=~clk;


endmodule
