`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:02:32 02/19/2019 
// Design Name: 
// Module Name:    totalCounter 
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
module totalCounter(rst, counting_clock, adjust_clock, regular_mode, adjust_seconds_mode, adjust_minutes_mode, pause_mode,
     digit1, digit2, digit3, digit4);

input rst;
input counting_clock; 
input adjust_clock; 
input regular_mode; 
input adjust_seconds_mode; 
input adjust_minutes_mode; 
input pause_mode;

output reg[3:0] digit1; 
output reg[3:0] digit2; 
output reg[3:0] digit3; 
output reg[3:0] digit4;


initial digit1 = 0;
initial digit2 = 0;
initial digit3 = 0;
initial digit4 = 0;

reg counter1hz = 0;

// If this clock is too slow to see the reset signal, 
// add counters to each mode, but it should be fine if we press the button slowly

always @ (posedge adjust_clock) begin
	if(rst) begin
		digit1 = 0;
		digit2 = 0;
		digit3 = 0;
		digit4 = 0;
	end
	else begin
	
		// REGULAR 1HZ COUNTING
		if(regular_mode) begin
			// do regular counting at 1hz
			if(counter1hz) begin
				// pause at 59:59
				if(digit1 == 5 && digit2 == 9 && digit3 == 5 && digit4 == 9) begin
					digit1 = 5;
					digit2 = 9;
					digit3 = 5;
					digit4 = 9;
				end
				
				// increment digit1
				else if(digit2 == 9 && digit3 == 5 && digit4 == 9) begin
					digit1 = digit1 + 1;
					digit2 = 0;
					digit3 = 0;
					digit4 = 0;
				end
				
				// increment digit2
				else if(digit3 == 5 && digit4 == 9) begin
					digit2 = digit2 + 1;
					digit3 = 0;
					digit4 = 0;
				end
				
				// increment digit3
				else if(digit4 == 9) begin
					digit3 = digit3 + 1;
					digit4 = 0;
				end
				
				// increment digit4
				else begin
					digit4 = digit4 + 1;
				end
				
			end
			// counter to slow the 2hz clock to 1hz
			counter1hz = ~counter1hz;
		end
		
		// SECONDS ADJUST MODE 2HZ COUNTING
		else if(adjust_seconds_mode) begin
			// wraparound from :59 to :01
			if(digit3 == 5 && digit4 == 9) begin
				digit3 = 0;
				digit4 = 1;
			end
			
			// wraparaound from :58 to :00
			else if(digit3 == 5 && digit4 == 8) begin
				digit3 = 0;
				digit4 = 0;
			end
			
			// wraparound from :x9 to :y1
			else if(digit4 == 9) begin
				digit3 = digit3 + 1;
				digit4 = 1;
			end
			
			// wraparound from :x8 to :y0
			else if(digit4 == 8) begin
				digit3 = digit3 + 1;
				digit4 = 0;
			end
			
			// increment right digit
			else begin
				digit4 = digit4 + 2;
			end
			
		end
		
		// MINUTES ADJUST MODE 2HZ COUNTING
		else if(adjust_minutes_mode) begin
			// wraparound from 59: to 01:
			if(digit1 == 5 && digit2 == 9) begin
				digit1 = 0;
				digit2 = 1;
			end
			
			// wraparaound from 58: to 00:
			else if(digit1 == 5 && digit2 == 8) begin
				digit1 = 0;
				digit2 = 1;
			end
			
			// increment from x8: to y0:
			else if(digit2 == 8) begin
				digit1 = digit1 + 1;
				digit2 = 0;
			end
			
			// increment from x9: to y1:
			else if(digit2 == 9) begin
				digit1 = digit1 + 1;
				digit2 = 1;
			end
			
			// increment right digit
			else begin
				digit2 = digit2 + 2;
			end
			
		end
		
		// PAUSE MODE
		else begin 
			;
		end
		
	end
end





endmodule
