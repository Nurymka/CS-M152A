// Verilog Test Fixture Template

  `timescale 1 ns / 1 ps

module TEST_gate;
			
	// Inputs in the module to be tested will be port mapped to register variables
reg clk;
reg btnUp;
reg btnDown;
reg btnRight;
reg btnLeft;
reg btnCenter;
reg sw;
wire [7:0] led;

// Instantiation of the design module to be verified by the testbench
// Use named portmapping to map inputs to regsiter variables and outputs to
// wires

main UUT (.clk(clk), .btnUp(btnUp), .btnDown(btnDown), .btnLeft(btnLeft), .btnRight(btnRight), .btnCenter(btnCenter), 
			.sw(sw), .led(led));


// IMPORTANT: Initialize all inputs. Otherwise the default value of register
// will be don't care (x).
initial
begin
	clk = 0;
	btnUp = 0;
	btnDown = 0;
	btnRight = 0;
	btnLeft = 0;
	btnCenter = 0;
	sw = 0;
	
	#15000000;
	btnUp = 1;
	#2039375;
	btnUp = 0;
	/*#15000000;
	btnDown = 1;
	#15000000;
	btnDown = 0;
	#15000000;
	guess_val = 0;
	#15000000;
	btnRight = 1;
	#15000000;
	btnRight = 0;
	#15000000;
	sw = 1;
	#15000000;
	sw = 0;*/
	
end

// Use an always block to generate all the test cases
always
	#5 clk=~clk;


endmodule
