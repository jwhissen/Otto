/*************************************************************************/
//	ECE 351 EXTRA CREDIT PROJECT
/*************************************************************************/
// displayRPM.v - Displays RPM on LEDs
//
// Author: Jeffrey Whissen
// Updated: 06/03/2013
//
//
//
//**Inputs**//
//
//	clk					clock
//	rpm					Gets RPM from main 
//
//
//**Outputs**//
//
//	LEDs				LED show current RPM
//
//


module displayRPM (
	input				clk,		//clock signal
	input	  [31:0]	rpm,		//Gets RPM from main 
	output	[7:0]	LEDs		//LED show current RPM
);



reg [1:0] shift;

//shifts between 4 adjacent RPM values in the RPM input.  This gives the LED an illusion of dimming and brightening depending on if the RPM value at that LED is increasing or decreasing.
assign LEDs[0] = (shift == 0) ? rpm[0] : (shift == 1) ? rpm[1] : (shift == 0) ? rpm[2] : rpm[3];
assign LEDs[1] = (shift == 0) ? rpm[4] : (shift == 1) ? rpm[5] : (shift == 0) ? rpm[6] : rpm[7];
assign LEDs[2] = (shift == 0) ? rpm[8] : (shift == 1) ? rpm[9] : (shift == 0) ? rpm[10] : rpm[11];
assign LEDs[3] = (shift == 0) ? rpm[12] : (shift == 1) ? rpm[13] : (shift == 0) ? rpm[14] : rpm[15];
assign LEDs[4] = (shift == 0) ? rpm[16] : (shift == 1) ? rpm[17] : (shift == 0) ? rpm[18] : rpm[19];
assign LEDs[5] = (shift == 0) ? rpm[20] : (shift == 1) ? rpm[21] : (shift == 0) ? rpm[22] : rpm[23];
assign LEDs[6] = (shift == 0) ? rpm[24] : (shift == 1) ? rpm[25] : (shift == 0) ? rpm[26] : rpm[27];
assign LEDs[7] = (shift == 0) ? rpm[28] : (shift == 1) ? rpm[29] : (shift == 0) ? rpm[30] : rpm[31];

//shifts between which part of RPM is displayed
always @(posedge clk)
	case(shift)
		2'b00		:	shift <= 2'b01;
		2'b01		:	shift <= 2'b11;
		2'b11		:	shift <= 2'b10;
		2'b10		:	shift <= 2'b00;
		default	: 	shift <= 2'b00;
	endcase

endmodule