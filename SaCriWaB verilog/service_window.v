`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.04.2021 13:01:41
// Design Name: 
// Module Name: service_window
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

module service_window(
		input CLK,INIT,
		input [7:0] SWLEN,
		output reg SWSTAT);
reg [7:0] q;
		 
initial begin 
q=0;
SWSTAT=1;
end

always @ (negedge INIT)
begin
	if(INIT==0)
		begin
		SWSTAT=0;
		q=0;
		end
end

always @ (posedge CLK)
begin		
	if(q==SWLEN) 
		begin
		SWSTAT=1;
		q=0;
		end
		
	else if(SWSTAT==0)
	begin
	   q=q+1;
	end
	   
	else
	begin
	   q=q;
	end   
end

endmodule	
