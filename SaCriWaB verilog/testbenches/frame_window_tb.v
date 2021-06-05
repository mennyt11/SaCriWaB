`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.04.2021 18:23:43
// Design Name: 
// Module Name: frame_window_tb
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

module framewindow_tb();
    localparam T=20;
    
    reg clk=0,wdrst=0,wdsrvc=0;
    reg [15:0] fwlen;
    wire fwovr;
frame_window UUT(.CLK(clk),.WDRST(wdrst),.WDSRVC(wdsrvc),.FWLEN(fwlen),.FWOVR(fwovr));
always begin
    clk=1'b1;
    #(T/2);
    clk=1'b0;
    #(T/2);
end
initial begin
fwlen=16'h0006;
wdsrvc=1'b0;
end
initial begin
    @(negedge clk)
    #140;
    
    @(negedge clk)
    wdrst=1'b1;
    #(T);
    wdrst=1'b0;
    
    @(negedge clk)
    #60;
    wdsrvc=1'b1;
    #(T);
    wdsrvc=1'b0;
    
    #10;
    $stop;
end
endmodule