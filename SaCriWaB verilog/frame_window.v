`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.04.2021 13:01:41
// Design Name: 
// Module Name: frame_window
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module frame_window(
		input CLK, WDRST,WDSRVC,
		input [7:0] FWLEN,
		output reg FWOVR);

reg [7:0] q;
		 
initial begin 
FWOVR=0;
q=0;
end

always @ (posedge WDRST)
begin
	
	if(WDSRVC==1)
		begin
		q<=0;
		end
end

always @ (posedge CLK)
begin
	if(q==FWLEN)
		begin
		FWOVR<=1;
		q<=0;
		end

	else if(WDSRVC==1)
		begin
		q<=0;
		end
	
	else if(WDRST==1)
		begin
		q<=0;
		FWOVR<=0;
		end
	else
		q<=q+1;
end
endmodule	

