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
		output reg SW_STAT);
reg [7:0] q;
		 
initial begin 
q=0;
SW_STAT=1;
end

always @ (negedge INIT)
begin
	if(INIT==0)
		begin
		SW_STAT=0;
		end
end

always @ (posedge CLK)
begin		
	if(q==SWLEN) 
		begin
		SW_STAT=1;
		q=0;
		end
		
	else if(SW_STAT==0)
	begin
	   q=q+1;
	end
	   
	else
	begin
	   q=q;
	end   
end

endmodule	
