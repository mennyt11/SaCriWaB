`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.05.2021 08:55:41
// Design Name: 
// Module Name: pattern_comparator_tb
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


module pattern_comparator_tb();

localparam T=20;

reg [15:0] dbus;
reg clk,rst;
wire wren;
pattern_comparator DUT(.DBUS(dbus),.CLK(clk),.RST(rst),.WREN(wren));

initial
begin
    dbus=0;
    rst=0;
end

always begin
    clk=1'b1;
    #(T/2);
    clk=1'b0;
    #(T/2);
end

initial 
begin
    @(negedge clk)
    #5 dbus=16'h1111;
    
    @(negedge clk)
    #5 dbus=16'hAAAA;
    
    @(negedge clk)
    @(negedge clk)
    #5 dbus=16'h0040;
    
    @(negedge clk)
    @(negedge clk)
    #5 dbus=16'h0133;
    
    @(negedge clk)
    #5 dbus=16'h5576;
    
    @(negedge clk)
    #5 dbus=16'hAAAA;
    
    @(negedge clk)
    @(negedge clk)
    @(negedge clk)
    #5 dbus=16'h5555;
    
    @(negedge clk)
    #5 dbus=16'h2235;
    
    @(negedge clk)
    #5 dbus=16'h1111;
    
    @(negedge clk)
    #5 dbus=16'hAB13;
    
    @(negedge clk)
    #5 dbus=16'hAA20;
    
    @(negedge clk)
    #5 dbus=16'hFF28;
    
    @(negedge clk)
    #5 dbus=16'hABCD;
    
    @(negedge clk)
    #5 dbus=16'hEEBB;
    
    @(negedge clk)
    #5 dbus=16'h2211;
    
    @(negedge clk)
    #5 dbus=16'h2188;
    
    $stop;
end
    
endmodule
