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

reg [7:0] dbus;
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
    #5 dbus=8'h11;
    
    @(negedge clk)
    #5 dbus=8'hAA;
    
    @(negedge clk)
    @(negedge clk)
    #5 dbus=8'h40;
    
    @(negedge clk)
    @(negedge clk)
    #5 dbus=8'h33;
    
    @(negedge clk)
    #5 dbus=8'h76;
    
    @(negedge clk)
    #5 dbus=8'hAA;
    
    @(negedge clk)
    @(negedge clk)
    @(negedge clk)
    #5 dbus=8'h55;
    
    @(negedge clk)
    #5 dbus=8'h35;
    
    @(negedge clk)
    #5 dbus=8'h11;
    
    @(negedge clk)
    #5 dbus=8'h13;
    
    @(negedge clk)
    #5 dbus=8'h20;
    
    @(negedge clk)
    #5 dbus=8'h28;
    
    @(negedge clk)
    #5 dbus=8'hAB;
    
    @(negedge clk)
    #5 dbus=8'hBB;
    
    @(negedge clk)
    #5 dbus=8'h11;
    
    @(negedge clk)
    #5 dbus=8'h88;
    
    $stop;
end
    
endmodule
