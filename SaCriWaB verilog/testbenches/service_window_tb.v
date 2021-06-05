`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.05.2021 19:41:41
// Design Name: 
// Module Name: service_window_tb
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


module service_window_tb();
localparam T=20;
    
    reg clk=0,init=0;
    reg [15:0] swlen;
    wire swstat;
service_window UUT(.CLK(clk),.INIT(init),.SWLEN(swlen),.SWSTAT(swstat));
always begin
    clk=1'b1;
    #(T/2);
    clk=1'b0;
    #(T/2);
end
initial begin
    swlen=8'h06;
    init=1'b1;
end
initial begin
    @(negedge clk)
    #5 init=1'b0;
    #10 init=1'b1;
    
    @(negedge clk)
    #160;
    
    @(negedge clk)
    #5 init=1'b0;
    #10 init=1'b1;

    @(negedge clk)
    #40;
    
    @(negedge clk)
    #5 init=1'b0;
    #10 init=1'b1;
    
    @(negedge clk)
    #40;
    
    $stop;
end
endmodule
