`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:30:38 03/19/2013 
// Design Name: 
// Module Name:    vga640x480 
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
module vga_display(
	input wire clk,
	input wire clk_pixel,			//pixel clock: 25MHz
	input wire clk_blink, // blink clock for correct/wrong flashes
	input wire rst,			//asynchronous reset
	input [2:0] mole_position,
	input wire guess_correct,
	input wire guess_wrong,
	input [3:0] digit_1,
	input [3:0] digit_2,
	output wire hsync,		//horizontal sync out
	output wire vsync,		//vertical sync out
	output reg [2:0] red,	//red vga output
	output reg [2:0] green, //green vga output
	output reg [1:0] blue	//blue vga output
	);

// video structure constants
parameter hpixels = 800;// horizontal pixels per line
parameter vlines = 521; // vertical lines per frame
parameter hpulse = 96; 	// hsync pulse length
parameter vpulse = 2; 	// vsync pulse length
parameter hbp = 144; 	// end of horizontal back porch
parameter hfp = 784; 	// beginning of horizontal front porch
parameter vbp = 31; 		// end of vertical back porch
parameter vfp = 511; 	// beginning of vertical front porch
// active horizontal video is therefore: 784 - 144 = 640
// active vertical video is therefore: 511 - 31 = 480

parameter mole_slot_size = 100;
parameter mole_offset = 20;
parameter mole_size = 60;

parameter center_row_y_pos = 190;
parameter center_col_x_pos = 270;

parameter top_x_pos = center_col_x_pos;
parameter top_y_pos = 40;

parameter left_x_pos = 120;
parameter left_y_pos = center_row_y_pos;

parameter center_x_pos = center_col_x_pos;
parameter center_y_pos = center_row_y_pos;

parameter right_x_pos = 420;
parameter right_y_pos = center_row_y_pos;

parameter bot_x_pos = center_col_x_pos;
parameter bot_y_pos = 340;

parameter integer mole_x_poses [4:0]  = {bot_x_pos, right_x_pos, center_x_pos, left_x_pos, top_x_pos};
parameter integer mole_y_poses [4:0] = {bot_y_pos, right_y_pos, center_y_pos, left_y_pos, top_y_pos};

// Digit params

parameter digit1_x_orig = 50;
parameter digit1_y_orig = 40;

parameter digit2_x_orig = 130;
parameter digit2_y_orig = 40;

parameter digit_x_size = 60;
parameter digit_y_size = 110;

parameter digit_offset = 10;

parameter digit_y_mid = 100;


// registers for storing the horizontal & vertical counters
reg [9:0] hc;
reg [9:0] vc;

// guess signals
reg correct_on;
reg wrong_on;

// Horizontal & vertical counters --
// this is how we keep track of where we are on the screen.
// ------------------------
// Sequential "always block", which is a block that is
// only triggered on signal transitions or "edges".
// posedge = rising edge  &  negedge = falling edge
// Assignment statements can only be used on type "reg" and need to be of the "non-blocking" type: <=
always @(posedge clk_pixel or posedge rst)
begin
	// reset condition
	if (rst == 1)
	begin
		hc <= 0;
		vc <= 0;
	end
	else
	begin
		// keep counting until the end of the line
		if (hc < hpixels - 1)
			hc <= hc + 1;
		else
		// When we hit the end of the line, reset the horizontal
		// counter and increment the vertical counter.
		// If vertical counter is at the end of the frame, then
		// reset that one too.
		begin
			hc <= 0;
			if (vc < vlines - 1)
				vc <= vc + 1;
			else
				vc <= 0;
		end
		
	end
end

reg [27:0] blink_counter = 0;
parameter cutoff_blink_wrong = 100000000;
parameter cutoff_blink_correct = 10000000;

//TODO: guess correct/wrong detection
always @(posedge clk) begin
	if(rst) begin
		correct_on = 0;
		wrong_on = 0;
		blink_counter = 0;
	end
	else if (guess_correct) begin
		blink_counter = 0;
		correct_on = 1;
		wrong_on = 0;
	end
	else if (guess_wrong) begin
		blink_counter = 0;
		correct_on = 0;
		wrong_on = 1;
	end
	else begin
		if(correct_on && blink_counter == cutoff_blink_correct) begin
			correct_on = 0;
			wrong_on = 0;
		end
		else if(wrong_on && blink_counter == cutoff_blink_wrong) begin
			correct_on = 0;
			wrong_on = 0;
		end
		else begin
			blink_counter = blink_counter + 1;
		end
	end
end

// generate sync pulses (active low)
// ----------------
// "assign" statements are a quick way to
// give values to variables of type: wire
assign hsync = (hc < hpulse) ? 0:1;
assign vsync = (vc < vpulse) ? 0:1;

// display 100% saturation colorbars
// ------------------------
// Combinational "always block", which is a block that is
// triggered when anything in the "sensitivity list" changes.
// The asterisk implies that everything that is capable of triggering the block
// is automatically included in the sensitivty list.  In this case, it would be
// equivalent to the following: always @(hc, vc)
// Assignment statements can only be used on type "reg" and should be of the "blocking" type: =
always @(hc, vc)
begin
	// first check if we're within vertical active video range
	if (vc >= vbp && vc < vfp)
	begin
		// now display different colors every 80 pixels
		// while we're within the active horizontal range
		// -----------------
		if (hc >= (hbp + mole_x_poses[mole_position] + mole_offset) &&
				hc < (hbp + mole_x_poses[mole_position] + mole_size + mole_offset) &&
				vc >= (vbp + mole_y_poses[mole_position] + mole_offset) &&
				vc < (vbp + mole_y_poses[mole_position] + mole_size + mole_offset))
			begin
				setColor(3'b111, 3'b111, 2'b00);
			end
		else if (hc >= (hbp + left_x_pos) &&
				hc < (hbp + left_x_pos + mole_slot_size) &&
				vc >= (vbp + left_y_pos) &&
				vc < (vbp + left_y_pos + mole_slot_size))
			begin
				setColor(3'b111, 3'b111, 2'b11);
			end	
		else if (hc >= (hbp + center_x_pos) &&
				hc < (hbp + center_x_pos + mole_slot_size) &&
				vc >= (vbp + center_y_pos) &&
				vc < (vbp + center_y_pos + mole_slot_size))
			begin
				setColor(3'b111, 3'b111, 2'b11);
			end
		else if (hc >= (hbp + top_x_pos) &&
				hc < (hbp + top_x_pos + mole_slot_size) &&
				vc >= (vbp + top_y_pos) &&
				vc < (vbp + top_y_pos + mole_slot_size))
			begin
				setColor(3'b111, 3'b111, 2'b11);
			end
		else if (hc >= (hbp + bot_x_pos) &&
				hc < (hbp + bot_x_pos + mole_slot_size) &&
				vc >= (vbp + bot_y_pos) &&
				vc < (vbp + bot_y_pos + mole_slot_size))
			begin
				setColor(3'b111, 3'b111, 2'b11);
			end
		else if (hc >= (hbp + right_x_pos) &&
				hc < (hbp + right_x_pos + mole_slot_size) &&
				vc >= (vbp + right_y_pos) &&
				vc < (vbp + right_y_pos + mole_slot_size))
			begin
				setColor(3'b111, 3'b111, 2'b11);
			end
		else 
			// we're outside active horizontal range so display black
			begin
				setBlack();
			end
		
		drawDigit(digit_1, 0);
		drawDigit(digit_2, 1);

	end
	// we're outside active vertical range so display black
	else
	begin
		setBlack();
	end
end

task setBlack;
	begin
		red = 0;
		green = 0;
		blue = 0;
	end
endtask

task setGreen;
	begin
		red = 3'b000;
		green = 3'b111;
		blue = 2'b00;
	end
endtask

task setRed;
	begin
		red = 3'b111;
		green = 3'b000;
		blue = 2'b00;
	end
endtask

task setColor;
	input [2:0] r;
	input [2:0] g;
	input [1:0] b;

	begin
		if (correct_on)
		begin
			setGreen();
		end
		else if (wrong_on)
		begin
			setRed();
		end
		else
		begin
			red = r;
			green = g;
			blue = b;
		end
	end
endtask

task drawDigit;
	input [3:0] digit;
	input pos; // 0 - first digit, 1 - second digit

	reg [31:0] orig_x;
	reg [31:0] orig_y;

	begin
		if (pos == 0)
		begin
			orig_x = digit1_x_orig;
			orig_y = digit1_y_orig;
		end
		else
		begin
			orig_x = digit2_x_orig;
			orig_y = digit2_y_orig;
		end

		if (digit == 0) begin
			// outer rect
			if (hc >= (hbp + orig_x) &&
					hc < (hbp + orig_x + digit_x_size) &&
					vc >= (vbp + orig_y) &&
					vc < (vbp + orig_y + digit_y_size))
				begin
					setColor(3'b111, 3'b111, 2'b11);
				end
			else ;
			
			// inner rect
			if (hc >= (hbp + orig_x + digit_offset) &&
					hc < (hbp + orig_x + digit_x_size - digit_offset) &&
					vc >= (vbp + orig_y + digit_offset) &&
					vc < (vbp + orig_y + digit_y_size - digit_offset))
				begin
					setBlack();
				end
			else ;
		end
		else if (digit == 1)
		begin
		  // outer rect
			if (hc >= (hbp + orig_x) &&
					hc < (hbp + orig_x + digit_x_size) &&
					vc >= (vbp + orig_y) &&
					vc < (vbp + orig_y + digit_y_size))
				begin
					setColor(3'b111, 3'b111, 2'b11);
				end
			else ;
			
			// inner left rect
			if (hc >= (hbp + orig_x) &&
					hc < (hbp + orig_x + digit_x_size - digit_offset) &&
					vc >= (vbp + orig_y) &&
					vc < (vbp + orig_y + digit_y_size))
				begin
					setBlack();
				end
			else ;
		end
		else if (digit == 2)
		begin
			// outer rect
			if (hc >= (hbp + orig_x) &&
					hc < (hbp + orig_x + digit_x_size) &&
					vc >= (vbp + orig_y) &&
					vc < (vbp + orig_y + digit_y_size))
				begin
					setColor(3'b111, 3'b111, 2'b11);
				end
			else ;
			
			// top left inner rect
			if (hc >= (hbp + orig_x) &&
					hc < (hbp + orig_x + digit_x_size - digit_offset) &&
					vc >= (vbp + orig_y + digit_offset) &&
					vc < (vbp + digit_y_mid - digit_offset))
				begin
					setBlack();
				end
			else ;

			// bot right inner rect
			if (hc >= (hbp + orig_x + digit_offset) &&
					hc < (hbp + orig_x + digit_x_size) &&
					vc >= (vbp + digit_y_mid) &&
					vc < (vbp + orig_y + digit_y_size - digit_offset))
				begin
					setBlack();
				end
			else ;
		end
		else if (digit == 3)
		begin
			// outer rect
			if (hc >= (hbp + orig_x) &&
					hc < (hbp + orig_x + digit_x_size) &&
					vc >= (vbp + orig_y) &&
					vc < (vbp + orig_y + digit_y_size))
				begin
					setColor(3'b111, 3'b111, 2'b11);
				end
			else ;
			
			// top left inner rect
			if (hc >= (hbp + orig_x) &&
					hc < (hbp + orig_x + digit_x_size - digit_offset) &&
					vc >= (vbp + orig_y + digit_offset) &&
					vc < (vbp + digit_y_mid - digit_offset))
				begin
					setBlack();
				end
			else ;

			// bot left inner rect
			if (hc >= (hbp + orig_x) &&
					hc < (hbp + orig_x + digit_x_size - digit_offset) &&
					vc >= (vbp + digit_y_mid) &&
					vc < (vbp + orig_y + digit_y_size - digit_offset))
				begin
					setBlack();
				end
			else ;
		end
		else if (digit == 4)
		begin
			// outer rect
			if (hc >= (hbp + orig_x) &&
					hc < (hbp + orig_x + digit_x_size) &&
					vc >= (vbp + orig_y) &&
					vc < (vbp + orig_y + digit_y_size))
				begin
					setColor(3'b111, 3'b111, 2'b11);
				end
			else ;
			
			// top center inner rect
			if (hc >= (hbp + orig_x + digit_offset) &&
					hc < (hbp + orig_x + digit_x_size - digit_offset) &&
					vc >= (vbp + orig_y) &&
					vc < (vbp + digit_y_mid - digit_offset))
				begin
					setBlack();
				end
			else ;

			// bot left inner rect
			if (hc >= (hbp + orig_x) &&
					hc < (hbp + orig_x + digit_x_size - digit_offset) &&
					vc >= (vbp + digit_y_mid) &&
					vc < (vbp + orig_y + digit_y_size))
				begin
					setBlack();
				end
			else ;
		end
		else if (digit == 5)
		begin
			// outer rect
			if (hc >= (hbp + orig_x) &&
					hc < (hbp + orig_x + digit_x_size) &&
					vc >= (vbp + orig_y) &&
					vc < (vbp + orig_y + digit_y_size))
				begin
					setColor(3'b111, 3'b111, 2'b11);
				end
			else ;
			
			// top right inner rect
			if (hc >= (hbp + orig_x + digit_offset) &&
					hc < (hbp + orig_x + digit_x_size) &&
					vc >= (vbp + orig_y + digit_offset) &&
					vc < (vbp + digit_y_mid - digit_offset))
				begin
					setBlack();
				end
			else ;

			// bot left inner rect
			if (hc >= (hbp + orig_x) &&
					hc < (hbp + orig_x + digit_x_size - digit_offset) &&
					vc >= (vbp + digit_y_mid) &&
					vc < (vbp + orig_y + digit_y_size - digit_offset))
				begin
					setBlack();
				end
			else ;
		end
		else if (digit == 6)
		begin
			// outer rect
			if (hc >= (hbp + orig_x) &&
					hc < (hbp + orig_x + digit_x_size) &&
					vc >= (vbp + orig_y) &&
					vc < (vbp + orig_y + digit_y_size))
				begin
					setColor(3'b111, 3'b111, 2'b11);
				end
			else ;
			
			// top right inner rect
			if (hc >= (hbp + orig_x + digit_offset) &&
					hc < (hbp + orig_x + digit_x_size) &&
					vc >= (vbp + orig_y) &&
					vc < (vbp + digit_y_mid - digit_offset))
				begin
					setBlack();
				end
			else ;

			// bot inner rect
			if (hc >= (hbp + orig_x + digit_offset) &&
					hc < (hbp + orig_x + digit_x_size - digit_offset) &&
					vc >= (vbp + digit_y_mid) &&
					vc < (vbp + orig_y + digit_y_size - digit_offset))
				begin
					setBlack();
				end
			else ;
		end
		else if (digit == 7)
		begin
			// outer rect
			if (hc >= (hbp + orig_x) &&
					hc < (hbp + orig_x + digit_x_size) &&
					vc >= (vbp + orig_y) &&
					vc < (vbp + orig_y + digit_y_size))
				begin
					setColor(3'b111, 3'b111, 2'b11);
				end
			else ;
			
			// bot left inner rect
			if (hc >= (hbp + orig_x) &&
					hc < (hbp + orig_x + digit_x_size - digit_offset) &&
					vc >= (vbp + orig_y + digit_offset) &&
					vc < (vbp + orig_y + digit_y_size))
				begin
					setBlack();
				end
			else ;
		end
		else if (digit == 8)
		begin
			// outer rect
			if (hc >= (hbp + orig_x) &&
					hc < (hbp + orig_x + digit_x_size) &&
					vc >= (vbp + orig_y) &&
					vc < (vbp + orig_y + digit_y_size))
				begin
					setColor(3'b111, 3'b111, 2'b11);
				end
			else ;
			
			// top center inner rect
			if (hc >= (hbp + orig_x + digit_offset) &&
					hc < (hbp + orig_x + digit_x_size - digit_offset) &&
					vc >= (vbp + orig_y + digit_offset) &&
					vc < (vbp + digit_y_mid - digit_offset))
				begin
					setBlack();
				end
			else ;

			// bot center inner rect
			if (hc >= (hbp + orig_x + digit_offset) &&
					hc < (hbp + orig_x + digit_x_size - digit_offset) &&
					vc >= (vbp + digit_y_mid) &&
					vc < (vbp + orig_y + digit_y_size - digit_offset))
				begin
					setBlack();
				end
			else ;
		end
		else if (digit == 9)
		begin
			// outer rect
			if (hc >= (hbp + orig_x) &&
					hc < (hbp + orig_x + digit_x_size) &&
					vc >= (vbp + orig_y) &&
					vc < (vbp + orig_y + digit_y_size))
				begin
					setColor(3'b111, 3'b111, 2'b11);
				end
			else ;
			
			// top center inner rect
			if (hc >= (hbp + orig_x + digit_offset) &&
					hc < (hbp + orig_x + digit_x_size - digit_offset) &&
					vc >= (vbp + orig_y + digit_offset) &&
					vc < (vbp + digit_y_mid - digit_offset))
				begin
					setBlack();
				end
			else ;

			// bot left inner rect
			if (hc >= (hbp + orig_x) &&
					hc < (hbp + orig_x + digit_x_size - digit_offset) &&
					vc >= (vbp + digit_y_mid) &&
					vc < (vbp + orig_y + digit_y_size))
				begin
					setBlack();
				end
			else ;
		end	
	end
endtask

endmodule
