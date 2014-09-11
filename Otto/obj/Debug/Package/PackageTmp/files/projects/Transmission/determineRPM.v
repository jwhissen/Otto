/*************************************************************************/
//	ECE 351 EXTRA CREDIT PROJECT
/*************************************************************************/
// determineRPM.v - Determines RPM
//
// Author: Jeffrey Whissen
// Updated: 06/03/2013
//
//  Determines the current RPM value by instantiating a transmission module and calculating off ratios returned.
//
//**Inputs**//
//
//	clk					clock
//	gears				active gear
//	pedals				acceleration and deceleration
//
//
//**Outputs**//
//
//	rpm					outputs current RPM value
//
//


module determineRPM (
	input			clk,		//clock signal
	input 	[3:0]	gears,		//switches show what gear is active
	input 	[1:0]	pedals,		//buttons show if accelerating or decelerating
	output	[31:0]	rpm			//outputs current RPM value
);


wire [7:0] gearRev;
wire [1:0] shift;


transmission TM(
	.clk(clk),				//clock signal
	.gears(gears),			//shows what gear is active
	.rpmVal(rpmVal),		//rpmValue
	.gearRatio(gearRev),			//gear ratio
	.shift(shift)			//outputs positive if shift up, negative if shift down
);


reg [31:0] rpmVal, divCnt, natDecel;			//used to determine the rate of change of the rpm

assign rpm = rpmVal;


/*Determines if the RPM is going to decrease or increase and by how much*/
always @(posedge clk)
	begin
		if (shift == 2'b01)								//shift down
			rpmVal = rpmVal >> 14;
		else if (shift == 2'b10 && rpmVal > 0) begin		//shift up
			rpmVal = rpmVal << 14;
			rpmVal = rpmVal + 14'h3FFF;
			end
		if (divCnt >= 5000000) 
			begin
				case(pedals)
					2'b01 : rpmVal = rpmVal >> 1;									//decelerate
					2'b10 : begin rpmVal = rpmVal << 1; rpmVal = rpmVal + 1; end	//accelerate
				endcase
			end // top count case
		if (natDecel >= 50000000) 
			begin
				rpmVal = rpmVal >> 1;  //this represent the natural decay of RPM due to floating friction
			end
	end

	
	
 /*Determines the rate of change.  This is partially similar to a clock divider but represents the change in RPM at values low enough to not warrant being transmitted to the rest of the system*/	
always @(negedge clk)
	begin
		if (divCnt >= 5000000) 
			begin
				divCnt <= 0;
			end 
			else begin
				divCnt <= divCnt + gearRev;
			end 
		if (natDecel >= 50000000) 
			begin
				natDecel <= 0;
			end 
			else begin
				natDecel <= natDecel + gearRev;
			end 
	end
	



		
endmodule
	
	
	
	
