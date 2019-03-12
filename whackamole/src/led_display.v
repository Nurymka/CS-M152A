`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:02:53 03/05/2019 
// Design Name: 
// Module Name:    ScoreEvaluation 
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
//module ScoreEvaluation(
//	//inputs
//	i_evaluate_now, i_user_guess, i_user_position,
//	//outputs
//	o_guess_now, o_guess_correct, o_score, o_leds 
 //   );


//input i_evaluate_now;
//input i_user_guess; 
//input i_user_position;
	//outputs
//output o_guess_now; 
//o_guess_correct, 
//o_score, o_leds 
//endmodule


module led_display (
	// input
	i_clk, i_restart_game, i_user_guess, i_mole_position, i_user_right, i_user_wrong, i_game_over,
	// output
	leds
	);

input wire i_clk;	
input wire i_restart_game;
input wire[2:0] i_mole_position;
input wire[2:0] i_user_guess;
input wire i_user_right;
input wire i_user_wrong;
input wire i_game_over;

reg correct_animation = 0;
reg wrong_animation = 0;
reg[27:0] animation_counter = 0;

//**************************************************************
//**************************************************************
parameter animation_cutoff = 10000; //SIMULATION, change back to 100000000
//**************************************************************
//**************************************************************
parameter correct_cutoff_1 = (animation_cutoff/5)*1;
parameter correct_cutoff_2 = animation_cutoff*2/5;
parameter correct_cutoff_3 = animation_cutoff*3/5;
parameter correct_cutoff_4 = animation_cutoff*4/5;

output reg[7:0] leds = 8'b00000000;	




// Handling guess input
always @ (posedge i_clk) begin
	// Stop all LED animations
	if(i_restart_game) begin
		correct_animation = 0;
		wrong_animation = 0;
		animation_counter = 0;
	end
	else if(i_user_right) begin
		animation_counter = 0;
		correct_animation = 1;
		wrong_animation = 0;
	end
	else if(i_user_wrong) begin
		animation_counter = 0;
		correct_animation = 0;
		wrong_animation = 1;
	end
	else begin
		if(animation_counter < animation_cutoff) begin
			animation_counter = animation_counter + 1;
		end
	end
end

always @(posedge i_clk) begin
	if(i_restart_game) begin
		leds = 8'b00000000;
	end
	else begin
		// always display user guess 
		leds[2:0] = i_user_guess;
		// always display mole position
		leds[5:3] = i_mole_position;
		// flashing animation
		if(correct_animation) begin
			if(animation_counter < animation_cutoff) begin
				if(animation_counter < correct_cutoff_1) begin //flash on
					leds[7:6] = 2'b11;
				end
				else if(animation_counter < correct_cutoff_2) begin //flash off
					leds[7:6] = 2'b00;
				end
				else if(animation_counter < correct_cutoff_3) begin //flash on
					leds[7:6] = 2'b11;
				end
				else if(animation_counter < correct_cutoff_4) begin //flash off
					leds[7:6] = 2'b00;
				end
				else begin //flash on
					leds[7:6] = 2'b11;
				end
			end
			else begin
				leds[7:6] = 2'b00;
			end
		end
		// solid animation
		else if(wrong_animation) begin
			if(animation_counter < animation_cutoff) begin
				leds[7:6] = 2'b11;
			end
			else begin
				leds[7:6] = 2'b00;
			end
		end
		// no animation
		else begin
			leds[7:6] = 2'b00;
		end
	end
end
endmodule
