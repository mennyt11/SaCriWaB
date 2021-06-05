`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.05.2021 17:26:20
// Design Name: 
// Module Name: configuration_register_tb
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


module configuration_register_tb();

localparam T=20;
 
reg [15:0] dbus;
reg [1:0] abus;
reg clk,rst;
wire wren;

wire [15:0] swlen,fwlen,rst_lmt;
wire wdsrvc;
wire init;
wire [2:0] flstat;

pattern_comparator PAT(.DBUS(dbus),.CLK(clk),.RST(rst),.WREN(wren));
configuration_register CON(.RST(rst),.CLK(clk),.WREN(wren),.ABUS(abus),.DBUS(dbus),.FWLEN(fwlen),.SWLEN(swlen),
                               .RST_LMT(rst_lmt),.WDSRVC(wdsrvc),.INIT(init),.FLSTAT(flstat));

initial
begin
    dbus=0;
    abus=0;
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
    #5 dbus=16'h0240;
    
    @(negedge clk)
    @(negedge clk)
    #5 dbus=16'h3333;
    
    @(negedge clk)
    #5 dbus=16'h4576;
    
    @(negedge clk)
    #5 dbus=16'hAAAA;
    
    @(negedge clk)
    @(negedge clk)
    @(negedge clk)
    #5 dbus=16'h5555;
    
    @(negedge clk)
    #5 dbus=16'h0100;
    abus=2'b00;
    
    @(negedge clk)
    #5 dbus=16'h000F;
       abus=2'b01;
           
    @(negedge clk)
    #5 dbus=16'h0000;
    abus=2'b10;
    
    @(negedge clk)
    #5 dbus=16'h0010;
    abus=2'b10;
    
    @(negedge clk)
    #5 dbus=16'h0018;
    abus=2'b10;
    
    @(negedge clk)
    #5 dbus=16'h0010;
    abus=2'b10;
    
    @(negedge clk)
    #5 dbus=16'h0011;
    
    @(negedge clk)
    #5 dbus=16'h1188;
    
    $stop;
end
endmodule
