`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.05.2021 11:58:12
// Design Name: 
// Module Name: downcounter_tb
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


module downcounter_tb();
localparam T=20;

reg clk,wdfail;
reg [15:0] rst_lmt;
wire rstout;

downcounter DUT(.WDFAIL(wdfail),.CLK(clk),.RST_LMT(rst_lmt),.RSTOUT(rstout));

initial 
begin
    wdfail=0;
    rst_lmt=8'h0A;    
end

always
begin
    clk=1'b1;
    #(T/2);
    clk=1'b0;
    #(T/2);
end

initial 
begin
@(negedge clk)
@(negedge clk)
#5 wdfail=1;

#165 wdfail=0;

@(negedge clk)
#5 wdfail=1;

#245 wdfail=0;
#40 $stop;

end
endmodule
