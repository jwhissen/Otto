/*************************************************************************/
//	ECE 351 EXTRA CREDIT PROJECT
/*************************************************************************/
// ECE351_ProjectEC.v - Top level module for test RPM display
//
// Author: Jeffrey Whissen
// Updated: 06/03/2013
//
//
//**Description**//
// - Top level program implements modules to perform other duties
// - Displays current level of RPM
// - Switches represent gears, gears determine speed of change in RPM
// - RPM is constantly trending towards zero representing friction
// - Buttons represent Accelerator and Brake pedals
//
//
// 
//
//
//**Inputs**//
//
//	clock50M			50MHz system clock
//	reset				reset asserted high
//	buttons				buttons for acceleration and deceleration
//	switches			switches for gear mode
//
//
//**Outputs**//
//
//	LEDs				LED show current RPM
//
//


module ECE351_ProjectEC (
	input			CLOCK_50,		//50mhz clock
	input	[1:0]	KEY,			//buttons for acceleration and deceleration
	input	[3:0]	SW,				//switches for gear mode
	output	[7:0]	LED				//LED show current RPM
);


wire [31:0] RPM;			//connects RPM between modules

//instantiate RPM display code
displayRPM DR (
	.clk(CLOCK_50),				
	.rpm(RPM[31:0]),		
	.LEDs(LED[7:0])			//LED show current RPM
);

//instantiate RPM determination code
determineRPM AR (
	.clk(CLOCK_50),
	.gears(SW[3:0]),
	.pedals(KEY[1:0]),
	.rpm(RPM[31:0])
);



endmodule


	
	
	
	
	
