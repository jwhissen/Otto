/*************************************************************************/
//	ECE 351 EXTRA CREDIT PROJECT
/*************************************************************************/
// transmission.v - Determines RPM
//
// Author: Jeffrey Whissen
// Updated: 06/03/2013
//
//	Determines the gear ratio to be applied based on inputs from switches
//
//**Inputs**//
//
//	clk					clock
//	gears				active gear
//	rpmVal				currentRPM value
//
//
//**Outputs**//
//
//	gearRatio					outputs current gear ratio
//	shift								outputs if shifted up or down
//


module transmission (
	input					clk,				//clock signal
	input 				[3:0]		gears,			//switches show what gear is active
	input					[31:0]	rpmVal,
	output			 	[7:0] 	gearRatio,			//outputs gear ratio
	output 				[1:0]		shift
);


reg [3:0] autoGear;				//stores current gear
reg [7:0] gearRev;				//stores gear ratio
reg [1:0] shifted;				//stores if a shift occurred was up or down

assign shift = shifted;
assign gearRatio = gearRev;


//Determines if the system is in automatic or manual transmission mode
always @(negedge clk)
	begin
		case(gears)
			4'b1111	: 	begin 		// Determines if the gears need to change based on current RPM
								case(autoGear)
									4'b0001	:	if(rpmVal >= 32'h800000) begin autoGear <= 4'b0010; shifted <= 2'b01; end
														else shifted <= 2'b00;
									4'b0010	:	begin if(rpmVal >= 32'h800000) begin autoGear <= 4'b0100; shifted <= 2'b01; end
														else if(rpmVal <= 32'h100) begin autoGear <= 4'b0001; shifted <= 2'b10; end 
														else shifted <= 2'b00; end 
									4'b0100	:	begin if(rpmVal >= 32'h800000) begin autoGear <= 4'b1000; shifted <= 2'b01; end
														else if(rpmVal <= 32'h100) begin autoGear <= 4'b0010; shifted <= 2'b10; end
														else shifted <= 2'b00; end
									4'b1000	:	if(rpmVal <= 32'h100) begin autoGear <= 4'b0100; shifted <= 2'b10; end
														else shifted <= 2'b00;
									default	:	begin autoGear <= 4'b0001; shifted <= 2'b00; end
								endcase
								gearRev <= ManTransmission(autoGear);
							end
			default	:	begin gearRev <= ManTransmission(gears);	autoGear <= 0; shifted <= 2'b00; end
		endcase
	end

// Details the gear ratios based on the current gear
function [7:0] ManTransmission;
	input [3:0] gears;
	begin
		case(gears)
			4'b0001 : ManTransmission = 8'd4;
			4'b0010 : ManTransmission = 8'd3;
			4'b0100 : ManTransmission = 8'd2;
			4'b1000 : ManTransmission = 8'd1;
			default : ManTransmission = 8'd25;
		endcase
	end
endfunction

	



		
endmodule
	
	
	
	
