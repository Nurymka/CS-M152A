`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:18:00 03/05/2019 
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
module main_no_buttons(
	// input
	clk, user_guess, eval_now, 
	// output
   mole_pos, mole_change, guess_correct, guess_wrong, guess_now, led);

input clk;
input[2:0] user_guess;
input eval_now;





wire rst;
output wire guess_correct;
output wire guess_wrong;
output wire [2:0] mole_pos;
output wire mole_change;
output wire guess_now;
output wire [7:0] score;
output [7:0] led;


mole_position mole_position(.i_clk(clk), .i_change_position(guess_correct), .o_mole_position(mole_pos), .o_position_changed(mole_change));

score_evaluation score_evaluation(.clk(clk), .user_guess(user_guess), .mole_pos(mole_pos), .eval_now(eval_now), .rst(rst), .mole_change(mole_change), .score(score), 
								.guess_correct(guess_correct), .guess_wrong(guess_wrong), .guess_now(guess_now));
								
led_display led_display (.i_clk(clk), .i_user_guess(user_guess), .i_mole_position(mole_pos), .i_user_right(guess_correct), .i_user_wrong(guess_wrong), .leds(led));

endmodule
